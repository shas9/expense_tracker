import 'package:bloc/bloc.dart';
import 'package:expense_tracker/data/model/ui_model/common/category_ui_model.dart';
import 'package:expense_tracker/data/repositories/data_repositoy.dart/transaction_repository.dart';
import 'package:expense_tracker/data/repositories/data_repositoy.dart/wallet_repository.dart';
import 'package:kiwi/kiwi.dart';

part 'create_expense_event.dart';
part 'create_expense_state.dart';

class CreateExpenseBloc extends Bloc<CreateExpenseEvent, CreateExpenseState> {
  final TransactionRepository _expenseRepository = KiwiContainer().resolve<TransactionRepository>();
  final WalletRepository _walletRepository = KiwiContainer().resolve<WalletRepository>();

  CreateExpenseBloc() : super(CreateExpenseInitial()) {
    on<CreateExpenseInitEvent>(onCreateExpenseInitEvent);
    on<SubmitExpenseEvent>(onSubmitExpense);
  }

  Future<void> onCreateExpenseInitEvent(
    CreateExpenseInitEvent event,
    Emitter<CreateExpenseState> emit,
  ) async {
    emit(CreateExpenseInitial());
  }

  Future<void> onSubmitExpense(
    SubmitExpenseEvent event,
    Emitter<CreateExpenseState> emit,
  ) async {
    emit(CreateExpenseLoading());

    try {
      _expenseRepository.addTransaction(
        event.title,
        event.amount,
        event.description,
        event.date,
        event.categoryUiModel.categoryId,
        event.walletId,
        event.isIncome,
      );
      
      final wallet = await _walletRepository.getWalletById(event.walletId);
      if (wallet != null) {
        _walletRepository.updateWalletBalance(wallet.id, -event.amount);
      }

      emit(CreateExpenseSuccess());
    } catch (e) {
      emit(CreateExpenseFailure(e.toString()));
    }
  }
}

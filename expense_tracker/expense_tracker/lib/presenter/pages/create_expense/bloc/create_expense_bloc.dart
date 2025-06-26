import 'package:bloc/bloc.dart';
import 'package:expense_tracker/data/model/category/category_data_model.dart';
import 'package:expense_tracker/data/repositories/expense_repository.dart';
import 'package:expense_tracker/data/repositories/wallet_repository.dart';
import 'package:kiwi/kiwi.dart';

part 'create_expense_event.dart';
part 'create_expense_state.dart';

class CreateExpenseBloc extends Bloc<CreateExpenseEvent, CreateExpenseState> {
  final ExpenseRepository _expenseRepository = KiwiContainer().resolve<ExpenseRepository>();
  final WalletRepository _walletRepository = KiwiContainer().resolve<WalletRepository>();

  CreateExpenseBloc() : super(CreateExpenseInitial()) {
    on<SubmitExpense>(_onSubmitExpense);
  }

  Future<void> _onSubmitExpense(
    SubmitExpense event,
    Emitter<CreateExpenseState> emit,
  ) async {
    emit(CreateExpenseLoading());

    try {
      _expenseRepository.addTransaction(
        event.title,
        event.amount,
        event.description,
        event.date,
        event.category.name,
        event.walletId,
        event.isIncome,
      );
      
      final wallet = _walletRepository.getWalletById(event.walletId);
      if (wallet != null) {
        _walletRepository.updateWalletBalance(wallet.id, -event.amount);
      }

      emit(CreateExpenseSuccess());
    } catch (e) {
      emit(CreateExpenseFailure(e.toString()));
    }
  }
}

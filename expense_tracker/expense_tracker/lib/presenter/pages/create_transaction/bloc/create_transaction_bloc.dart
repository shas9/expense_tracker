import 'package:bloc/bloc.dart';
import 'package:expense_tracker/data/model/ui_model/common/category_ui_model.dart';
import 'package:expense_tracker/data/model/ui_model/common/wallet_ui_model.dart';
import 'package:expense_tracker/data/repositories/data_repositoy.dart/category_repository.dart';
import 'package:expense_tracker/data/repositories/data_repositoy.dart/transaction_repository.dart';
import 'package:expense_tracker/data/repositories/data_repositoy.dart/wallet_repository.dart';
import 'package:kiwi/kiwi.dart';

part 'create_transaction_event.dart';
part 'create_transaction_state.dart';

class CreateTransactionBloc extends Bloc<CreateTransactionEvent, CreateTransactionState> {
  final _transactionRepository = KiwiContainer().resolve<TransactionRepository>();
  final _walletRepository = KiwiContainer().resolve<WalletRepository>();
  final _categoryRepository = KiwiContainer().resolve<CategoryRepository>();

  CreateTransactionBloc() : super(CreateTransactionInitial()) {
    on<CreateTransactionInitEvent>(onCreateExpenseInitEvent);
    on<SubmitTransactionEvent>(onSubmitExpense);
  }

  Future<void> onCreateExpenseInitEvent(
    CreateTransactionInitEvent event,
    Emitter<CreateTransactionState> emit,
  ) async {
    final categoryList = await _categoryRepository.getAllCategory();
    final categoryUiModelList = categoryList
        .map((category) => CategoryUiModel.fromEntity(category))
        .toList();
    emit(CategoryListLoadedState(categoryUiModelList));

    final walletList = await _walletRepository.getAllWallets();
    final wallet = event.walletId == null ? walletList.first : await _walletRepository.getWalletById(event.walletId!);
    emit(WalletListLoadedState(
      walletList.map((wallet) => WalletUiModel.fromEntity(wallet)).toList(),
    ));
    emit(SelectedWalletLoadedState(WalletUiModel.fromEntity(wallet!)));
    emit(CreateTransactionInitial());
  }

  Future<void> onSubmitExpense(
    SubmitTransactionEvent event,
    Emitter<CreateTransactionState> emit,
  ) async {
    emit(CreateExpenseLoading());

    try {
      _transactionRepository.addTransaction(
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

      emit(CreateTransactionSuccess());
    } catch (e) {
      emit(CreateTransactionFailure(e.toString()));
    }
  }
}

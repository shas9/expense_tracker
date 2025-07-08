part of 'create_transaction_bloc.dart';

sealed class CreateTransactionState {}

class CreateTransactionInitial extends CreateTransactionState {}

class CreateTransactionActionState extends CreateTransactionState {}

class CreateExpenseLoading extends CreateTransactionState {}

class CreateTransactionSuccess extends CreateTransactionActionState {}

class CreateTransactionFailure extends CreateTransactionActionState {
  final String error;

  CreateTransactionFailure(this.error);
}

class CategoryListLoadedState extends CreateTransactionActionState {
  final List<CategoryUiModel> categoryUiModelList;
  CategoryListLoadedState(this.categoryUiModelList);
}

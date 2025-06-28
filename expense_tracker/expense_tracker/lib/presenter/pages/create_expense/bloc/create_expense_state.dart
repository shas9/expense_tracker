part of 'create_expense_bloc.dart';

sealed class CreateExpenseState {}

class CreateExpenseInitial extends CreateExpenseState {}

class CreateExpenseActionState extends CreateExpenseState {}

class CreateExpenseLoading extends CreateExpenseState {}

class CreateExpenseSuccess extends CreateExpenseActionState {}

class CreateExpenseFailure extends CreateExpenseActionState {
  final String error;

  CreateExpenseFailure(this.error);
}

class CategoryListLoadedState extends CreateExpenseActionState {
  final List<CategoryUiModel> categoryUiModel;
  CategoryListLoadedState(this.categoryUiModel);
}

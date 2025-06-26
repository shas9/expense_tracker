part of 'create_expense_bloc.dart';

sealed class CreateExpenseState {}

class CreateExpenseInitial extends CreateExpenseState {}

class CreateExpenseLoading extends CreateExpenseState {}

class CreateExpenseSuccess extends CreateExpenseState {}

class CreateExpenseFailure extends CreateExpenseState {
  final String error;

  CreateExpenseFailure(this.error);
}

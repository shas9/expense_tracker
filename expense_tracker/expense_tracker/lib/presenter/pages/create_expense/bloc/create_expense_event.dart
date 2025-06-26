part of 'create_expense_bloc.dart';

sealed class CreateExpenseEvent {}

class SubmitExpense extends CreateExpenseEvent {
  final String title;
  final double amount;
  final String description;
  final DateTime date;
  final CategoryDataModel category;
  final int walletId;
  final bool isIncome;

  SubmitExpense({
    required this.title,
    required this.amount,
    required this.description,
    required this.date,
    required this.category,
    required this.walletId,
    required this.isIncome
  });
}
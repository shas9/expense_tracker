part of 'create_expense_bloc.dart';

sealed class CreateExpenseEvent {}

final class CreateExpenseInitEvent extends CreateExpenseEvent {}

final class SubmitExpenseEvent extends CreateExpenseEvent {
  final String title;
  final double amount;
  final String description;
  final DateTime date;
  final CategoryUiModel categoryUiModel;
  final int walletId;
  final bool isIncome;

  SubmitExpenseEvent({
    required this.title,
    required this.amount,
    required this.description,
    required this.date,
    required this.categoryUiModel,
    required this.walletId,
    required this.isIncome
  });
}

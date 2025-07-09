part of 'create_transaction_bloc.dart';

sealed class CreateTransactionEvent {}

final class CreateTransactionInitEvent extends CreateTransactionEvent {
  final int? walletId;
  CreateTransactionInitEvent({this.walletId});
}

final class SubmitTransactionEvent extends CreateTransactionEvent {
  final String title;
  final double amount;
  final String description;
  final DateTime date;
  final CategoryUiModel categoryUiModel;
  final int walletId;
  final bool isIncome;

  SubmitTransactionEvent({
    required this.title,
    required this.amount,
    required this.description,
    required this.date,
    required this.categoryUiModel,
    required this.walletId,
    required this.isIncome
  });
}

final class SubmitTransferEvent extends CreateTransactionEvent {
  final String title;
  final double amount;
  final String description;
  final DateTime date;
  final int fromWalletId;
  final int toWalletId;

  SubmitTransferEvent({
    required this.title,
    required this.amount,
    required this.description,
    required this.date,
    required this.fromWalletId,
    required this.toWalletId,
  });
}

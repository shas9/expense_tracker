part of 'create_wallet_bloc.dart';

sealed class CreateWalletEvent {}

class CreateWalletInitEvent extends CreateWalletEvent {}

class CreateWalletRequestedEvent extends CreateWalletEvent {
  final String name;
  final WalletTypeUiModel walletTypeUiModel;
  final double initialBalance;
  final Color walletColor;

  CreateWalletRequestedEvent({
    required this.name, 
    required this.walletTypeUiModel, 
    required this.initialBalance,
    required this.walletColor,
  });
}

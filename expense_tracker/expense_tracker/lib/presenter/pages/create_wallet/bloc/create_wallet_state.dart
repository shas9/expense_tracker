part of 'create_wallet_bloc.dart';

sealed class CreateWalletState {}

final class CreateWalletInitial extends CreateWalletState {}
final class CreateWalletActionState extends CreateWalletState {}

final class CreateWalletCloseEventState extends CreateWalletActionState {}

final class WalletTypeListLoadedState extends CreateWalletActionState {
  final List<WalletTypeUiModel> walletTypeModel;

  WalletTypeListLoadedState(this.walletTypeModel);
}

final class DisplayErrorMessage extends CreateWalletActionState {
  final String errorMessage;
  DisplayErrorMessage(this.errorMessage);
}

part of 'create_wallet_bloc.dart';

sealed class CreateWalletEvent {}

class CreateWalletRequestedEvent extends CreateWalletEvent {
  final String name;
  final String type;
  final double initialBalance;

  CreateWalletRequestedEvent({
    required this.name, 
    required this.type, 
    required this.initialBalance
  });
}

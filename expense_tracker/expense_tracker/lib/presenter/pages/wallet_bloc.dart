import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:expense_tracker/data/repositories/wallet_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realm/realm.dart';

// Wallet Events
abstract class WalletEvent extends Equatable {
  const WalletEvent();
  
  @override
  List<Object> get props => [];
}

class CreateWalletEvent extends WalletEvent {
  final String name;
  final String type;
  final double initialBalance;

  const CreateWalletEvent({
    required this.name, 
    required this.type, 
    required this.initialBalance
  });

  @override
  List<Object> get props => [name, type, initialBalance];
}

class LoadWalletsEvent extends WalletEvent {}

class DeleteWalletEvent extends WalletEvent {
  final ObjectId walletId;

  const DeleteWalletEvent(this.walletId);

  @override
  List<Object> get props => [walletId];
}

// Wallet States
abstract class WalletState extends Equatable {
  const WalletState();
  
  @override
  List<Object> get props => [];
}

class WalletInitialState extends WalletState {}

class WalletLoadingState extends WalletState {}

class WalletsLoadedState extends WalletState {
  final List<Wallet> wallets;

  const WalletsLoadedState(this.wallets);

  @override
  List<Object> get props => [wallets];
}

class WalletErrorState extends WalletState {
  final String error;

  const WalletErrorState(this.error);

  @override
  List<Object> get props => [error];
}

// Wallet BLoC
class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository walletRepository;

  WalletBloc(this.walletRepository) : super(WalletInitialState()) {
    on<CreateWalletEvent>(_onCreateWallet);
    on<LoadWalletsEvent>(_onLoadWallets);
    on<DeleteWalletEvent>(_onDeleteWallet);
  }

  void _onCreateWallet(
    CreateWalletEvent event, 
    Emitter<WalletState> emit
  ) {
    try {
      walletRepository.createWallet(
        event.name, 
        event.type, 
        event.initialBalance
      );
      
      // Reload wallets after creation
      final wallets = walletRepository.getAllWallets();
      emit(WalletsLoadedState(wallets));
    } catch (e) {
      emit(WalletErrorState(e.toString()));
    }
  }

  void _onLoadWallets(
    LoadWalletsEvent event, 
    Emitter<WalletState> emit
  ) {
    try {
      final wallets = walletRepository.getAllWallets();
      emit(WalletsLoadedState(wallets));
    } catch (e) {
      emit(WalletErrorState(e.toString()));
    }
  }

  void _onDeleteWallet(
    DeleteWalletEvent event, 
    Emitter<WalletState> emit
  ) {
    try {
      walletRepository.deleteWallet(event.walletId);
      
      // Reload wallets after deletion
      final wallets = walletRepository.getAllWallets();
      emit(WalletsLoadedState(wallets));
    } catch (e) {
      emit(WalletErrorState(e.toString()));
    }
  }
}
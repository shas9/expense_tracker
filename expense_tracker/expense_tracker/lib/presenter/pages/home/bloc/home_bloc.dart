import 'package:bloc/bloc.dart';
import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:expense_tracker/data/repositories/wallet_repository.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WalletRepository walletRepository = KiwiContainer().resolve<WalletRepository>();
  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeDataEvent>(onLoadHomeDataEvent);
  }

  Future<void> onLoadHomeDataEvent(LoadHomeDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      final wallets = walletRepository.getAllWallets();
      emit(WalletsLoadedState(wallets));
      emit(HomeLoadedState());
    } catch (e) {
      emit(HomeLoadedState());
      emit(DisplayErrorMessage(e.toString()));
    }
  }
}

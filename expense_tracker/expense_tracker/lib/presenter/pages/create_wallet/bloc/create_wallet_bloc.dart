import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/common/utilities/parser.dart';
import 'package:expense_tracker/data/model/ui_model/common/wallet_type_ui_model.dart';
import 'package:expense_tracker/data/repositories/data_repositoy.dart/wallet_repository.dart';
import 'package:expense_tracker/data/repositories/main_repository.dart';
import 'package:kiwi/kiwi.dart';

part 'create_wallet_event.dart';
part 'create_wallet_state.dart';

class CreateWalletBloc extends Bloc<CreateWalletEvent, CreateWalletState> {
  final WalletRepository walletRepository = KiwiContainer().resolve<WalletRepository>();
  final MainRepository mainRepository = KiwiContainer().resolve<MainRepository>();
  CreateWalletBloc() : super(CreateWalletInitial()) {
    on<CreateWalletInitEvent>(onCreateWalletInitEvent);
    on<CreateWalletRequestedEvent>(onCreateWalletRequestedEvent);
  }

  Future<void> onCreateWalletInitEvent(CreateWalletInitEvent event, Emitter<CreateWalletState> emit) async {
    try {
      final walletTyepList = await mainRepository.loadWalletTypeList();
      emit(WalletTypeListLoadedState(walletTyepList));
    } catch (e) {
      emit(DisplayErrorMessage(e.toString()));
    }
  }

  Future<void> onCreateWalletRequestedEvent(CreateWalletRequestedEvent event, Emitter<CreateWalletState> emit) async {
    try {
      walletRepository.createWallet(
        event.name, 
        event.type, 
        event.initialBalance,
        Parser.colorToHexWithAlpha(event.walletColor),
      );
      emit(CreateWalletCloseEventState());
    } catch (e) {
      emit(DisplayErrorMessage(e.toString()));
    }
  }
}

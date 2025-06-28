import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/common/utilities/parser.dart';
import 'package:expense_tracker/data/repositories/data_repositoy.dart/wallet_repository.dart';
import 'package:kiwi/kiwi.dart';

part 'create_wallet_event.dart';
part 'create_wallet_state.dart';

class CreateWalletBloc extends Bloc<CreateWalletEvent, CreateWalletState> {
  final WalletRepository walletRepository = KiwiContainer().resolve<WalletRepository>();
  CreateWalletBloc() : super(CreateWalletInitial()) {
    on<CreateWalletRequestedEvent>(onCreateWalletRequestedEvent);
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

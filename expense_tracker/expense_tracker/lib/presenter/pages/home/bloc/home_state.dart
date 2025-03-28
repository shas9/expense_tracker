part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeActionState extends HomeState {}

final class HomeLoadingState extends HomeState {}
final class HomeLoadedState extends HomeState {}

final class WalletsLoadedState extends HomeActionState {
  final List<Wallet> wallets;
  WalletsLoadedState(this.wallets);
}

final class DisplayErrorMessage extends HomeActionState {
  final String errorMessage;
  DisplayErrorMessage(this.errorMessage);
}

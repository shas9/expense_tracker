part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeActionState extends HomeState {}

final class HomeLoadingState extends HomeState {}
final class HomeLoadedState extends HomeState {}

final class UiModelLoadedState extends HomeActionState {
  final HomeDashboardUiModel uiModel;
  UiModelLoadedState(this.uiModel);
}

final class DisplayErrorMessage extends HomeActionState {
  final String errorMessage;
  DisplayErrorMessage(this.errorMessage);
}

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/data/model/ui_model/home/home_dashboard_ui_model.dart';
import 'package:expense_tracker/data/repositories/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository = KiwiContainer().resolve<HomeRepository>();
  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeDataEvent>(onLoadHomeDataEvent);
  }

  Future<void> onLoadHomeDataEvent(LoadHomeDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      final uiModel = await homeRepository.getDashboardUiModel();
      emit(UiModelLoadedState(uiModel));
      emit(HomeLoadedState());
    } catch (e) {
      emit(HomeLoadedState());
      emit(DisplayErrorMessage(e.toString()));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenInitial()) {
    on<SplashScreenInitEvent>(onSplashScreenInitEvent);
  }

  Future<void> onSplashScreenInitEvent(
    SplashScreenInitEvent event,
    Emitter<SplashScreenState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bool onboardingComplete =
          prefs.getBool('onboardingComplete') ?? false;

      if (onboardingComplete) {
        emit(RouteToHomeState());
      } else {
        emit(RouteToOnBoardingState());
      }
    } catch (e) {
      debugPrint('Error during splash screen initialization: $e');
    }
  }
}

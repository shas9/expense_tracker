part of 'splash_screen_bloc.dart';

sealed class SplashScreenState {}

final class SplashScreenInitial extends SplashScreenState {}

final class SplashScreenActionState extends SplashScreenState {}

final class RouteToOnBoardingState extends SplashScreenActionState {}
final class RouteToHomeState extends SplashScreenActionState {}

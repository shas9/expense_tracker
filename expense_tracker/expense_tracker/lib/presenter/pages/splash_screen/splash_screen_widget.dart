import 'package:expense_tracker/core/router/app_router.dart';
import 'package:expense_tracker/core/router/route_names.dart';
import 'package:expense_tracker/presenter/pages/splash_screen/bloc/splash_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({super.key});

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  final SplashScreenBloc _bloc = SplashScreenBloc();
  @override
  void initState() {
    FlutterNativeSplash.remove();
    _bloc.add(SplashScreenInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      body: BlocConsumer<SplashScreenBloc, SplashScreenState>(
        bloc: _bloc,
        listenWhen: (previous, current) => current is SplashScreenActionState,
        buildWhen: (previous, current) => current is! SplashScreenActionState,
        listener: (context, state) {
          if (state is RouteToOnBoardingState) {
            AppRouter.go(RouteNames.onBoarding);
          } else if (state is RouteToHomeState) {
            AppRouter.go(RouteNames.home);
          }
        },
        builder: (context, state) {
          return Container(
            color: Colors.lime,
          );
        },
      ),
    );
  }
}

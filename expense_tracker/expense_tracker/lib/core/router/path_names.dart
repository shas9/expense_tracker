import 'package:expense_tracker/core/router/app_router.dart';
import 'package:expense_tracker/core/router/route_names.dart';

class PathNames {
  static const root = splash;

  static const splash = '/${RouteNames.splash}';
  static const onBoarding = '/${RouteNames.onBoarding}';
  
  static const home = '/${RouteNames.home}';
  static const createWallet = '/${RouteNames.createWallet}';
  static const createExpense = '/${RouteNames.createExpense}/:${AppRouter.walletIdKey}';
}
import 'package:expense_tracker/core/router/path_names.dart';
import 'package:expense_tracker/core/router/route_names.dart';
import 'package:expense_tracker/presenter/pages/create_expense/create_expense_widget.dart';
import 'package:expense_tracker/presenter/pages/create_wallet/create_wallet_widget.dart';
import 'package:expense_tracker/presenter/pages/home/home_widget.dart';
import 'package:expense_tracker/presenter/pages/onboarding/onboarding_widget.dart';
import 'package:expense_tracker/presenter/pages/splash_screen/splash_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static final shellNavigatorKey = GlobalKey<NavigatorState>();

  static const walletIdKey = 'walletId';

  static final ValueNotifier<bool> navbarVisibility = ValueNotifier<bool>(true);

  static void setNavbarVisibility(bool isVisible) {
    navbarVisibility.value = isVisible;
  }

  static String? get currentTopRouteName {
    if (router.routerDelegate.currentConfiguration.isEmpty) {
      return null;
    }
    return router.routerDelegate.currentConfiguration.last.route.name;
  }

  static int getTabIndex(String name) {
    return 0;
    // if (name == PathNames.home) {
    //   return 0;
    // } else if (name == PathNames.statusBoard) {
    //   return 1;
    // } else if (name == PathNames.communication) {
    //   return 2;
    // } else if (name == PathNames.more) {
    //   return 3;
    // }
    // return 3;
  }

  static void navigate(
    String routeName, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) {
    router.pushNamed(
      routeName,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
    );
  }

  static void go(
    String routeName, {
    Map<String, String> pathParameters = const <String, String>{},
  }) {
    router.goNamed(
      routeName,
      pathParameters: pathParameters,
    );
  }

  static void replaceAndNavigate(
    String routeName, {
    Map<String, String> pathParameters = const <String, String>{},
  }) {
    router.pushReplacementNamed(
      routeName,
      pathParameters: pathParameters,
    );
  }

  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: PathNames.root,
    debugLogDiagnostics: true,
    routes: [
      // Splash Screen Route
      GoRoute(
        name: RouteNames.splash,
        path: PathNames.splash,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const NoTransitionPage(
            child: SplashScreenWidget(),
          );
        },
      ),

      // OnBoarding Route
      GoRoute(
        name: RouteNames.onBoarding,
        path: PathNames.onBoarding,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const NoTransitionPage(
            child: OnboardingWidget(),
          );
        },
      ),

      // Home Route
      GoRoute(
        name: RouteNames.home,
        path: PathNames.home,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const NoTransitionPage(
            child: HomeWidget(),
          );
        },
      ),

      // Create Expense Route
      GoRoute(
        name: RouteNames.createExpense,
        path: PathNames.createExpense,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return NoTransitionPage(
            child: CreateExpenseWidget(
              walletId: int.parse(state.pathParameters[walletIdKey]!),
            ),
          );
        },
      ),

      // Create Wallet Route
      GoRoute(
        name: RouteNames.createWallet,
        path: PathNames.createWallet,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const NoTransitionPage(
            child: CreateWalletWidget(),
          );
        },
      ),
    ],
  );
}

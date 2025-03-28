import 'package:expense_tracker/presenter/pages/create_wallet/create_wallet_widget.dart';
import 'package:expense_tracker/presenter/pages/home/home_widget.dart';
import 'package:expense_tracker/presenter/theme/app_theme.dart';
import 'package:expense_tracker/service_container.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/presenter/pages/onboarding/onboarding_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  ServiceContainer.setup();

  // Check if onboarding is completed
  final prefs = await SharedPreferences.getInstance();
  final bool onboardingComplete = prefs.getBool('onboardingComplete') ?? false;

  runApp(
    ExpenseTrackerApp(showOnboarding: !onboardingComplete),
  );
}

class ExpenseTrackerApp extends StatelessWidget {
  final bool showOnboarding;
  
  const ExpenseTrackerApp({
    super.key,
    this.showOnboarding = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: AppTheme.darkTheme,
      home: showOnboarding
          ? const OnboardingWidget()
          : const HomeWidget(),
      routes: {
        '/home': (context) => const HomeWidget(),
        '/create-wallet': (context) => const CreateWalletWidget(),
        // Add other routes as needed
      },
    );
  }
}
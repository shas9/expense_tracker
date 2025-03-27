import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:expense_tracker/data/repositories/expense_repository.dart';
import 'package:expense_tracker/data/repositories/wallet_repository.dart';
import 'package:expense_tracker/presenter/pages/create_wallet/create_wallet_page.dart';
import 'package:expense_tracker/presenter/pages/home/home_page.dart';
import 'package:expense_tracker/presenter/pages/wallet_bloc.dart';
import 'package:expense_tracker/presenter/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm/realm.dart';

void main() {
  // Initialize Realm configuration
  final config = Configuration.local([
    Wallet.schema, 
    Expense.schema, 
    Category.schema
  ]);
  
  // Create Realm instance
  final realm = Realm(config);

  runApp(
    MultiProvider(
      providers: [
        // Provide Realm instance
        Provider<Realm>.value(value: realm),
        
        // Provide Repositories
        Provider<WalletRepository>(
          create: (context) => WalletRepository(realm),
        ),
        Provider<ExpenseRepository>(
          create: (context) => ExpenseRepository(realm),
        ),
        
        // Provide BLoCs
        BlocProvider<WalletBloc>(
          create: (context) => WalletBloc(
            context.read<WalletRepository>()
          ),
        ),
      ],
      child: const ExpenseTrackerApp(),
    ),
  );
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: AppTheme.darkTheme,
      home: MultiBlocProvider(
        providers: [
          // Add any additional BLoCs here if needed
          BlocProvider.value(
            value: context.read<WalletBloc>(),
          ),
        ],
        child: const HomePage(),
      ),
      routes: {
        '/create-wallet': (context) => const CreateWalletPage(),
        // Add other routes as needed
      },
    );
  }
}
import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:expense_tracker/data/repositories/expense_repository.dart';
import 'package:expense_tracker/data/repositories/wallet_repository.dart';
import 'package:expense_tracker/data/wrapper/shared_preference_wrapper.dart';
import 'package:expense_tracker/presenter/pages/create_expense/bloc/create_expense_bloc.dart';
import 'package:expense_tracker/presenter/pages/create_wallet/bloc/create_wallet_bloc.dart';
import 'package:expense_tracker/presenter/pages/home/bloc/home_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:realm/realm.dart';

class ServiceContainer {
  static void setup() {
    final KiwiContainer container = KiwiContainer();

    // Network
    // container.registerInstance(DioClient());

    final config =
        Configuration.local([Wallet.schema, Expense.schema, Category.schema]);

    // Database
    container.registerInstance(Realm(config));

    // Local storage
    container.registerInstance(SharedPreferencesWrapper());

    // Register Repositories
    container.registerSingleton<WalletRepository>((c) => WalletRepositoryImpl(
          realm: container.resolve<Realm>(),
        ));
    container.registerSingleton<ExpenseRepository>((c) => ExpenseRepositoryImpl(
          realm: container.resolve<Realm>(),
        ));

    // Register Bloc
    container.registerInstance(HomeBloc());
    container.registerInstance(CreateWalletBloc());
    container.registerInstance(CreateExpenseBloc());
  }
}

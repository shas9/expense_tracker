import 'package:expense_tracker/data/repositories/transaction_repository.dart';
import 'package:expense_tracker/data/repositories/home_repository.dart';
import 'package:expense_tracker/data/repositories/wallet_repository.dart';
import 'package:expense_tracker/data/service/realm_database_service.dart';
import 'package:expense_tracker/data/wrapper/shared_preference_wrapper.dart';
import 'package:expense_tracker/presenter/pages/create_expense/bloc/create_expense_bloc.dart';
import 'package:expense_tracker/presenter/pages/create_wallet/bloc/create_wallet_bloc.dart';
import 'package:expense_tracker/presenter/pages/home/bloc/home_bloc.dart';
import 'package:kiwi/kiwi.dart';

class ServiceContainer {
  static void setup() {
    final KiwiContainer container = KiwiContainer();

    // Network
    // container.registerInstance(DioClient());

    // Database
    container.registerSingleton<RealmDatabaseService>(
      (container) => RealmDatabaseServiceImpl(),
    );

    // Local storage
    container.registerInstance(SharedPreferencesWrapper());

    // Register Repositories
    container.registerSingleton<WalletRepository>(
      (container) => WalletRepositoryImpl(
        realmDatabaseService: container.resolve<RealmDatabaseService>(),
      ),
    );
    container.registerSingleton<TransactionRepository>(
      (container) => ExpenseRepositoryImpl(
        realmDatabaseService: container.resolve<RealmDatabaseService>(),
      ),
    );
    container.registerSingleton<HomeRepository>(
      (container) => HomeRepositoryImpl(
          expenseRepository: container.resolve<TransactionRepository>(),
          walletRepository: container.resolve<WalletRepository>()),
    );

    // Register Bloc
    container.registerInstance(HomeBloc());
    container.registerInstance(CreateWalletBloc());
    container.registerInstance(CreateExpenseBloc());
  }
}

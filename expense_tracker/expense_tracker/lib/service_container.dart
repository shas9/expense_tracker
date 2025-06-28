import 'package:expense_tracker/data/repositories/data_repositoy.dart/category_repository.dart';
import 'package:expense_tracker/data/repositories/data_repositoy.dart/transaction_repository.dart';
import 'package:expense_tracker/data/repositories/home_repository.dart';
import 'package:expense_tracker/data/repositories/data_repositoy.dart/wallet_repository.dart';
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
      (container) => TransactionRepositoryImpl(
        realmDatabaseService: container.resolve<RealmDatabaseService>(),
      ),
    );
    container.registerSingleton<CategoryRepository>(
      (container) => CategoryRepositoryImpl(
        realmDatabaseService: container.resolve<RealmDatabaseService>(),
      ),
    );
    container.registerSingleton<HomeRepository>(
      (container) => HomeRepositoryImpl(
        transactionRepository: container.resolve<TransactionRepository>(),
        walletRepository: container.resolve<WalletRepository>(),
        categoryRepository: container.resolve<CategoryRepository>(),
      ),
    );

    // Register Bloc
    container.registerInstance(HomeBloc());
    container.registerInstance(CreateWalletBloc());
    container.registerInstance(CreateExpenseBloc());
  }
}

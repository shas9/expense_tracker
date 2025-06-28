import 'package:expense_tracker/data/model/ui_model/home_dashboard_ui_model.dart';
import 'package:expense_tracker/data/repositories/transaction_repository.dart';
import 'package:expense_tracker/data/repositories/wallet_repository.dart';

abstract class HomeRepository {
  Future <HomeDashboardUiModel> getDashboardUiModel();
}

class HomeRepositoryImpl extends HomeRepository {
  final TransactionRepository expenseRepository;
  final WalletRepository walletRepository;

  HomeRepositoryImpl({
    required this.expenseRepository,
    required this.walletRepository,
  });
  
  @override
  Future<HomeDashboardUiModel> getDashboardUiModel() {
    // TODO: implement getDashboardUiModel
    throw UnimplementedError();
  }
}

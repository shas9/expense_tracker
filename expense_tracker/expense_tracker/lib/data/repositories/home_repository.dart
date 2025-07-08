import 'package:expense_tracker/data/model/ui_model/common/category_ui_model.dart';
import 'package:expense_tracker/data/model/ui_model/common/transaction_category_ui_model.dart';
import 'package:expense_tracker/data/model/ui_model/common/wallet_ui_model.dart';
import 'package:expense_tracker/data/model/ui_model/home/home_dashboard_ui_model.dart';
import 'package:expense_tracker/data/repositories/data_repositoy.dart/category_repository.dart';
import 'package:expense_tracker/data/repositories/data_repositoy.dart/transaction_repository.dart';
import 'package:expense_tracker/data/repositories/data_repositoy.dart/wallet_repository.dart';

abstract class HomeRepository {
  Future<HomeDashboardUiModel> getDashboardUiModel();
}

class HomeRepositoryImpl extends HomeRepository {
  final TransactionRepository transactionRepository;
  final WalletRepository walletRepository;
  final CategoryRepository categoryRepository;

  HomeRepositoryImpl({
    required this.transactionRepository,
    required this.walletRepository,
    required this.categoryRepository,
  });

  @override
  Future<HomeDashboardUiModel> getDashboardUiModel() async {
    try {
      final walletList = await walletRepository.getAllWallets();
      final categoryList = await categoryRepository.getAllCategory();
      final transactionSummary =
          await transactionRepository.getTransactionSummary(walletList);

      final walletUiModels = walletList.map(WalletUiModel.fromEntity).toList();
      final categoryMap = {for (var c in categoryList) c.id: c};

      // Convert transaction categories to UI models with proper error handling
      final transactionCategoryUiModels =
          transactionSummary.transactionCategoryDataModel.map((summary) {
        final category = categoryMap[summary.categoryId];
        return TransactionCategoryUiModel.fromDataModel(
          summary,
          category == null
              ? CategoryUiModel.getDefault()
              : CategoryUiModel.fromEntity(category),
        );
      }).toList();

      return HomeDashboardUiModel(
        currentBalance: transactionSummary.currentBalance,
        totalIncome: transactionSummary.totalIncome,
        totalExpense: transactionSummary.totalExpense,
        walletModelList: walletUiModels,
        transactionCategoryModelList: transactionCategoryUiModels,
      );
    } catch (e) {
      throw Exception('Failed to load dashboard data: $e');
    }
  }
}

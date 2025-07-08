import 'package:expense_tracker/data/model/data_model/transaction/transaction_category_data_model.dart';
import 'package:expense_tracker/data/model/ui_model/common/category_ui_model.dart';

class TransactionCategoryUiModel {
  final int categoryId;
  final double categoryCostAmount;
  final CategoryUiModel categoryUIModel;

  TransactionCategoryUiModel({
    required this.categoryId,
    required this.categoryCostAmount,
    required this.categoryUIModel,
  });

  factory TransactionCategoryUiModel.fromDataModel(
    TransactionCategoryDataModel dataModel,
    CategoryUiModel categoryUIModel
  ) {
    return TransactionCategoryUiModel(
      categoryId: dataModel.categoryId,
      categoryCostAmount: dataModel.categoryCostAmount,
      categoryUIModel: categoryUIModel,
    );
  }
}
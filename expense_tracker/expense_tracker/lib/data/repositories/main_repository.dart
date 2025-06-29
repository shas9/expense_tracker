import 'package:expense_tracker/data/model/ui_model/common/wallet_type_ui_model.dart';
import 'package:expense_tracker/data/repositories/data_repositoy.dart/category_repository.dart';
import 'package:flutter/material.dart';

abstract class MainRepository {
  Future<void> loadInitialData();
  Future<List<WalletTypeUiModel>> loadWalletTypeList();
}

class MainRepositoryImpl extends MainRepository {
  final CategoryRepository categoryRepository;

  MainRepositoryImpl({
    required this.categoryRepository,
  });

  @override
  Future<void> loadInitialData() async {
    await loadCategoryData();
  }

  @override
  Future<List<WalletTypeUiModel>> loadWalletTypeList() async {
    return [
      WalletTypeUiModel(
        id: 1,
        name: 'Cash',
        icon: Icons.money,
        color: Colors.green,
      ),
      WalletTypeUiModel(
        id: 2,
        name: 'Bank Account',
        icon: Icons.account_balance,
        color: Colors.blue,
      ),
      WalletTypeUiModel(
        id: 3,
        name: 'Credit Card',
        icon: Icons.credit_card,
        color: Colors.purple,
      ),
      WalletTypeUiModel(
        id: 4,
        name: 'Mobile Banking',
        icon: Icons.phone_iphone,
        color: Colors.orange,
      ),
    ];
  }

  // MARK: Private Method

  Future<void> loadCategoryData() async {
    await categoryRepository.createCategory(
      name: 'Food',
      icon: '🍔',
      colorCode: '0xFF4CAF50', // Green
    );

    await categoryRepository.createCategory(
      name: 'Transport',
      icon: '🚗',
      colorCode: '0xFF2196F3', // Blue
    );

    await categoryRepository.createCategory(
      name: 'Shopping',
      icon: '🛍️',
      colorCode: '0xFF9C27B0', // Purple
    );

    await categoryRepository.createCategory(
      name: 'Entertainment',
      icon: '🎬',
      colorCode: '0xFFF44336', // Red
    );

    await categoryRepository.createCategory(
      name: 'Utilities',
      icon: '💡',
      colorCode: '0xFFFF9800', // Orange
    );

    await categoryRepository.createCategory(
      name: 'Health',
      icon: '🏥',
      colorCode: '0xFFE91E63', // Pink
    );
  }
}

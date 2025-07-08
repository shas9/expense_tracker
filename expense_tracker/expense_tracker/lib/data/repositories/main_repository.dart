import 'package:expense_tracker/data/model/ui_model/common/wallet_type_ui_model.dart';
import 'package:expense_tracker/data/repositories/data_repositoy.dart/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class MainRepository {
  Future<void> loadInitialData();
  List<WalletTypeUiModel> getWalletTypeList();
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
  List<WalletTypeUiModel> getWalletTypeList() {
    return [
      WalletTypeUiModel(
        id: 1,
        name: 'General',
        icon: FontAwesomeIcons.folder,
        color: Colors.teal,
      ),
      WalletTypeUiModel(
        id: 2,
        name: 'Cash',
        icon: FontAwesomeIcons.coins,
        color: Colors.green,
      ),
      WalletTypeUiModel(
        id: 3,
        name: 'Bank Account',
        icon: FontAwesomeIcons.buildingColumns,
        color: Colors.blue,
      ),
      WalletTypeUiModel(
        id: 4,
        name: 'Credit Card',
        icon: FontAwesomeIcons.creditCard,
        color: Colors.purple,
      ),
      WalletTypeUiModel(
        id: 5,
        name: 'Mobile Banking',
        icon: FontAwesomeIcons.mobileScreen,
        color: Colors.orange,
      ),
      WalletTypeUiModel(
        id: 6,
        name: 'Saving account',
        icon: FontAwesomeIcons.piggyBank,
        color: Colors.yellowAccent,
      ),
    ];
  }

  // MARK: Private Method

  Future<void> loadCategoryData() async {
    // Expense Categories
    await categoryRepository.createCategory(
      name: 'Food',
      icon: 'food',
      isExpenseCategory: true,
      colorCode: '#4CAF50', // Green
    );

    await categoryRepository.createCategory(
      name: 'Transport',
      icon: 'car',
      isExpenseCategory: true,
      colorCode: '#2196F3', // Blue
    );

    await categoryRepository.createCategory(
      name: 'Shopping',
      icon: 'shopping',
      isExpenseCategory: true,
      colorCode: '#9C27B0', // Purple
    );

    await categoryRepository.createCategory(
      name: 'Entertainment',
      icon: 'film',
      isExpenseCategory: true,
      colorCode: '#F44336', // Red
    );

    await categoryRepository.createCategory(
      name: 'Utilities',
      icon: 'utilities',
      isExpenseCategory: true,
      colorCode: '#FF9800', // Orange
    );

    await categoryRepository.createCategory(
      name: 'Health',
      icon: 'health',
      isExpenseCategory: true,
      colorCode: '#E91E63', // Pink
    );

    await categoryRepository.createCategory(
      name: 'Bills',
      icon: 'bills',
      isExpenseCategory: true,
      colorCode: '#FFEB3B', // Yellow
    );

    await categoryRepository.createCategory(
      name: 'Transportation',
      icon: 'transportation',
      isExpenseCategory: true,
      colorCode: '#607D8B', // Blue Grey
    );

    await categoryRepository.createCategory(
      name: 'Home',
      icon: 'home',
      isExpenseCategory: true,
      colorCode: '#795548', // Brown
    );

    await categoryRepository.createCategory(
      name: 'Clothing',
      icon: 'clothing',
      isExpenseCategory: true,
      colorCode: '#FF5722', // Deep Orange
    );

    await categoryRepository.createCategory(
      name: 'Insurance',
      icon: 'insurance',
      isExpenseCategory: true,
      colorCode: '#3F51B5', // Indigo
    );

    await categoryRepository.createCategory(
      name: 'Tax',
      icon: 'tax',
      isExpenseCategory: true,
      colorCode: '#9E9E9E', // Grey
    );

    await categoryRepository.createCategory(
      name: 'Telephone',
      icon: 'telephone',
      isExpenseCategory: true,
      colorCode: '#00BCD4', // Cyan
    );

    await categoryRepository.createCategory(
      name: 'Cigarette',
      icon: 'cigarette',
      isExpenseCategory: true,
      colorCode: '#424242', // Dark Grey
    );

    await categoryRepository.createCategory(
      name: 'Sport',
      icon: 'sport',
      isExpenseCategory: true,
      colorCode: '#8BC34A', // Light Green
    );

    await categoryRepository.createCategory(
      name: 'Baby',
      icon: 'baby',
      isExpenseCategory: true,
      colorCode: '#FFC107', // Amber
    );

    await categoryRepository.createCategory(
      name: 'Pet',
      icon: 'pet',
      isExpenseCategory: true,
      colorCode: '#CDDC39', // Lime
    );

    await categoryRepository.createCategory(
      name: 'Beauty',
      icon: 'beauty',
      isExpenseCategory: true,
      colorCode: '#E1BEE7', // Light Purple
    );

    await categoryRepository.createCategory(
      name: 'Electronics',
      icon: 'electronics',
      isExpenseCategory: true,
      colorCode: '#37474F', // Blue Grey Dark
    );

    await categoryRepository.createCategory(
      name: 'Hamburger',
      icon: 'hamburger',
      isExpenseCategory: true,
      colorCode: '#FFA726', // Orange
    );

    await categoryRepository.createCategory(
      name: 'Wine',
      icon: 'wine',
      isExpenseCategory: true,
      colorCode: '#8E24AA', // Purple
    );

    await categoryRepository.createCategory(
      name: 'Vegetables',
      icon: 'vegetables',
      isExpenseCategory: true,
      colorCode: '#66BB6A', // Green
    );

    await categoryRepository.createCategory(
      name: 'Snacks',
      icon: 'snacks',
      isExpenseCategory: true,
      colorCode: '#D4AC0D', // Golden
    );

    await categoryRepository.createCategory(
      name: 'Gift',
      icon: 'gift',
      isExpenseCategory: true,
      colorCode: '#EC407A', // Pink
    );

    await categoryRepository.createCategory(
      name: 'Social',
      icon: 'social',
      isExpenseCategory: true,
      colorCode: '#42A5F5', // Light Blue
    );

    await categoryRepository.createCategory(
      name: 'Travel',
      icon: 'travel',
      isExpenseCategory: true,
      colorCode: '#29B6F6', // Light Blue
    );

    await categoryRepository.createCategory(
      name: 'Education',
      icon: 'education',
      isExpenseCategory: true,
      colorCode: '#5C6BC0', // Indigo
    );

    await categoryRepository.createCategory(
      name: 'Fruits',
      icon: 'fruits',
      isExpenseCategory: true,
      colorCode: '#FF7043', // Deep Orange
    );

    await categoryRepository.createCategory(
      name: 'Book',
      icon: 'book',
      isExpenseCategory: true,
      colorCode: '#8D6E63', // Brown
    );

    await categoryRepository.createCategory(
      name: 'Office',
      icon: 'office',
      isExpenseCategory: true,
      colorCode: '#78909C', // Blue Grey
    );

    // Income Categories
    await categoryRepository.createCategory(
      name: 'Salary',
      icon: 'salary',
      isExpenseCategory: false,
      colorCode: '#4CAF50', // Green
    );

    await categoryRepository.createCategory(
      name: 'Awards',
      icon: 'awards',
      isExpenseCategory: false,
      colorCode: '#FFD700', // Gold
    );

    await categoryRepository.createCategory(
      name: 'Grants',
      icon: 'grants',
      isExpenseCategory: false,
      colorCode: '#2196F3', // Blue
    );

    await categoryRepository.createCategory(
      name: 'Sale',
      icon: 'sale',
      isExpenseCategory: false,
      colorCode: '#FF5722', // Deep Orange
    );

    await categoryRepository.createCategory(
      name: 'Rental',
      icon: 'rental',
      isExpenseCategory: false,
      colorCode: '#795548', // Brown
    );

    await categoryRepository.createCategory(
      name: 'Refunds',
      icon: 'refunds',
      isExpenseCategory: false,
      colorCode: '#9C27B0', // Purple
    );

    await categoryRepository.createCategory(
      name: 'Coupons',
      icon: 'coupons',
      isExpenseCategory: false,
      colorCode: '#FF9800', // Orange
    );

    await categoryRepository.createCategory(
      name: 'Dividends',
      icon: 'dividends',
      isExpenseCategory: false,
      colorCode: '#4CAF50', // Green
    );

    await categoryRepository.createCategory(
      name: 'Investments',
      icon: 'investments',
      isExpenseCategory: false,
      colorCode: '#009688', // Teal
    );

    await categoryRepository.createCategory(
      name: 'Others',
      icon: 'others',
      isExpenseCategory: false,
      colorCode: '#9E9E9E', // Grey
    );

    await categoryRepository.createCategory(
      name: 'SHS',
      icon: 'shs',
      isExpenseCategory: false,
      colorCode: '#FF5722', // Deep Orange
    );
  }
}

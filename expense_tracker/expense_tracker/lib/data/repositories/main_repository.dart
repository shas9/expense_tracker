import 'package:expense_tracker/data/repositories/data_repositoy.dart/category_repository.dart';

abstract class MainRepository {
  Future<void> loadInitialData();
}

class MainRepositoryImpl extends MainRepository {
  final CategoryRepository categoryRepository;

  MainRepositoryImpl({
    required this.categoryRepository,
  });

  @override
  Future<void> loadInitialData() async {
    // Create some default categories
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

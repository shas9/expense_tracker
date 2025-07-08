import 'package:expense_tracker/common/utilities/id_generator.dart';
import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:expense_tracker/data/service/realm_database_service.dart';

abstract class CategoryRepository {
  Future<CategoryEntity> createCategory({
    required String name,
    required String icon,
    required String colorCode,
  });
  Future<List<CategoryEntity>> getAllCategory();
  Future<void> deleteCategory(int categoryId);
  Future<void> updateCategory(
    int categoryId, {
    required String? name,
    required String? icon,
    required String? colorCode,
  });
  Future<CategoryEntity?> getCategoryById(int categoryId);
}

class CategoryRepositoryImpl extends CategoryRepository {
  final RealmDatabaseService realmDatabaseService;

  CategoryRepositoryImpl({required this.realmDatabaseService});

  @override
  Future<CategoryEntity> createCategory({
    required String name,
    required String icon,
    required String colorCode,
  }) async {
    CategoryEntity categoryEntity = CategoryEntity(
      IdGenerator.generateId(),
      name,
      icon,
      colorCode,
    );
    await realmDatabaseService.addCategory(categoryEntity);
    return categoryEntity;
  }

  @override
  Future<void> deleteCategory(int categoryId) async {
    await realmDatabaseService.deleteCategory(categoryId);
  }

  @override
  Future<List<CategoryEntity>> getAllCategory() async {
    return await realmDatabaseService.getAllSavedCategory();
  }

  @override
  Future<CategoryEntity?> getCategoryById(int categoryId) async {
    return await realmDatabaseService.getCategoryById(categoryId);
  }

  @override
  Future<void> updateCategory(
    int categoryId, {
    String? name,
    String? icon,
    String? colorCode,
  }) async {
    await realmDatabaseService.updateCategory(
      categoryId,
      name: name,
      icon: icon,
      colorCode: colorCode,
    );
  }
}

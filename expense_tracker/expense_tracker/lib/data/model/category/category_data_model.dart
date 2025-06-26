import 'package:expense_tracker/common/utilities/id_generator.dart';
import 'package:expense_tracker/data/database/realm_model.dart';

class CategoryDataModel {
  final int id;
  final String name;
  final String icon;

  CategoryDataModel({
    int? id,
    required this.name,
    required this.icon,
  }) : id = id ?? IdGenerator.generateId();

  // Convert Realm Category to CategoryDataModel
  factory CategoryDataModel.fromRealm(Category category) {
    return CategoryDataModel(
      id: category.id,
      name: category.name,
      icon: category.icon,
    );
  }

  // Convert CategoryDataModel back to Realm Category
  Category toRealmCategory() {
    return Category(id, name, icon);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryDataModel && id == other.id);

  @override
  int get hashCode => id.hashCode;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class WalletEntity extends _WalletEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  WalletEntity(
    int id,
    String name,
    int walletTypeId,
    String colorCode,
    double balance,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'walletTypeId', walletTypeId);
    RealmObjectBase.set(this, 'colorCode', colorCode);
    RealmObjectBase.set(this, 'balance', balance);
  }

  WalletEntity._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get walletTypeId => RealmObjectBase.get<int>(this, 'walletTypeId') as int;
  @override
  set walletTypeId(int value) =>
      RealmObjectBase.set(this, 'walletTypeId', value);

  @override
  String get colorCode =>
      RealmObjectBase.get<String>(this, 'colorCode') as String;
  @override
  set colorCode(String value) => RealmObjectBase.set(this, 'colorCode', value);

  @override
  double get balance => RealmObjectBase.get<double>(this, 'balance') as double;
  @override
  set balance(double value) => RealmObjectBase.set(this, 'balance', value);

  @override
  Stream<RealmObjectChanges<WalletEntity>> get changes =>
      RealmObjectBase.getChanges<WalletEntity>(this);

  @override
  Stream<RealmObjectChanges<WalletEntity>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<WalletEntity>(this, keyPaths);

  @override
  WalletEntity freeze() => RealmObjectBase.freezeObject<WalletEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'walletTypeId': walletTypeId.toEJson(),
      'colorCode': colorCode.toEJson(),
      'balance': balance.toEJson(),
    };
  }

  static EJsonValue _toEJson(WalletEntity value) => value.toEJson();
  static WalletEntity _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'walletTypeId': EJsonValue walletTypeId,
        'colorCode': EJsonValue colorCode,
        'balance': EJsonValue balance,
      } =>
        WalletEntity(
          fromEJson(id),
          fromEJson(name),
          fromEJson(walletTypeId),
          fromEJson(colorCode),
          fromEJson(balance),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(WalletEntity._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, WalletEntity, 'WalletEntity', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('walletTypeId', RealmPropertyType.int),
      SchemaProperty('colorCode', RealmPropertyType.string),
      SchemaProperty('balance', RealmPropertyType.double),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class TransactionEntity extends _TransactionEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  TransactionEntity(
    int id,
    String title,
    double amount,
    String description,
    DateTime date,
    int categoryId,
    int walletId,
    bool isIncome,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'amount', amount);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'categoryId', categoryId);
    RealmObjectBase.set(this, 'walletId', walletId);
    RealmObjectBase.set(this, 'isIncome', isIncome);
  }

  TransactionEntity._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  double get amount => RealmObjectBase.get<double>(this, 'amount') as double;
  @override
  set amount(double value) => RealmObjectBase.set(this, 'amount', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  DateTime get date => RealmObjectBase.get<DateTime>(this, 'date') as DateTime;
  @override
  set date(DateTime value) => RealmObjectBase.set(this, 'date', value);

  @override
  int get categoryId => RealmObjectBase.get<int>(this, 'categoryId') as int;
  @override
  set categoryId(int value) => RealmObjectBase.set(this, 'categoryId', value);

  @override
  int get walletId => RealmObjectBase.get<int>(this, 'walletId') as int;
  @override
  set walletId(int value) => RealmObjectBase.set(this, 'walletId', value);

  @override
  bool get isIncome => RealmObjectBase.get<bool>(this, 'isIncome') as bool;
  @override
  set isIncome(bool value) => RealmObjectBase.set(this, 'isIncome', value);

  @override
  Stream<RealmObjectChanges<TransactionEntity>> get changes =>
      RealmObjectBase.getChanges<TransactionEntity>(this);

  @override
  Stream<RealmObjectChanges<TransactionEntity>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<TransactionEntity>(this, keyPaths);

  @override
  TransactionEntity freeze() =>
      RealmObjectBase.freezeObject<TransactionEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'title': title.toEJson(),
      'amount': amount.toEJson(),
      'description': description.toEJson(),
      'date': date.toEJson(),
      'categoryId': categoryId.toEJson(),
      'walletId': walletId.toEJson(),
      'isIncome': isIncome.toEJson(),
    };
  }

  static EJsonValue _toEJson(TransactionEntity value) => value.toEJson();
  static TransactionEntity _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'title': EJsonValue title,
        'amount': EJsonValue amount,
        'description': EJsonValue description,
        'date': EJsonValue date,
        'categoryId': EJsonValue categoryId,
        'walletId': EJsonValue walletId,
        'isIncome': EJsonValue isIncome,
      } =>
        TransactionEntity(
          fromEJson(id),
          fromEJson(title),
          fromEJson(amount),
          fromEJson(description),
          fromEJson(date),
          fromEJson(categoryId),
          fromEJson(walletId),
          fromEJson(isIncome),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(TransactionEntity._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, TransactionEntity, 'TransactionEntity', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('amount', RealmPropertyType.double),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('date', RealmPropertyType.timestamp),
      SchemaProperty('categoryId', RealmPropertyType.int),
      SchemaProperty('walletId', RealmPropertyType.int),
      SchemaProperty('isIncome', RealmPropertyType.bool),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class CategoryEntity extends _CategoryEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  CategoryEntity(
    int id,
    String name,
    String icon,
    bool isExpenseCategory,
    String colorCode,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'icon', icon);
    RealmObjectBase.set(this, 'isExpenseCategory', isExpenseCategory);
    RealmObjectBase.set(this, 'colorCode', colorCode);
  }

  CategoryEntity._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get icon => RealmObjectBase.get<String>(this, 'icon') as String;
  @override
  set icon(String value) => RealmObjectBase.set(this, 'icon', value);

  @override
  bool get isExpenseCategory =>
      RealmObjectBase.get<bool>(this, 'isExpenseCategory') as bool;
  @override
  set isExpenseCategory(bool value) =>
      RealmObjectBase.set(this, 'isExpenseCategory', value);

  @override
  String get colorCode =>
      RealmObjectBase.get<String>(this, 'colorCode') as String;
  @override
  set colorCode(String value) => RealmObjectBase.set(this, 'colorCode', value);

  @override
  Stream<RealmObjectChanges<CategoryEntity>> get changes =>
      RealmObjectBase.getChanges<CategoryEntity>(this);

  @override
  Stream<RealmObjectChanges<CategoryEntity>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<CategoryEntity>(this, keyPaths);

  @override
  CategoryEntity freeze() => RealmObjectBase.freezeObject<CategoryEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'icon': icon.toEJson(),
      'isExpenseCategory': isExpenseCategory.toEJson(),
      'colorCode': colorCode.toEJson(),
    };
  }

  static EJsonValue _toEJson(CategoryEntity value) => value.toEJson();
  static CategoryEntity _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'icon': EJsonValue icon,
        'isExpenseCategory': EJsonValue isExpenseCategory,
        'colorCode': EJsonValue colorCode,
      } =>
        CategoryEntity(
          fromEJson(id),
          fromEJson(name),
          fromEJson(icon),
          fromEJson(isExpenseCategory),
          fromEJson(colorCode),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(CategoryEntity._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, CategoryEntity, 'CategoryEntity', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('icon', RealmPropertyType.string),
      SchemaProperty('isExpenseCategory', RealmPropertyType.bool),
      SchemaProperty('colorCode', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

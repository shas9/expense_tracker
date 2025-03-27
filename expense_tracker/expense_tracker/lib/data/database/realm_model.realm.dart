// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Wallet extends _Wallet with RealmEntity, RealmObjectBase, RealmObject {
  Wallet(
    ObjectId id,
    String name,
    String type,
    double balance,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'type', type);
    RealmObjectBase.set(this, 'balance', balance);
  }

  Wallet._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get type => RealmObjectBase.get<String>(this, 'type') as String;
  @override
  set type(String value) => RealmObjectBase.set(this, 'type', value);

  @override
  double get balance => RealmObjectBase.get<double>(this, 'balance') as double;
  @override
  set balance(double value) => RealmObjectBase.set(this, 'balance', value);

  @override
  Stream<RealmObjectChanges<Wallet>> get changes =>
      RealmObjectBase.getChanges<Wallet>(this);

  @override
  Stream<RealmObjectChanges<Wallet>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Wallet>(this, keyPaths);

  @override
  Wallet freeze() => RealmObjectBase.freezeObject<Wallet>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'type': type.toEJson(),
      'balance': balance.toEJson(),
    };
  }

  static EJsonValue _toEJson(Wallet value) => value.toEJson();
  static Wallet _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'type': EJsonValue type,
        'balance': EJsonValue balance,
      } =>
        Wallet(
          fromEJson(id),
          fromEJson(name),
          fromEJson(type),
          fromEJson(balance),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Wallet._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Wallet, 'Wallet', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('type', RealmPropertyType.string),
      SchemaProperty('balance', RealmPropertyType.double),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Expense extends _Expense with RealmEntity, RealmObjectBase, RealmObject {
  Expense(
    ObjectId id,
    String title,
    double amount,
    DateTime date,
    String category,
    String walletId,
    bool isIncome,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'amount', amount);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'category', category);
    RealmObjectBase.set(this, 'walletId', walletId);
    RealmObjectBase.set(this, 'isIncome', isIncome);
  }

  Expense._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  double get amount => RealmObjectBase.get<double>(this, 'amount') as double;
  @override
  set amount(double value) => RealmObjectBase.set(this, 'amount', value);

  @override
  DateTime get date => RealmObjectBase.get<DateTime>(this, 'date') as DateTime;
  @override
  set date(DateTime value) => RealmObjectBase.set(this, 'date', value);

  @override
  String get category =>
      RealmObjectBase.get<String>(this, 'category') as String;
  @override
  set category(String value) => RealmObjectBase.set(this, 'category', value);

  @override
  String get walletId =>
      RealmObjectBase.get<String>(this, 'walletId') as String;
  @override
  set walletId(String value) => RealmObjectBase.set(this, 'walletId', value);

  @override
  bool get isIncome => RealmObjectBase.get<bool>(this, 'isIncome') as bool;
  @override
  set isIncome(bool value) => RealmObjectBase.set(this, 'isIncome', value);

  @override
  Stream<RealmObjectChanges<Expense>> get changes =>
      RealmObjectBase.getChanges<Expense>(this);

  @override
  Stream<RealmObjectChanges<Expense>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Expense>(this, keyPaths);

  @override
  Expense freeze() => RealmObjectBase.freezeObject<Expense>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'title': title.toEJson(),
      'amount': amount.toEJson(),
      'date': date.toEJson(),
      'category': category.toEJson(),
      'walletId': walletId.toEJson(),
      'isIncome': isIncome.toEJson(),
    };
  }

  static EJsonValue _toEJson(Expense value) => value.toEJson();
  static Expense _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'title': EJsonValue title,
        'amount': EJsonValue amount,
        'date': EJsonValue date,
        'category': EJsonValue category,
        'walletId': EJsonValue walletId,
        'isIncome': EJsonValue isIncome,
      } =>
        Expense(
          fromEJson(id),
          fromEJson(title),
          fromEJson(amount),
          fromEJson(date),
          fromEJson(category),
          fromEJson(walletId),
          fromEJson(isIncome),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Expense._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Expense, 'Expense', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('amount', RealmPropertyType.double),
      SchemaProperty('date', RealmPropertyType.timestamp),
      SchemaProperty('category', RealmPropertyType.string),
      SchemaProperty('walletId', RealmPropertyType.string),
      SchemaProperty('isIncome', RealmPropertyType.bool),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Category extends _Category
    with RealmEntity, RealmObjectBase, RealmObject {
  Category(
    ObjectId id,
    String name,
    String icon,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'icon', icon);
  }

  Category._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get icon => RealmObjectBase.get<String>(this, 'icon') as String;
  @override
  set icon(String value) => RealmObjectBase.set(this, 'icon', value);

  @override
  Stream<RealmObjectChanges<Category>> get changes =>
      RealmObjectBase.getChanges<Category>(this);

  @override
  Stream<RealmObjectChanges<Category>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Category>(this, keyPaths);

  @override
  Category freeze() => RealmObjectBase.freezeObject<Category>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'icon': icon.toEJson(),
    };
  }

  static EJsonValue _toEJson(Category value) => value.toEJson();
  static Category _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'icon': EJsonValue icon,
      } =>
        Category(
          fromEJson(id),
          fromEJson(name),
          fromEJson(icon),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Category._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Category, 'Category', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('icon', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

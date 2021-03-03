// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Operation extends DataClass implements Insertable<Operation> {
  final int id;
  final String categoryName;
  final double income;
  final double expense;
  Operation({@required this.id, this.categoryName, this.income, this.expense});
  factory Operation.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return Operation(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      categoryName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}category_name']),
      income:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}income']),
      expense:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}expense']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || categoryName != null) {
      map['category_name'] = Variable<String>(categoryName);
    }
    if (!nullToAbsent || income != null) {
      map['income'] = Variable<double>(income);
    }
    if (!nullToAbsent || expense != null) {
      map['expense'] = Variable<double>(expense);
    }
    return map;
  }

  OperationsCompanion toCompanion(bool nullToAbsent) {
    return OperationsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      categoryName: categoryName == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryName),
      income:
          income == null && nullToAbsent ? const Value.absent() : Value(income),
      expense: expense == null && nullToAbsent
          ? const Value.absent()
          : Value(expense),
    );
  }

  factory Operation.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Operation(
      id: serializer.fromJson<int>(json['id']),
      categoryName: serializer.fromJson<String>(json['categoryName']),
      income: serializer.fromJson<double>(json['income']),
      expense: serializer.fromJson<double>(json['expense']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryName': serializer.toJson<String>(categoryName),
      'income': serializer.toJson<double>(income),
      'expense': serializer.toJson<double>(expense),
    };
  }

  Operation copyWith(
          {int id, String categoryName, double income, double expense}) =>
      Operation(
        id: id ?? this.id,
        categoryName: categoryName ?? this.categoryName,
        income: income ?? this.income,
        expense: expense ?? this.expense,
      );
  @override
  String toString() {
    return (StringBuffer('Operation(')
          ..write('id: $id, ')
          ..write('categoryName: $categoryName, ')
          ..write('income: $income, ')
          ..write('expense: $expense')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(categoryName.hashCode, $mrjc(income.hashCode, expense.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Operation &&
          other.id == this.id &&
          other.categoryName == this.categoryName &&
          other.income == this.income &&
          other.expense == this.expense);
}

class OperationsCompanion extends UpdateCompanion<Operation> {
  final Value<int> id;
  final Value<String> categoryName;
  final Value<double> income;
  final Value<double> expense;
  const OperationsCompanion({
    this.id = const Value.absent(),
    this.categoryName = const Value.absent(),
    this.income = const Value.absent(),
    this.expense = const Value.absent(),
  });
  OperationsCompanion.insert({
    this.id = const Value.absent(),
    this.categoryName = const Value.absent(),
    this.income = const Value.absent(),
    this.expense = const Value.absent(),
  });
  static Insertable<Operation> custom({
    Expression<int> id,
    Expression<String> categoryName,
    Expression<double> income,
    Expression<double> expense,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryName != null) 'category_name': categoryName,
      if (income != null) 'income': income,
      if (expense != null) 'expense': expense,
    });
  }

  OperationsCompanion copyWith(
      {Value<int> id,
      Value<String> categoryName,
      Value<double> income,
      Value<double> expense}) {
    return OperationsCompanion(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
      income: income ?? this.income,
      expense: expense ?? this.expense,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryName.present) {
      map['category_name'] = Variable<String>(categoryName.value);
    }
    if (income.present) {
      map['income'] = Variable<double>(income.value);
    }
    if (expense.present) {
      map['expense'] = Variable<double>(expense.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OperationsCompanion(')
          ..write('id: $id, ')
          ..write('categoryName: $categoryName, ')
          ..write('income: $income, ')
          ..write('expense: $expense')
          ..write(')'))
        .toString();
  }
}

class $OperationsTable extends Operations
    with TableInfo<$OperationsTable, Operation> {
  final GeneratedDatabase _db;
  final String _alias;
  $OperationsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _categoryNameMeta =
      const VerificationMeta('categoryName');
  GeneratedTextColumn _categoryName;
  @override
  GeneratedTextColumn get categoryName =>
      _categoryName ??= _constructCategoryName();
  GeneratedTextColumn _constructCategoryName() {
    return GeneratedTextColumn('category_name', $tableName, true,
        $customConstraints: 'NULL REFERENCES categories(name)');
  }

  final VerificationMeta _incomeMeta = const VerificationMeta('income');
  GeneratedRealColumn _income;
  @override
  GeneratedRealColumn get income => _income ??= _constructIncome();
  GeneratedRealColumn _constructIncome() {
    return GeneratedRealColumn(
      'income',
      $tableName,
      true,
    );
  }

  final VerificationMeta _expenseMeta = const VerificationMeta('expense');
  GeneratedRealColumn _expense;
  @override
  GeneratedRealColumn get expense => _expense ??= _constructExpense();
  GeneratedRealColumn _constructExpense() {
    return GeneratedRealColumn(
      'expense',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, categoryName, income, expense];
  @override
  $OperationsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'operations';
  @override
  final String actualTableName = 'operations';
  @override
  VerificationContext validateIntegrity(Insertable<Operation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('category_name')) {
      context.handle(
          _categoryNameMeta,
          categoryName.isAcceptableOrUnknown(
              data['category_name'], _categoryNameMeta));
    }
    if (data.containsKey('income')) {
      context.handle(_incomeMeta,
          income.isAcceptableOrUnknown(data['income'], _incomeMeta));
    }
    if (data.containsKey('expense')) {
      context.handle(_expenseMeta,
          expense.isAcceptableOrUnknown(data['expense'], _expenseMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Operation map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Operation.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $OperationsTable createAlias(String alias) {
    return $OperationsTable(_db, alias);
  }
}

class Categorie extends DataClass implements Insertable<Categorie> {
  final String name;
  final int iconName;
  Categorie({this.name, this.iconName});
  factory Categorie.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return Categorie(
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      iconName:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}icon_name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || iconName != null) {
      map['icon_name'] = Variable<int>(iconName);
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      iconName: iconName == null && nullToAbsent
          ? const Value.absent()
          : Value(iconName),
    );
  }

  factory Categorie.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Categorie(
      name: serializer.fromJson<String>(json['name']),
      iconName: serializer.fromJson<int>(json['iconName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'iconName': serializer.toJson<int>(iconName),
    };
  }

  Categorie copyWith({String name, int iconName}) => Categorie(
        name: name ?? this.name,
        iconName: iconName ?? this.iconName,
      );
  @override
  String toString() {
    return (StringBuffer('Categorie(')
          ..write('name: $name, ')
          ..write('iconName: $iconName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(name.hashCode, iconName.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Categorie &&
          other.name == this.name &&
          other.iconName == this.iconName);
}

class CategoriesCompanion extends UpdateCompanion<Categorie> {
  final Value<String> name;
  final Value<int> iconName;
  const CategoriesCompanion({
    this.name = const Value.absent(),
    this.iconName = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.name = const Value.absent(),
    this.iconName = const Value.absent(),
  });
  static Insertable<Categorie> custom({
    Expression<String> name,
    Expression<int> iconName,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (iconName != null) 'icon_name': iconName,
    });
  }

  CategoriesCompanion copyWith({Value<String> name, Value<int> iconName}) {
    return CategoriesCompanion(
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<int>(iconName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('name: $name, ')
          ..write('iconName: $iconName')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Categorie> {
  final GeneratedDatabase _db;
  final String _alias;
  $CategoriesTable(this._db, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, true,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _iconNameMeta = const VerificationMeta('iconName');
  GeneratedIntColumn _iconName;
  @override
  GeneratedIntColumn get iconName => _iconName ??= _constructIconName();
  GeneratedIntColumn _constructIconName() {
    return GeneratedIntColumn(
      'icon_name',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [name, iconName];
  @override
  $CategoriesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'categories';
  @override
  final String actualTableName = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Categorie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    }
    if (data.containsKey('icon_name')) {
      context.handle(_iconNameMeta,
          iconName.isAcceptableOrUnknown(data['icon_name'], _iconNameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  Categorie map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Categorie.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(_db, alias);
  }
}

abstract class _$WalletDatabase extends GeneratedDatabase {
  _$WalletDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $OperationsTable _operations;
  $OperationsTable get operations => _operations ??= $OperationsTable(this);
  $CategoriesTable _categories;
  $CategoriesTable get categories => _categories ??= $CategoriesTable(this);
  OperationDao _operationDao;
  OperationDao get operationDao =>
      _operationDao ??= OperationDao(this as WalletDatabase);
  CategoryDao _categoryDao;
  CategoryDao get categoryDao =>
      _categoryDao ??= CategoryDao(this as WalletDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [operations, categories];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$OperationDaoMixin on DatabaseAccessor<WalletDatabase> {
  $OperationsTable get operations => attachedDatabase.operations;
  $CategoriesTable get categories => attachedDatabase.categories;
}
mixin _$CategoryDaoMixin on DatabaseAccessor<WalletDatabase> {
  $CategoriesTable get categories => attachedDatabase.categories;
}

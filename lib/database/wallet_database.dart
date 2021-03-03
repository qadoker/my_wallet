import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor/moor.dart' as a;

part 'wallet_database.g.dart';

class Operations extends a.Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get categoryName =>
      text().nullable().customConstraint('NULL REFERENCES categories(name)')();
  RealColumn get income => real().nullable()();
  RealColumn get expense => real().nullable()();
}

class Categories extends a.Table {
  TextColumn get name => text().nullable().withLength(min: 1, max: 50)();
  IntColumn get iconName => integer().nullable()();

  @override
  Set<a.Column> get primaryKey => {name};
}

class OperationWithCategory {
  final Operation operation;
  final Categorie categorie;

  OperationWithCategory({@required this.operation, @required this.categorie});
}

@UseMoor(
  tables: [Operations, Categories],
  daos: [OperationDao, CategoryDao],
)
class WalletDatabase extends _$WalletDatabase {
  WalletDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));
  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [Operations, Categories])
class OperationDao extends DatabaseAccessor<WalletDatabase>
    with _$OperationDaoMixin {
  final WalletDatabase db;
  OperationDao(this.db) : super(db);

  Stream<List<OperationWithCategory>> watchAllOperations() {
    return (select(operations)
        ..orderBy([
              (w) => OrderingTerm(expression: operations.id,mode: OrderingMode.desc)
        ])
        )
        .join([
          leftOuterJoin(
              categories, categories.name.equalsExp(operations.categoryName)),
        ])
        .watch()
        .map((rows) => rows.map((row) {
              return OperationWithCategory(
                  operation: row.readTable(operations),
                  categorie: row.readTable(categories));
            }).toList());
  }

  Future insertOperation(Insertable<Operation> operation) =>
      into(operations).insert(operation);
  Future updateOperation(Insertable<Operation> operation) =>
      update(operations).replace(operation);
  Future deleteOperation(Insertable<Operation> operation) =>
      delete(operations).delete(operation);
  Future deleteCategory(Insertable<Categorie> categorie) =>
      delete(categories).delete(categorie);
  Future insertCategory(Insertable<Categorie> categorie) =>
      into(categories).insert(categorie);
}

@UseDao(tables: [Categories])
class CategoryDao extends DatabaseAccessor<WalletDatabase>
    with _$CategoryDaoMixin {
  final WalletDatabase db;

  CategoryDao(this.db) : super(db);

  Stream<List<Categorie>> watchCategories() => select(categories).watch();
  Future insertCategory(Insertable<Categorie> categorie) =>
      into(categories).insert(categorie);
  Future updateCategory(Insertable<Categorie> categorie) =>
      update(categories).replace(categorie);
  Future deleteCategory(Insertable<Categorie> categorie) =>
      delete(categories).delete(categorie);
}

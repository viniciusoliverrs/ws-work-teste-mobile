import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../../../data/datasources/local/local_datasource.dart';
import '../../../domain/exceptions/application_exception.dart';

class LocalDatasourceImpl implements ILocalDatasource {
  final List<String> migrations;
  final String databaseName;

  static Database? _database;
  LocalDatasourceImpl({
    required this.databaseName,
    required this.migrations,
  });

  Future<Database> get database async {
    try {
      if (_database != null) return _database!;

      _database = await openDatabase(
        '$databaseName.db',
        version: 1,
        onCreate: _onCreateDatabase,
      );
      return _database!;
    } catch (e, stackTrace) {
      throw ApplicationException(e.toString(), stackTrace: stackTrace);
    }
  }

  FutureOr<void> _onCreateDatabase(db, version) async {
    for (final migration in migrations) {
      await db.execute(migration);
    }
  }

  @override
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  @override
  Future<void> deleteDatabase() async {
    await deleteDatabase();
    await close();
  }

  @override
  Future<int> insert(String table, Map<String, dynamic> data) async {
    try {
      final db = await database;
      return await db.insert(table, data);
    } catch (e, s) {
      throw ApplicationException(e.toString(), stackTrace: s);
    }
  }

  @override
  Future<int> update(
    String table,
    Map<String, dynamic> data, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    try {
      final db = await database;
      return await db.update(table, data);
    } catch (e, s) {
      throw ApplicationException(e.toString(), stackTrace: s);
    }
  }

  @override
  Future<List<Map<String, Object?>>> query({required String sql}) async {
    try {
      final db = await database;
      return await db.rawQuery(sql);
    } catch (e, s) {
      throw ApplicationException(e.toString(), stackTrace: s);
    }
  }

  @override
  Future<int> delete(
    String table, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    try {
      final db = await database;
      return await db.delete(table, where: where, whereArgs: whereArgs);
    } catch (e, s) {
      throw ApplicationException(e.toString(), stackTrace: s);
    }
  }
}

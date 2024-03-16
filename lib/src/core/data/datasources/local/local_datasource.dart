import 'dart:async';

abstract interface class ILocalDatasource {
  Future<void> close();

  Future<void> deleteDatabase() async {
    await deleteDatabase();
    await close();
  }

  Future<int> insert(String table, Map<String, dynamic> data);

  Future<int> update(
    String table,
    Map<String, dynamic> data, {
    String? where,
    List<Object?>? whereArgs,
  });

  Future<List<Map<String, Object?>>> query({required String sql});

  Future<int> delete(
    String table, {
    String? where,
    List<Object?>? whereArgs,
  });
}

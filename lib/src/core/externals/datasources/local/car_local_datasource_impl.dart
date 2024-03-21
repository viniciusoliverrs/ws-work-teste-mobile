

import '../../../data/datasources/local/car_local_datasource.dart';
import '../../../data/datasources/local/local_datasource.dart';
import '../../../domain/exceptions/application_exception.dart';

class CarLocalDatasourceImpl implements ICarLocalDatasource {
  final ILocalDatasource localDatasource;

  CarLocalDatasourceImpl({
    required this.localDatasource,
  });


  @override
  Future<List<Map<String, dynamic>>> getCarsFavorite() async {
    try {
      final data = await localDatasource.query(sql: "SELECT * FROM cars");
      return data.map((e) => e).toList();
    } on ApplicationException {
      rethrow;
    } catch (e, s) {
      throw ApplicationException(e.toString(), stackTrace: s);
    }
  }

  @override
  Future<int> setCarFavorite({required Map<String, dynamic> map}) async {
    try {
      final data = await localDatasource.insert("cars", map);
      return data;
    } on ApplicationException {
      rethrow;
    } catch (e, s) {
      throw ApplicationException(e.toString(), stackTrace: s);
    }
  }

  @override
  Future<int> removeCarFavorite({required int carId}) async {
    try {
      final data = await localDatasource.delete("cars", where: "car_Id = ?", whereArgs: [carId]);
      return data;
    } on ApplicationException {
      rethrow;
    } catch (e, s) {
      throw ApplicationException(e.toString(), stackTrace: s);
    }
  }

  @override
  Future<int> updateCarAsFavorite({required Map<String, dynamic> map}) async {
    try {
      final data = await localDatasource.update("cars", map);
      return data;
    } on ApplicationException {
      rethrow;
    } catch (e, s) {
      throw ApplicationException(e.toString(), stackTrace: s);
    }
  }
}

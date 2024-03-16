// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../data/datasources/car_datasource.dart';
import '../../data/datasources/local/local_datasource.dart';
import '../../domain/exceptions/application_exception.dart';
import '../../utils/services/http/http.dart';
import '../../utils/services/http/http_failure.dart';

class CarDatasourceImpl implements ICarDatasource {
  final IHttp http;
  final ILocalDatasource localDatasource;

  CarDatasourceImpl({
    required this.http,
    required this.localDatasource,
  });

  @override
  Future<List<Map<String, dynamic>>> getCars() async {
    try {
      final response = await http.get(endpoint: "/cars.json");
      if (response.data case {"cars": final cars}) {
        return (cars as List).map((e) => e as Map<String, dynamic>).toList();
      }
      throw ApplicationException("Invalid response");
    } on HttpFailure catch (e, s) {
      throw ApplicationException(e.message, stackTrace: s);
    } catch (e, s) {
      throw ApplicationException(e.toString(), stackTrace: s);
    }
  }

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
  Future<bool> syncLeads({required List<Map<String, dynamic>> favoriteCars}) async {
    try {
      await http.post(endpoint: "/cars/leads", body: favoriteCars);
      return true;
    } on HttpFailure catch (e, s) {
      throw ApplicationException(e.message, stackTrace: s);
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

// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../data/datasources/car_remote_datasource.dart';
import '../../../domain/exceptions/application_exception.dart';
import '../../../utils/services/http/http.dart';
import '../../../utils/services/http/http_failure.dart';

class CarRemoteDatasourceImpl implements ICarRemoteDatasource {
  final IHttp http;

  CarRemoteDatasourceImpl({
    required this.http,
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
}

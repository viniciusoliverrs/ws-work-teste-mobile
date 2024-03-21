import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ws_work_teste_mobile/src/core/domain/exceptions/application_exception.dart';
import 'package:ws_work_teste_mobile/src/core/externals/datasources/remote/car_remote_datasource_impl.dart';
import 'package:ws_work_teste_mobile/src/core/utils/services/http/http.dart';
import 'package:ws_work_teste_mobile/src/core/utils/services/http/http_failure.dart';
import 'package:ws_work_teste_mobile/src/core/utils/services/http/http_response.dart';

class HttpMock extends Mock implements IHttp {}

void main() {
  final http = HttpMock();

  final datasource = CarRemoteDatasourceImpl(
    http: http,
  );
  group('CarDatasourceImpl', () {
    test('should return a list of cars when the call to datasource is successful', () async {
      final carsMap = {
        "cars": List.generate(
            5,
            (index) => {
                  "id": Faker().randomGenerator.integer(9999),
                  "timestamp_cadastro": Faker().date.dateTime().millisecondsSinceEpoch,
                  "modelo_id": Faker().randomGenerator.integer(9999),
                  "ano": Faker().randomGenerator.integer(9999),
                  "combustivel": Faker().lorem.word(),
                  "num_portas": Faker().randomGenerator.integer(9999),
                  "cor": Faker().lorem.word(),
                  "nome_modelo": Faker().lorem.word(),
                  "valor": Faker().randomGenerator.decimal(),
                })
      };
      when(() => http.get(endpoint: "/cars.json")).thenAnswer((_) async => HttpResponse(
            data: carsMap,
            statusCode: 200,
          ));
      final response = await datasource.getCars();
      expect(response, isA<List<Map<String, dynamic>>>());
    });

    test('should throw a ApplicationException when the call to datasource is unsuccessful', () async {
      final exception = HttpFailure(message: Faker().lorem.sentence(), stackTrace: StackTrace.current);
      when(() => http.get(endpoint: "/cars.json")).thenThrow(exception);
      expect(() async => await datasource.getCars(), throwsA(isA<ApplicationException>()));
    });

    test('should throw a Exception when the call to datasource is unsuccessful', () async {
      final exception = Exception(Faker().lorem.sentence());
      when(() => http.get(endpoint: "/cars.json")).thenThrow(exception);
      expect(() async => await datasource.getCars(), throwsA(isA<ApplicationException>()));
    });
  });
}

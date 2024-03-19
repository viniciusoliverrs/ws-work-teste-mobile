import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ws_work_teste_mobile/src/core/data/datasources/car_datasource.dart';
import 'package:ws_work_teste_mobile/src/core/data/datasources/local/local_datasource.dart';
import 'package:ws_work_teste_mobile/src/core/domain/exceptions/application_exception.dart';
import 'package:ws_work_teste_mobile/src/core/externals/datasources/car_datasource_impl.dart';
import 'package:ws_work_teste_mobile/src/core/utils/services/http/http.dart';
import 'package:ws_work_teste_mobile/src/core/utils/services/http/http_failure.dart';
import 'package:ws_work_teste_mobile/src/core/utils/services/http/http_response.dart';

import '../../../../mocks/utils.dart';

void main() {
  late IHttp http;
  late ILocalDatasource localDatasource;
  late ICarDatasource datasource;
  setUp(() {
    http = HttpMock();
    localDatasource = LocalDatasourceMock();
    datasource = CarDatasourceImpl(http: http, localDatasource: localDatasource);
  });
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

    test('should return a list of cars when the call to datasource is successful', () async {
      final carsMap = List.generate(
          5,
          (index) => {
                "id": Faker().randomGenerator.integer(9999),
                "car_id": Faker().randomGenerator.integer(9999),
              });
      when(() => localDatasource.query(sql: "SELECT * FROM cars")).thenAnswer((_) async => carsMap);
      final response = await datasource.getCarsFavorite();
      expect(response, isA<List<Map<String, dynamic>>>());
    });

    test('should throw a ApplicationException when the call to datasource is unsuccessful', () async {
      final exception = Exception(Faker().lorem.sentence());
      when(() => localDatasource.query(sql: "SELECT * FROM cars")).thenThrow(exception);
      expect(() async => await datasource.getCarsFavorite(), throwsA(isA<ApplicationException>()));
    });

    test('should return a int of car when the call to datasource is successful', () async {
      final map = {
        "modelo_id": Faker().randomGenerator.integer(9999),
      };
      final id = Faker().randomGenerator.integer(9999);
      when(() => localDatasource.insert("cars", map)).thenAnswer((_) async => id);
      final response = await datasource.setCarFavorite(map: map);
      expect(response, id);
    });

    test('should throw a ApplicationException when the call to datasource is unsuccessful', () async {
      final exception = Exception(Faker().lorem.sentence());
      when(() => localDatasource.insert("cars", {})).thenThrow(exception);
      expect(() async => await datasource.setCarFavorite(map: {}), throwsA(isA<ApplicationException>()));
    });

    test('should return a int of car when the call removeCarFavorite method to datasource is successful', () async {
      final carId = Faker().randomGenerator.integer(9999);
      when(() => localDatasource.delete("cars", where: "car_Id = ?", whereArgs: [carId])).thenAnswer((_) async => carId);
      final response = await datasource.removeCarFavorite(carId: carId);
      expect(response, carId);
    });

    test('should throw a ApplicationException when the call removeCarFavorite method to datasource is unsuccessful', () async {
      final exception = Exception(Faker().lorem.sentence());
      when(() => localDatasource.delete("cars", where: "car_Id = ?", whereArgs: [0])).thenThrow(exception);
      expect(() async => await datasource.removeCarFavorite(carId: 0), throwsA(isA<ApplicationException>()));
    });

    test('should throw a ApplicationException when the call removeCarFavoriteto method to datasource is unsuccessful', () async {
      final exception = ApplicationException(Faker().lorem.sentence());
      when(() => localDatasource.delete("cars", where: "car_Id = ?", whereArgs: [0])).thenThrow(exception);
      expect(() async => await datasource.removeCarFavorite(carId: 0), throwsA(isA<ApplicationException>()));
    });

    test('should return a int of car when the call updateCarAsFavorit method to datasource is successful', () async {
      final id = Faker().randomGenerator.integer(9999);
      final map = {
        'id': id,
        'car_id': Faker().randomGenerator.integer(9999),
        'is_sync': Faker().randomGenerator.boolean(),
      };
      when(() => localDatasource.update("cars", map)).thenAnswer((_) async => id);
      final response = await datasource.updateCarAsFavorite(map: map);
      expect(response, id);
    });

    test('should throw a ApplicationException when the call updateCarAsFavorit method to datasource is unsuccessful', () async {
      final exception = Exception(Faker().lorem.sentence());
      when(() => localDatasource.update("cars", {})).thenThrow(exception);
      expect(() async => await datasource.updateCarAsFavorite(map: {}), throwsA(isA<ApplicationException>()));
    });
  });
}

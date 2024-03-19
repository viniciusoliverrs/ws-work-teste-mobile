import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ws_work_teste_mobile/src/core/data/mappers/favorite_car_mapper.dart';
import 'package:ws_work_teste_mobile/src/core/data/mappers/set_car_favorite_mapper.dart';
import 'package:ws_work_teste_mobile/src/core/data/repositories/car_repository_impl.dart';
import 'package:ws_work_teste_mobile/src/core/domain/dtos/set_car_favorite.dart';
import 'package:ws_work_teste_mobile/src/core/domain/entities/car.dart';
import 'package:ws_work_teste_mobile/src/core/domain/entities/favorite_car.dart';
import 'package:ws_work_teste_mobile/src/core/domain/exceptions/application_exception.dart';
import 'package:ws_work_teste_mobile/src/core/domain/exceptions/mapper_exception.dart';
import 'package:ws_work_teste_mobile/src/core/utils/result.dart';

import '../../../../mocks/utils.dart';

void main() {
  final datasource = CarDatasourceMock();
  final respository = CarRepositoryImpl(datasource: datasource);
  group('CarRepositoryImpl', () {
    test('should return a list of cars when the call to datasource is successful', () async {
      final map = {
        "id": Faker().randomGenerator.integer(9999),
        "timestamp_cadastro": DateTime.now().millisecondsSinceEpoch,
        "modelo_id": Faker().randomGenerator.integer(9999),
        "ano": Faker().randomGenerator.integer(2022),
        "combustivel": Faker().randomGenerator.element(["GASOLINA", "ALCOOL", "FLEX"]),
        "num_portas": Faker().randomGenerator.integer(5),
        "cor": Faker().randomGenerator.element(["BRANCO", "PRETO", "PRATA", "VERMELHO"]),
        "nome_modelo": Faker().vehicle.model(),
        "valor": Faker().randomGenerator.decimal(min: 10000),
      };
      final response = List.generate(5, (index) => map);
      when(() => datasource.getCars()).thenAnswer((_) async => response);
      final result = await respository.getCars();
      verify(() => datasource.getCars()).called(1);

      expect(result.isSuccess, true);
      expect(result.getSuccess, isA<List<CarEntity>>());
      expect(result.getSuccess.length, response.length);
    });

    test('should return a ApplicationException when the call to datasource is unsuccessful', () async {
      final exception = ApplicationException(Faker().lorem.sentence());
      when(() => datasource.getCars()).thenThrow(exception);
      final result = await respository.getCars();
      verify(() => datasource.getCars()).called(1);

      expect(result.isFailure, true);
      expect(result.getFailure, isA<ApplicationException>());
      expect(result.getFailure.message, exception.message);
    });

    test('should return a MapperException when the call to datasource is unsuccessful', () async {
      final exception = MapperException(Faker().lorem.sentence());
      when(() => datasource.getCars()).thenThrow(exception);

      final result = await respository.getCars();
      verify(() => datasource.getCars()).called(1);

      expect(result.isFailure, true);
      expect(result.getFailure, isA<ApplicationException>());
      expect(result.getFailure.message, exception.message);
    });

    test('should return a list of cars when the call to datasource is successful', () async {
      final response = List.generate(
          5,
          (index) => {
                "id": Faker().randomGenerator.integer(9999),
                "car_id": Faker().randomGenerator.integer(9999),
              });
      when(() => respository.datasource.getCarsFavorite()).thenAnswer((_) async => response);

      final result = await respository.getFavoriteCars();
      verify(() => respository.datasource.getCarsFavorite()).called(1);

      expect(result.isSuccess, true);
      expect(result.getSuccess, isA<List<FavoriteCarEntity>>());
      expect(result.getSuccess.length, response.length);
    });

    test('should return a ApplicationException when the call to datasource is unsuccessful', () async {
      when(() => respository.datasource.getCarsFavorite()).thenThrow(ApplicationException(Faker().lorem.sentence()));
      final result = await respository.getFavoriteCars();
      if (result.isFailure) {
        final exception = result.getFailure;
        expect(exception, isA<ApplicationException>());
      } else {
        fail('Should return a ApplicationException');
      }
    });

    test('should return a MapperException when the call to datasource is unsuccessful', () async {
      when(() => respository.datasource.getCarsFavorite()).thenThrow(MapperException(Faker().lorem.sentence()));
      final result = await respository.getFavoriteCars();
      if (result.isFailure) {
        final exception = result.getFailure;
        expect(exception, isA<ApplicationException>());
      } else {
        fail('Should return a ApplicationException');
      }
    });

    test('should return a int of car when the call to datasource is successful', () async {
      final setFavoriteCar = SetCarFavoriteDto(
        carId: Faker().randomGenerator.integer(9999),
      );
      final mapper = SetCarFavoriteMapper.toMap(setFavoriteCar);
      final id = Faker().randomGenerator.integer(9999);
      when(() => datasource.setCarFavorite(map: mapper)).thenAnswer((_) async => id);
      final result = await respository.setCarFavorite(setFavoriteCar);
      verify(() => datasource.setCarFavorite(map: mapper)).called(1);

      expect(result.isSuccess, true);
      expect(result.getSuccess, id);
      expect(result.getSuccess, isA<int>());
    });

    test('should return a ApplicationException when the call to datasource is unsuccessful', () async {
      final setFavoriteCar = SetCarFavoriteDto(carId: Faker().randomGenerator.integer(9999));
      final mapper = SetCarFavoriteMapper.toMap(setFavoriteCar);
      final exception = ApplicationException(Faker().lorem.sentence());
      when(() => datasource.setCarFavorite(map: mapper)).thenThrow(exception);

      final result = await respository.setCarFavorite(setFavoriteCar);
      verify(() => datasource.setCarFavorite(map: mapper)).called(1);

      expect(result.isFailure, true);
      expect(result.getFailure, isA<ApplicationException>());
      expect(result.getFailure.message, exception.message);
    });

    test('should return a int of car when the call removeCarFavorite method to datasource is successful', () async {
      final dto = SetCarFavoriteDto(carId: Faker().randomGenerator.integer(9999));
      when(() => datasource.removeCarFavorite(carId: dto.carId)).thenAnswer((_) async => dto.carId);

      final result = await respository.removeCarFavorite(dto);
      verify(() => datasource.removeCarFavorite(carId: dto.carId)).called(1);

      expect(result.isSuccess, true);
      expect(result.getSuccess, dto.carId);
      expect(result.getSuccess, isA<int>());
    });

    test('should return a ApplicationException when the call removeCarFavorite method to datasource is unsuccessful', () async {
      final dto = SetCarFavoriteDto(carId: Faker().randomGenerator.integer(9999));
      final exception = ApplicationException(Faker().lorem.sentence());
      when(() => datasource.removeCarFavorite(carId: dto.carId)).thenThrow(exception);

      final result = await respository.removeCarFavorite(dto);
      verify(() => datasource.removeCarFavorite(carId: dto.carId)).called(1);

      expect(result.isFailure, true);
      expect(result.getFailure, isA<ApplicationException>());
      expect(result.getFailure.message, exception.message);
    });

    test('should return a int of car when the call updateCarAsFavorit method to datasource is successful', () async {
      final dto = FavoriteCarEntity(id: Faker().randomGenerator.integer(9999), carId: Faker().randomGenerator.integer(9999));
      final mapper = FavoriteCarMapper.toMap(dto);
      when(() => respository.datasource.updateCarAsFavorite(map: mapper)).thenAnswer((_) async => dto.id);

      final result = await respository.updateCarAsFavorite(dto);
      verify(() => respository.datasource.updateCarAsFavorite(map: mapper)).called(1);

      expect(result.isSuccess, true);
      expect(result.getSuccess, dto.id);
      expect(result.getSuccess, isA<int>());
    });

    test('should return a ApplicationException when the call updateCarAsFavorit method to datasource is unsuccessful', () async {
      final dto = FavoriteCarEntity(id: Faker().randomGenerator.integer(9999), carId: Faker().randomGenerator.integer(9999));
      when(() => respository.datasource.updateCarAsFavorite(map: {})).thenThrow(ApplicationException(Faker().lorem.sentence()));
      final result = await respository.updateCarAsFavorite(dto);
      if (result.isFailure) {
        final exception = result.getFailure;
        expect(exception, isA<ApplicationException>());
      } else {
        fail('Should return a ApplicationException');
      }
    });

    test('should return a bool when the call syncLeads method to datasource is successful', () async {
      final favoriteCars = List.generate(
          5,
          (index) => FavoriteCarEntity(
                id: Faker().randomGenerator.integer(9999),
                carId: Faker().randomGenerator.integer(9999),
              ));
      final mapper = favoriteCars.map((car) => FavoriteCarMapper.toMap(car)).toList();
      when(() => respository.datasource.syncLeads(favoriteCars: mapper)).thenAnswer((_) async => true);
      final result = await respository.syncLeads(favoriteCars: favoriteCars);
      if (result.isSuccess) {
        final response = result.getSuccess;
        expect(response, true);
      } else {
        fail('Should return a bool');
      }
    });

    test('should return a ApplicationException when the call syncLeads method to datasource is unsuccessful', () async {
      final favoriteCars = List.generate(5, (index) => FavoriteCarEntity(id: Faker().randomGenerator.integer(9999), carId: Faker().randomGenerator.integer(9999)));
      final mapper = favoriteCars.map((car) => FavoriteCarMapper.toMap(car)).toList();
      final exception = ApplicationException(Faker().lorem.sentence());
      when(() => datasource.syncLeads(favoriteCars: mapper)).thenThrow(exception);

      final result = await respository.syncLeads(favoriteCars: favoriteCars);
      verify(() => datasource.syncLeads(favoriteCars: mapper)).called(1);

      expect(result.isFailure, true);
      expect(result.getFailure, isA<ApplicationException>());
      expect(result.getFailure.message, exception.message);
    });

    test('should return a ApplicationException when the call syncLeads method to datasource is unsuccessful', () async {
      final favoriteCars = List.generate(
          5,
          (index) => FavoriteCarEntity(
                id: Faker().randomGenerator.integer(9999),
                carId: Faker().randomGenerator.integer(9999),
              ));
      final mapper = favoriteCars.map((car) => FavoriteCarMapper.toMap(car)).toList();
      final exception = MapperException(Faker().lorem.sentence());
      when(() => datasource.syncLeads(favoriteCars: mapper)).thenThrow(exception);
      
      final result = await respository.syncLeads(favoriteCars: favoriteCars);
      verify(() => datasource.syncLeads(favoriteCars: mapper)).called(1);

      expect(result.isFailure, true);
      expect(result.getFailure, isA<ApplicationException>());
      expect(result.getFailure.message, exception.message);
    });
  });

  test('should return a bool when the call updateCarAsFavorite method to datasource is successful', () async {
    final favoriteCar = FavoriteCarEntity(
      id: Faker().randomGenerator.integer(9999),
      carId: Faker().randomGenerator.integer(9999),
    );
    final mapper = FavoriteCarMapper.toMap(favoriteCar);
    when(() => respository.datasource.updateCarAsFavorite(map: mapper)).thenAnswer((_) async => favoriteCar.id);

    final result = await respository.updateCarAsFavorite(favoriteCar);
    verify(() => respository.datasource.updateCarAsFavorite(map: mapper)).called(1);

    expect(result.isSuccess, true);
    expect(result.getSuccess, isA<int>());
    expect(result.getSuccess, favoriteCar.id);
  });

  test('should return a ApplicationException when the call updateCarAsFavorite method to datasource is unsuccessful', () async {
    final favoriteCar = FavoriteCarEntity(
      id: Faker().randomGenerator.integer(9999),
      carId: Faker().randomGenerator.integer(9999),
    );
    final mapper = FavoriteCarMapper.toMap(favoriteCar);
    final exception = ApplicationException(Faker().lorem.sentence());
    when(() => datasource.updateCarAsFavorite(map: mapper)).thenThrow(exception);

    final result = await respository.updateCarAsFavorite(favoriteCar);
    verify(() => datasource.updateCarAsFavorite(map: mapper)).called(1);

    expect(result.isFailure, true);
    expect(result.getFailure, isA<ApplicationException>());
    expect(result.getFailure.message, exception.message);
  });

  test('should return a MapperException when the call updateCarAsFavorite method to datasource is unsuccessful', () async {
    final favoriteCar = FavoriteCarEntity(
      id: Faker().randomGenerator.integer(9999),
      carId: Faker().randomGenerator.integer(9999),
    );
    final mapper = FavoriteCarMapper.toMap(favoriteCar);
    final exception = MapperException(Faker().lorem.sentence());
    when(() => datasource.updateCarAsFavorite(map: mapper)).thenThrow(exception);
    final result = await respository.updateCarAsFavorite(favoriteCar);
    verify(() => datasource.updateCarAsFavorite(map: mapper)).called(1);

    expect(result.isFailure, true);
    expect(result.getFailure, isA<ApplicationException>());
  });
}

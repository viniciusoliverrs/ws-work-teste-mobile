import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ws_work_teste_mobile/src/core/data/datasources/car_datasource.dart';
import 'package:ws_work_teste_mobile/src/core/data/mappers/favorite_car_mapper.dart';
import 'package:ws_work_teste_mobile/src/core/data/mappers/set_car_favorite_mapper.dart';
import 'package:ws_work_teste_mobile/src/core/data/repositories/car_repository_impl.dart';
import 'package:ws_work_teste_mobile/src/core/domain/dtos/set_car_favorite.dart';
import 'package:ws_work_teste_mobile/src/core/domain/entities/favorite_car.dart';
import 'package:ws_work_teste_mobile/src/core/domain/exceptions/application_exception.dart';
import 'package:ws_work_teste_mobile/src/core/domain/exceptions/mapper_exception.dart';
import 'package:ws_work_teste_mobile/src/core/utils/result.dart';

class CarDatasourceMock extends Mock implements ICarDatasource {}

void main() {
  final respository = CarRepositoryImpl(datasource: CarDatasourceMock());
  group('CarRepositoryImpl', () {
    test('should return a list of cars when the call to datasource is successful', () async {
      when(() => respository.datasource.getCars()).thenAnswer((_) async => List.generate(
          5,
          (index) => {
                "id": Faker().randomGenerator.integer(9999),
                "timestamp_cadastro": DateTime.now().millisecondsSinceEpoch,
                "modelo_id": Faker().randomGenerator.integer(9999),
                "ano": Faker().randomGenerator.integer(2022),
                "combustivel": Faker().randomGenerator.element(["GASOLINA", "ALCOOL", "FLEX"]),
                "num_portas": Faker().randomGenerator.integer(5),
                "cor": Faker().randomGenerator.element(["BRANCO", "PRETO", "PRATA", "VERMELHO"]),
                "nome_modelo": Faker().vehicle.model(),
                "valor": Faker().randomGenerator.decimal(min: 10000),
              }));
      final result = await respository.getCars();
      if (result.isSuccess) {
        final cars = result.getSuccess;
        expect(cars.length, 5);
      } else {
        fail('Should return a list of cars');
      }
    });

    test('should return a ApplicationException when the call to datasource is unsuccessful', () async {
      when(() => respository.datasource.getCars()).thenThrow(ApplicationException(Faker().lorem.sentence()));
      final result = await respository.getCars();
      if (result.isFailure) {
        final exception = result.getFailure;
        expect(exception, isA<ApplicationException>());
      } else {
        fail('Should return a ApplicationException');
      }
    });

    test('should return a MapperException when the call to datasource is unsuccessful', () async {
      when(() => respository.datasource.getCars()).thenThrow(MapperException(Faker().lorem.sentence()));
      final result = await respository.getCars();
      if (result.isFailure) {
        final exception = result.getFailure;
        expect(exception, isA<ApplicationException>());
      } else {
        fail('Should return a ApplicationException');
      }
    });

    test('should return a list of cars when the call to datasource is successful', () async {
      when(() => respository.datasource.getCarsFavorite()).thenAnswer((_) async => List.generate(
          5,
          (index) => {
                "id": Faker().randomGenerator.integer(9999),
                "car_id": Faker().randomGenerator.integer(9999),
              }));
      final result = await respository.getFavoriteCars();
      if (result.isSuccess) {
        final cars = result.getSuccess;
        expect(cars.length, 5);
      } else {
        fail('Should return a list of cars');
      }
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
      when(() => respository.datasource.setCarFavorite(map: mapper)).thenAnswer((_) async => id);
      final result = await respository.setCarFavorite(setFavoriteCar);
      if (result.isSuccess) {
        final response = result.getSuccess;
        expect(response, id);
      } else {
        fail('Should return a int of car');
      }
    });

    test('should return a ApplicationException when the call to datasource is unsuccessful', () async {
      final setFavoriteCar = SetCarFavoriteDto(
        carId: Faker().randomGenerator.integer(9999),
      );
      when(() => respository.datasource.setCarFavorite(map: {})).thenThrow(ApplicationException(Faker().lorem.sentence()));
      final result = await respository.setCarFavorite(setFavoriteCar);
      if (result.isFailure) {
        final exception = result.getFailure;
        expect(exception, isA<ApplicationException>());
      } else {
        fail('Should return a ApplicationException');
      }
    });

    test('should return a int of car when the call removeCarFavorite method to datasource is successful', () async {
      final dto = SetCarFavoriteDto(carId: Faker().randomGenerator.integer(9999));
      when(() => respository.datasource.removeCarFavorite(carId: dto.carId)).thenAnswer((_) async => dto.carId);
      final result = await respository.removeCarFavorite(dto);
      if (result.isSuccess) {
        final response = result.getSuccess;
        expect(response, dto.carId);
      } else {
        fail('Should return a int of car');
      }
    });

    test('should return a ApplicationException when the call removeCarFavorite method to datasource is unsuccessful', () async {
      final dto = SetCarFavoriteDto(carId: Faker().randomGenerator.integer(9999));
      when(() => respository.datasource.removeCarFavorite(carId: dto.carId)).thenThrow(ApplicationException(Faker().lorem.sentence()));
      final result = await respository.removeCarFavorite(dto);
      if (result.isFailure) {
        final exception = result.getFailure;
        expect(exception, isA<ApplicationException>());
      } else {
        fail('Should return a ApplicationException');
      }
    });

    test('should return a int of car when the call updateCarAsFavorit method to datasource is successful', () async {
      final dto = FavoriteCarEntity(id: Faker().randomGenerator.integer(9999), carId: Faker().randomGenerator.integer(9999));
      final mapper = FavoriteCarMapper.toMap(dto);
      when(() => respository.datasource.updateCarAsFavorite(map: mapper)).thenAnswer((_) async => dto.id);
      final result = await respository.updateCarAsFavorite(dto);
      if (result.isSuccess) {
        final response = result.getSuccess;
        expect(response, dto.id);
      } else {
        fail('Should return a int of car');
      }
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
      final favoriteCars = List.generate(
          5,
          (index) => FavoriteCarEntity(
                id: Faker().randomGenerator.integer(9999),
                carId: Faker().randomGenerator.integer(9999),
              ));
      final mapper = favoriteCars.map((car) => FavoriteCarMapper.toMap(car)).toList();
      when(() => respository.datasource.syncLeads(favoriteCars: mapper)).thenThrow(ApplicationException(Faker().lorem.sentence()));
      final result = await respository.syncLeads(favoriteCars: favoriteCars);
      if (result.isFailure) {
        final exception = result.getFailure;
        expect(exception, isA<ApplicationException>());
      } else {
        fail('Should return a ApplicationException');
      }
    });

    test('should return a ApplicationException when the call syncLeads method to datasource is unsuccessful', () async {
      final favoriteCars = List.generate(
          5,
          (index) => FavoriteCarEntity(
                id: Faker().randomGenerator.integer(9999),
                carId: Faker().randomGenerator.integer(9999),
              ));
      final mapper = favoriteCars.map((car) => FavoriteCarMapper.toMap(car)).toList();
      when(() => respository.datasource.syncLeads(favoriteCars: mapper)).thenThrow(MapperException(Faker().lorem.sentence()));
      final result = await respository.syncLeads(favoriteCars: favoriteCars);
      if (result.isFailure) {
        final exception = result.getFailure;
        expect(exception, isA<ApplicationException>());
      } else {
        fail('Should return a ApplicationException');
      }
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
    if (result.isSuccess) {
      final response = result.getSuccess;
      expect(response, favoriteCar.id);
    } else {
      fail('Should return a bool');
    }
  });

  test('should return a ApplicationException when the call updateCarAsFavorite method to datasource is unsuccessful', () async {
    final favoriteCar = FavoriteCarEntity(
      id: Faker().randomGenerator.integer(9999),
      carId: Faker().randomGenerator.integer(9999),
    );
    when(() => respository.datasource.updateCarAsFavorite(map: {})).thenThrow(ApplicationException(Faker().lorem.sentence()));
    final result = await respository.updateCarAsFavorite(favoriteCar);
    if (result.isFailure) {
      final exception = result.getFailure;
      expect(exception, isA<ApplicationException>());
    } else {
      fail('Should return a ApplicationException');
    }
  });

  test('should return a MapperException when the call updateCarAsFavorite method to datasource is unsuccessful', () async {
    final favoriteCar = FavoriteCarEntity(
      id: Faker().randomGenerator.integer(9999),
      carId: Faker().randomGenerator.integer(9999),
    );
    when(() => respository.datasource.updateCarAsFavorite(map: {})).thenThrow(MapperException(Faker().lorem.sentence()));
    final result = await respository.updateCarAsFavorite(favoriteCar);
    if (result.isFailure) {
      final exception = result.getFailure;
      expect(exception, isA<ApplicationException>());
    } else {
      fail('Should return a ApplicationException');
    }
  });
  
}

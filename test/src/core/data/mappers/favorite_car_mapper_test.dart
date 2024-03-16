import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ws_work_teste_mobile/src/core/data/mappers/favorite_car_mapper.dart';
import 'package:ws_work_teste_mobile/src/core/domain/entities/favorite_car.dart';
import 'package:ws_work_teste_mobile/src/core/domain/exceptions/mapper_exception.dart';

void main() {
  group('FavoriteCarMapper', () {
    test('fromMap', () {
      final map = {
        'id': Faker().randomGenerator.integer(9999),
        'car_id': Faker().randomGenerator.integer(9999),
        'is_sync': Faker().randomGenerator.boolean() ? 1 : 0,
      };

      final result = FavoriteCarMapper.fromMap(map);
      expect(result.id, map['id']);
      expect(result.carId, map['car_id']);
      expect(result.isSync, map['is_sync'] == 1);
    });

    test('toMap', () {
      final favoriteCar = FavoriteCarEntity(
        id: Faker().randomGenerator.integer(9999),
        carId: Faker().randomGenerator.integer(9999),
        isSync: Faker().randomGenerator.boolean(),
      );

      final result = FavoriteCarMapper.toMap(favoriteCar);
      expect(result['id'], favoriteCar.id);
      expect(result['car_id'], favoriteCar.carId);
      expect(result['is_sync'], favoriteCar.isSync ? 1 : 0);
    });

    test('fromMap throws MapperException', () {
      final map = {
        'id': Faker().randomGenerator.integer(9999).toString(),
        'car_id': Faker().randomGenerator.integer(9999).toString(),
        'is_sync': Faker().randomGenerator.boolean(),
      };

      expect(() => FavoriteCarMapper.fromMap(map), throwsA(isA<MapperException>()));
    });
  });
}

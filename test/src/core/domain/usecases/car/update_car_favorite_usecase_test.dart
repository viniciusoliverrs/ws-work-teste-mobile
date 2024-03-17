import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ws_work_teste_mobile/src/core/domain/entities/favorite_car.dart';
import 'package:ws_work_teste_mobile/src/core/domain/exceptions/application_exception.dart';
import 'package:ws_work_teste_mobile/src/core/domain/repositories/car_repository.dart';
import 'package:ws_work_teste_mobile/src/core/domain/usecases/car/update_car_favorite_usecase.dart';
import 'package:ws_work_teste_mobile/src/core/utils/result.dart';

class CarRepositoryMock extends Mock implements ICarRepository {}

void main() {
  final repository = CarRepositoryMock();
  final updateCarFavoriteUsecase = UpdateCarAsFavoriteUsecaseImpl(carRepository: repository);
  group('UpdateCarAsFavoriteUsecaseImpl', () {
    test('should update car as favorite', () async {
      final entity = FavoriteCarEntity(
        id: Faker().randomGenerator.integer(9999),
        carId: Faker().randomGenerator.integer(9999),
        isSync: Faker().randomGenerator.boolean(),
      );
      when(() => repository.updateCarAsFavorite(entity)).thenAnswer((_) async => (null, entity.id));
      final result = await updateCarFavoriteUsecase(entity);
      if (result.isSuccess) {
        final data = result.getSuccess;
        expect(data, isA<int>());
      } else {
        fail('should update car as favorite');
      }
      
    });

    test('should return a ApplicationException', () async {
      final entity = FavoriteCarEntity(
        id: Faker().randomGenerator.integer(9999),
        carId: Faker().randomGenerator.integer(9999),
        isSync: Faker().randomGenerator.boolean(),
      );
      when(() => repository.updateCarAsFavorite(entity)).thenAnswer((_) async => (ApplicationException('Error'), null));
      final result = await updateCarFavoriteUsecase(entity);
      if (result.isFailure) {
        final data = result.getFailure;
        expect(data, isA<ApplicationException>());
      } else {
        fail('should return a ApplicationException');
      }
    });
  });
}

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ws_work_teste_mobile/src/core/domain/entities/favorite_car.dart';
import 'package:ws_work_teste_mobile/src/core/domain/exceptions/application_exception.dart';
import 'package:ws_work_teste_mobile/src/core/domain/usecases/car/update_car_favorite_usecase.dart';
import 'package:ws_work_teste_mobile/src/core/utils/result.dart';

import '../../../../../mocks/utils.dart';

void main() {
  late CarRepositoryMock repository;
  late UpdateCarAsFavoriteUsecaseImpl updateCarFavoriteUsecase;
  late FavoriteCarEntity entity;
  setUp(() {
    repository = CarRepositoryMock();
    updateCarFavoriteUsecase = UpdateCarAsFavoriteUsecaseImpl(carRepository: repository);
    entity = FavoriteCarEntity(
      id: Faker().randomGenerator.integer(9999),
      carId: Faker().randomGenerator.integer(9999),
      isSync: Faker().randomGenerator.boolean(),
    );
  });

  group('UpdateCarAsFavoriteUsecaseImpl', () {
    test('should return a ApplicationException', () async {
      final exception = ApplicationException(Faker().lorem.sentence());
      when(() => repository.updateCarAsFavorite(entity)).thenAnswer((_) async => (exception, null));

      final result = await updateCarFavoriteUsecase(entity);
      verify(() => repository.updateCarAsFavorite(entity)).called(1);
      if (result.isFailure) {
        final data = result.getFailure;
        expect(data, isA<ApplicationException>());
        expect(data.message, exception.message);
      } else {
        fail('should return a ApplicationException');
      }
    });
    test('should update car as favorite', () async {
      when(() => repository.updateCarAsFavorite(entity)).thenAnswer((_) async => (null, entity.id));
      final result = await updateCarFavoriteUsecase(entity);
      verify(() => repository.updateCarAsFavorite(entity)).called(1);
      if (result.isSuccess) {
        final id = result.getSuccess;
        expect(id, isA<int>());
        expect(id, entity.id);
      } else {
        fail('should update car as favorite');
      }
    });
  });
}

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ws_work_teste_mobile/src/core/domain/dtos/set_car_favorite.dart';
import 'package:ws_work_teste_mobile/src/core/domain/exceptions/application_exception.dart';
import 'package:ws_work_teste_mobile/src/core/domain/repositories/car_repository.dart';
import 'package:ws_work_teste_mobile/src/core/domain/usecases/car/save_car_as_favorite_usecase.dart';
import 'package:ws_work_teste_mobile/src/core/utils/result.dart';

class CarRepositoryMock extends Mock implements ICarRepository {}

void main() {
  final carRepository = CarRepositoryMock();
  final saveCarAsFavoriteUsecase = SaveCarAsFavoriteUsecaseImpl(carRepository: carRepository);
  group('SaveCarAsFavoriteUsecaseImpl', () {
    test('should save car as favorite', () async {
      final entity = SetCarFavoriteDto(
        carId: 1,
      );
      final id = Faker().randomGenerator.integer(9999);
      when(() => carRepository.setCarFavorite(entity)).thenAnswer((_) async => (null, id));
      final result = await saveCarAsFavoriteUsecase(setCarFavoriteDto: entity);
      if (result.isSuccess) {
        final data = result.getSuccess;
        expect(data, isA<int>());
      } else {
        fail('should save car as favorite');
      }
    });
    test('should return a ApplicationException', () async {
      final entity = SetCarFavoriteDto(
        carId: 1,
      );
      when(() => carRepository.setCarFavorite(entity)).thenAnswer((_) async => (ApplicationException('Error'), null));
      final result = await saveCarAsFavoriteUsecase(setCarFavoriteDto: entity);
      if (result.isFailure) {
        final data = result.getFailure;
        expect(data, isA<ApplicationException>());
      } else {
        fail('should return a ApplicationException');
      }
    });
  });
}

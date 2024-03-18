import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ws_work_teste_mobile/src/core/domain/dtos/set_car_favorite.dart';
import 'package:ws_work_teste_mobile/src/core/domain/exceptions/application_exception.dart';
import 'package:ws_work_teste_mobile/src/core/domain/repositories/car_repository.dart';
import 'package:ws_work_teste_mobile/src/core/domain/usecases/car/remove_car_as_favorite_usecase.dart';
import 'package:ws_work_teste_mobile/src/core/utils/result.dart';

class CarRepositoryMock extends Mock implements ICarRepository {}

void main() {
  final repositorry = CarRepositoryMock();
  final removeCarAsFavoriteUsecase = RemoveCarAsFavoriteUsecaseImpl(carRepository: repositorry);
  group('RemoveCarAsFavoriteUsecaseImpl', () {
    test('should remove car as favorite', () async {
      final dto = SetCarFavoriteDto(
        carId: Faker().randomGenerator.integer(9999),
      );
      when(() => repositorry.removeCarFavorite(dto)).thenAnswer((_) async => (null, dto.carId));
      final result = await removeCarAsFavoriteUsecase(setCarFavoriteDto: dto);
      if (result.isSuccess) {
        final data = result.getSuccess;
        expect(data, isA<int>());
      } else {
        fail('should remove car as favorite');
      }
    });

    test('should return ApplicationException', () async {
      final dto = SetCarFavoriteDto(
        carId: Faker().randomGenerator.integer(9999),
      );
      when(() => repositorry.removeCarFavorite(dto)).thenAnswer((_) async => (ApplicationException('Error'), null));
      final result = await removeCarAsFavoriteUsecase(setCarFavoriteDto: dto);
      if (result.isFailure) {
        final data = result.getFailure;
        expect(data, isA<ApplicationException>());
      } else {
        fail('should return ApplicationException');
      }
    });
  });
}

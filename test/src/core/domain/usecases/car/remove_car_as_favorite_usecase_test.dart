import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ws_work_teste_mobile/src/core/domain/dtos/set_car_favorite.dart';
import 'package:ws_work_teste_mobile/src/core/domain/exceptions/application_exception.dart';
import 'package:ws_work_teste_mobile/src/core/domain/repositories/car_repository.dart';
import 'package:ws_work_teste_mobile/src/core/domain/usecases/car/remove_car_as_favorite_usecase.dart';
import 'package:ws_work_teste_mobile/src/core/utils/result.dart';

import '../../../../../mocks/utils.dart';

void main() {
  late ICarRepository repositorry;
  late IRemoveCarAsFavoriteUsecase removeCarAsFavoriteUsecase;
  setUpAll(() {
    repositorry = CarRepositoryMock();
    removeCarAsFavoriteUsecase = RemoveCarAsFavoriteUsecaseImpl(carRepository: repositorry);
  });
  group('RemoveCarAsFavoriteUsecaseImpl', () {
    test('should remove car as favorite', () async {
      final dto = SetCarFavoriteDto(
        carId: Faker().randomGenerator.integer(9999),
        fullName: Faker().person.name(),
        telephone: Faker().phoneNumber.us(),
      );
      when(() => repositorry.removeCarFavorite(dto)).thenAnswer((_) async => (null, dto.carId));
      final result = await removeCarAsFavoriteUsecase(setCarFavoriteDto: dto);
      verify(() => repositorry.removeCarFavorite(dto)).called(1);
      expect(result.isSuccess, true);
      expect(result.getSuccess, isA<int>());
      expect(result.getSuccess, dto.carId);
    });

    test('should return ApplicationException', () async {
      final dto = SetCarFavoriteDto(
        carId: Faker().randomGenerator.integer(9999),
        fullName: Faker().person.name(),
        telephone: Faker().phoneNumber.us(),
      );
      final exception = ApplicationException(Faker().lorem.word());
      when(() => repositorry.removeCarFavorite(dto)).thenAnswer((_) async => (exception, null));
      final result = await removeCarAsFavoriteUsecase(setCarFavoriteDto: dto);
      verify(() => repositorry.removeCarFavorite(dto)).called(1);
      expect(result.isFailure, true);
      expect(result.getFailure, isA<ApplicationException>());
      expect(result.getFailure.message, exception.message);
    });
  });
}

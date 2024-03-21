import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ws_work_teste_mobile/src/core/domain/dtos/set_car_favorite.dart';
import 'package:ws_work_teste_mobile/src/core/domain/exceptions/application_exception.dart';
import 'package:ws_work_teste_mobile/src/core/domain/repositories/car_repository.dart';
import 'package:ws_work_teste_mobile/src/core/domain/usecases/car/save_car_as_favorite_usecase.dart';
import 'package:ws_work_teste_mobile/src/core/utils/result.dart';

import '../../../../../mocks/utils.dart';

void main() {
  late ICarRepository repository;
  late ISaveCarAsFavoriteUsecase saveCarAsFavoriteUsecase;
  setUp(() {
    repository = CarRepositoryMock();
    saveCarAsFavoriteUsecase = SaveCarAsFavoriteUsecaseImpl(repository: repository);
  });
  group('SaveCarAsFavoriteUsecaseImpl', () {
    test('should save car as favorite', () async {
      final entity = SetCarFavoriteDto(carId: Faker().randomGenerator.integer(9999));
      final id = Faker().randomGenerator.integer(9999);
      when(() => repository.setCarFavorite(entity)).thenAnswer((_) async => (null, id));

      final result = await saveCarAsFavoriteUsecase(setCarFavoriteDto: entity);
      verify(() => repository.setCarFavorite(entity)).called(1);

      expect(result.isSuccess, true);
      expect(result.getSuccess, isA<int>());
    });
    test('should return a ApplicationException', () async {
      final entity = SetCarFavoriteDto(carId: Faker().randomGenerator.integer(9999));
      final exception = ApplicationException(Faker().lorem.word());
      when(() => repository.setCarFavorite(entity)).thenAnswer((_) async => (exception, null));

      final result = await saveCarAsFavoriteUsecase(setCarFavoriteDto: entity);

      expect(result.isFailure, true);
      expect(result.getFailure, isA<ApplicationException>());
      expect(result.getFailure.message, exception.message);
    });
  });
}

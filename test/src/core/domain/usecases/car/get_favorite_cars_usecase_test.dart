import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ws_work_teste_mobile/src/core/domain/entities/favorite_car.dart';
import 'package:ws_work_teste_mobile/src/core/domain/exceptions/application_exception.dart';
import 'package:ws_work_teste_mobile/src/core/domain/repositories/car_repository.dart';
import 'package:ws_work_teste_mobile/src/core/domain/usecases/car/get_favorite_cars_usecase.dart';
import 'package:ws_work_teste_mobile/src/core/utils/result.dart';

class CarRepositoryMock extends Mock implements ICarRepository {}

void main() {
  late ICarRepository respository;
  late IGetFavoriteCarsUsecase getFavoriteCarsUsecase;
  setUp(() {
    respository = CarRepositoryMock();
    getFavoriteCarsUsecase = GetFavoriteCarsUsecaseImpl(respository);
  });
  group('GetFavoriteCarsUsecase', () {
    test('should return a list of favorite cars', () async {
      final favoriteCars = List.generate(
          3,
          (index) => FavoriteCarEntity(
                id: Faker().randomGenerator.integer(9999),
                carId: Faker().randomGenerator.integer(9999),
                isSync: Faker().randomGenerator.boolean(),
                fullName: Faker().person.name(),
                telephone: Faker().phoneNumber.us(),
              ));
      when(() => respository.getFavoriteCars()).thenAnswer((_) async => (null, favoriteCars));

      final result = await getFavoriteCarsUsecase();
      verify(() => respository.getFavoriteCars()).called(1);

      expect(result.isSuccess, true);
      expect(result.getSuccess, isA<List<FavoriteCarEntity>>());
      expect(result.getSuccess, favoriteCars);
    });

    test('should return a ApplicationException', () async {
      final exception = ApplicationException(Faker().lorem.word());
      when(() => respository.getFavoriteCars()).thenAnswer((_) async => (exception, null));

      final result = await getFavoriteCarsUsecase();
      verify(() => respository.getFavoriteCars()).called(1);

      expect(result.isFailure, true);
      expect(result.getFailure, isA<ApplicationException>());
      expect(result.getFailure.message, exception.message);
    });
  });
}

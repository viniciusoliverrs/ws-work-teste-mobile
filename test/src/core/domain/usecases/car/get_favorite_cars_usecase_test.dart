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
  final respository = CarRepositoryMock();
  final getFavoriteCarsUsecase = GetFavoriteCarsUsecaseImpl(respository);
  group('GetFavoriteCarsUsecase', () {
    test('should return a list of favorite cars', () async {
      final favoriteCars = List.generate(
          3,
          (index) => FavoriteCarEntity(
                id: Faker().randomGenerator.integer(9999),
                carId: Faker().randomGenerator.integer(9999),
                isSync: Faker().randomGenerator.boolean(),
              ));
      when(() => respository.getFavoriteCars()).thenAnswer((_) async => (null, favoriteCars));
      final result = await getFavoriteCarsUsecase();
      if (result.isSuccess) {
        final data = result.getSuccess;
        expect(data, isA<List<FavoriteCarEntity>>());
      } else {
        fail('should return a list of favorite cars');
      }
    });

    test('should return a ApplicationException', () async {
      when(() => respository.getFavoriteCars()).thenAnswer((_) async => (ApplicationException('Error'), null));
      final result = await getFavoriteCarsUsecase();
      if (result.isFailure) {
        final data = result.getFailure;
        expect(data, isA<ApplicationException>());
      } else {
        fail('should return a ApplicationException');
      }
    });
  });
}

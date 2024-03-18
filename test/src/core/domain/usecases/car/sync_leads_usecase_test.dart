import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ws_work_teste_mobile/src/core/domain/entities/favorite_car.dart';
import 'package:ws_work_teste_mobile/src/core/domain/exceptions/application_exception.dart';
import 'package:ws_work_teste_mobile/src/core/domain/repositories/car_repository.dart';
import 'package:ws_work_teste_mobile/src/core/domain/usecases/car/sync_leads_usecase.dart';
import 'package:ws_work_teste_mobile/src/core/domain/usecases/car/update_car_favorite_usecase.dart';
import 'package:ws_work_teste_mobile/src/core/utils/result.dart';

class CarRepositotyMock extends Mock implements ICarRepository {}

class UpdateCarAsFavoriteUsecaseMock extends Mock implements IUpdateCarAsFavoriteUsecase {}

void main() {
  final carRepository = CarRepositotyMock();
  final updateCarAsFavoriteUsecase = UpdateCarAsFavoriteUsecaseMock();
  final syncLeadsUseCase = SyncLeadsUsecaseImpl(
    carRepository: carRepository,
    updateCarAsFavoriteUsecase: updateCarAsFavoriteUsecase,
  );
  group('SyncLeadsUseCase', () {
    test('should sync leads', () async {
      final favoriteCars = List.generate(
          2,
          (index) => FavoriteCarEntity(
                id: index,
                isSync: true,
                carId: 1,
              ));
      when(() => carRepository.syncLeads(favoriteCars: favoriteCars)).thenAnswer((_) async => (null, true));
      for (var i = 0; i < favoriteCars.length; i++) {
        when(() => updateCarAsFavoriteUsecase(favoriteCars[i])).thenAnswer((_) async => (null, favoriteCars[i].id));
      }
      final result = await syncLeadsUseCase(favoriteCars);
      if (result.isSuccess) {
        final favoriteCars = result.getSuccess;
        expect(favoriteCars, isA<List<FavoriteCarEntity>>());
      } else {
        fail('should be success');
      }
    });

    test('should return error', () async {
      final favoriteCars = List.generate(
          2,
          (index) => FavoriteCarEntity(
                id: index,
                isSync: false,
                carId: 1,
              ));
      final exception = ApplicationException(Faker().lorem.word());
      when(() => carRepository.syncLeads(favoriteCars: favoriteCars)).thenAnswer((_) async => (exception, null));
      for (var i = 0; i < favoriteCars.length; i++) {
        when(() => updateCarAsFavoriteUsecase(favoriteCars[i])).thenAnswer((_) async => (null, favoriteCars[i].id));
      }
      final result = await syncLeadsUseCase(favoriteCars);
      if (result.isFailure) {
        final error = result.getFailure;
        expect(error, isA<ApplicationException>());
      } else {
        fail('should be error');
      }
    });
  });
}

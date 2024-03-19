import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ws_work_teste_mobile/src/core/domain/entities/favorite_car.dart';
import 'package:ws_work_teste_mobile/src/core/domain/exceptions/application_exception.dart';
import 'package:ws_work_teste_mobile/src/core/domain/repositories/car_repository.dart';
import 'package:ws_work_teste_mobile/src/core/domain/usecases/car/sync_leads_usecase.dart';
import 'package:ws_work_teste_mobile/src/core/utils/result.dart';

import '../../../../../mocks/utils.dart';

void main() {
  late ICarRepository carRepository;
  late UpdateCarAsFavoriteUsecaseMock updateCarAsFavoriteUsecase;
  late SyncLeadsUsecaseImpl syncLeadsUseCase;
  setUp(() {
    carRepository = CarRepositoryMock();
    updateCarAsFavoriteUsecase = UpdateCarAsFavoriteUsecaseMock();
    syncLeadsUseCase = SyncLeadsUsecaseImpl(carRepository: carRepository, updateCarAsFavoriteUsecase: updateCarAsFavoriteUsecase);
  });
  group('SyncLeadsUseCase', () {
    test('should return error', () async {
      final favoriteCars = List.generate(2, (index) => FavoriteCarEntity(id: index, isSync: false, carId: Faker().randomGenerator.integer(10)));
      final exception = ApplicationException(Faker().lorem.word());
      when(() => carRepository.syncLeads(favoriteCars: favoriteCars)).thenAnswer((_) async => (exception, null));
      for (var i = 0; i < favoriteCars.length; i++) {
        when(() => updateCarAsFavoriteUsecase(favoriteCars[i])).thenAnswer((_) async => (null, favoriteCars[i].id));
      }
      final result = await syncLeadsUseCase(favoriteCars);
      verify(() => carRepository.syncLeads(favoriteCars: favoriteCars)).called(1);

      expect(result.isFailure, true);
      expect(result.getFailure, isA<ApplicationException>());
      expect(result.getFailure.message, 'Error updating favorite cars');
    });

    test('should return error on update', () async {
      final favoriteCars = List.generate(2, (index) => FavoriteCarEntity(id: index, isSync: false, carId: Faker().randomGenerator.integer(10)));
      final exception = ApplicationException(Faker().lorem.word());
      when(() => carRepository.syncLeads(favoriteCars: favoriteCars)).thenAnswer((_) async => (null, true));
      for (var i = 0; i < favoriteCars.length; i++) {
        when(() => updateCarAsFavoriteUsecase(favoriteCars[i])).thenAnswer((_) async => (exception, null));
      }
      final result = await syncLeadsUseCase(favoriteCars);
      verify(() => carRepository.syncLeads(favoriteCars: favoriteCars)).called(1);
      expect(result.isFailure, true);
      expect(result.getFailure, isA<ApplicationException>());
      expect(result.getFailure.message, 'Error updating favorite cars');
    });
    // test('should sync leads', () async {
    //   final favoriteCars = List.generate(
    //       1,
    //       (index) => FavoriteCarEntity(
    //             id: Faker().randomGenerator.integer(10),
    //             isSync: false,
    //             carId: Faker().randomGenerator.integer(10),
    //           ));
    //   when(() async => carRepository.syncLeads(favoriteCars: favoriteCars)).thenAnswer((_) async => (null, true));
    //   for (var element in favoriteCars) {
    //     when(() => updateCarAsFavoriteUsecase(element)).thenAnswer((_) async => (null, element.carId));
    //   }

    //   final result = await syncLeadsUseCase(favoriteCars);
    //   verify(() => carRepository.syncLeads(favoriteCars: favoriteCars)).called(1);
    //   expect(result.isSuccess, true);
    //   expect(result.getSuccess, isA<List<FavoriteCarEntity>>());
    // });
  });
}

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ws_work_teste_mobile/src/core/domain/entities/car.dart';
import 'package:ws_work_teste_mobile/src/core/domain/exceptions/application_exception.dart';
import 'package:ws_work_teste_mobile/src/core/domain/repositories/car_repository.dart';
import 'package:ws_work_teste_mobile/src/core/domain/usecases/car/get_cars_usecase.dart';
import 'package:ws_work_teste_mobile/src/core/utils/result.dart';

class CarRepositoryMock extends Mock implements ICarRepository {}

void main() {
  group('GetCarsUsecase', () {
    late ICarRepository repository;
    late IGetCarsUsecase getCarsUsecase;
    setUp(() {
      repository = CarRepositoryMock();
      getCarsUsecase = GetCarsUsecaseImpl(repository);
    });
    test('should return a list of cars', () async {
      final cars = List.generate(
          10,
          (index) => CarEntity(
                id: index,
                color: Faker().randomGenerator.string(10),
                createdAt: Faker().date.dateTime(),
                modelId: Faker().randomGenerator.integer(10),
                doors: Faker().randomGenerator.integer(10),
                fuel: Faker().randomGenerator.string(10),
                modelName: Faker().randomGenerator.string(10),
                price: Faker().randomGenerator.decimal(),
                year: Faker().randomGenerator.integer(10),
              ));

      when(() => repository.getCars()).thenAnswer((_) async => (null, cars));

      final result = await getCarsUsecase();
      verify(() => repository.getCars()).called(1);

      expect(result.isSuccess, true);
      expect(result.getSuccess, isA<List<CarEntity>>());
      expect(result.getSuccess, cars);
    });

    test('should return a ApplicationException', () async {
      final exception = ApplicationException(Faker().randomGenerator.string(10));
      when(() => repository.getCars()).thenAnswer((_) async => (exception, null));

      final result = await getCarsUsecase();
      verify(() => repository.getCars()).called(1);

      expect(result.isFailure, true);
      expect(result.getFailure, isA<ApplicationException>());
      expect(result.getFailure.message, exception.message);
    });
  });
}

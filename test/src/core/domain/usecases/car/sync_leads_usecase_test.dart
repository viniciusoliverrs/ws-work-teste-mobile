import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ws_work_teste_mobile/src/core/domain/repositories/car_repository.dart';
import 'package:ws_work_teste_mobile/src/core/domain/usecases/car/update_car_favorite_usecase.dart';

class CarRepositotyMock extends Mock implements ICarRepository {}

class UpdateCarAsFavoriteUsecaseMock extends Mock implements IUpdateCarAsFavoriteUsecase {}

void main() {
  group('SyncLeadsUseCase', () {
    group('SyncLeadsUsecaseImpl', () {
      test('should sync leads', () async {
        // TODO: implement test leads
      });
    });
  });
}

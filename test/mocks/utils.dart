import 'package:mocktail/mocktail.dart';
import 'package:ws_work_teste_mobile/src/core/data/datasources/car_datasource.dart';
import 'package:ws_work_teste_mobile/src/core/data/datasources/local/local_datasource.dart';
import 'package:ws_work_teste_mobile/src/core/domain/repositories/car_repository.dart';
import 'package:ws_work_teste_mobile/src/core/domain/usecases/car/update_car_favorite_usecase.dart';
import 'package:ws_work_teste_mobile/src/core/utils/services/http/http.dart';

class CarRepositoryMock extends Mock implements ICarRepository {}

class UpdateCarAsFavoriteUsecaseMock extends Mock implements IUpdateCarAsFavoriteUsecase {}

class CarDatasourceMock extends Mock implements ICarDatasource {}

class HttpMock extends Mock implements IHttp {}

class LocalDatasourceMock extends Mock implements ILocalDatasource {}

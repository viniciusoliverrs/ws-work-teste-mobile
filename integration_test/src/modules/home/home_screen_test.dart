import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ws_work_teste_mobile/src/core/data/repositories/car_repository_impl.dart';
import 'package:ws_work_teste_mobile/src/core/domain/usecases/car/get_cars_usecase.dart';
import 'package:ws_work_teste_mobile/src/core/domain/usecases/car/get_favorite_cars_usecase.dart';
import 'package:ws_work_teste_mobile/src/core/domain/usecases/car/remove_car_as_favorite_usecase.dart';
import 'package:ws_work_teste_mobile/src/core/domain/usecases/car/save_car_as_favorite_usecase.dart';
import 'package:ws_work_teste_mobile/src/core/domain/usecases/car/sync_leads_usecase.dart';
import 'package:ws_work_teste_mobile/src/core/domain/usecases/car/update_car_favorite_usecase.dart';
import 'package:ws_work_teste_mobile/src/core/externals/datasources/local/car_local_datasource_impl.dart';
import 'package:ws_work_teste_mobile/src/core/externals/datasources/remote/car_remote_datasource_impl.dart';
import 'package:ws_work_teste_mobile/src/core/utils/services/http/http.dart';
import 'package:ws_work_teste_mobile/src/core/utils/services/http/http_response.dart';
import 'package:ws_work_teste_mobile/src/modules/home/presenter/controllers/home_controller.dart';
import 'package:ws_work_teste_mobile/src/modules/home/presenter/screens/home_screen.dart';

import '../../../../test/mocks/utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late IHttp http;
  late HomeController homeController;
  late CarRemoteDatasourceImpl carRemoteDatasourceImpl;
  late LocalDatasourceMock localDatasourceImpl;
  late CarLocalDatasourceImpl carLocalDatasourceImpl;
  late CarRepositoryImpl carRepositoryImpl;
  late GetCarsUsecaseImpl getCarsUsecaseImpl;
  late SyncLeadsUsecaseImpl syncLeadsUsecaseImpl;
  late UpdateCarAsFavoriteUsecaseImpl updateCarAsFavoriteUsecase;
  late GetFavoriteCarsUsecaseImpl getFavoriteCarsUsecaseImpl;
  late SaveCarAsFavoriteUsecaseImpl saveCarAsFavoriteUsecaseImpl;
  late RemoveCarAsFavoriteUsecaseImpl removeCarAsFavoriteUsecaseImpl;

  setUp(() {
    http = HttpMock();
    carRemoteDatasourceImpl = CarRemoteDatasourceImpl(http: http);
    localDatasourceImpl = LocalDatasourceMock();
    carLocalDatasourceImpl = CarLocalDatasourceImpl(localDatasource: localDatasourceImpl);
    carRepositoryImpl = CarRepositoryImpl(localDatasource: carLocalDatasourceImpl, remoteDatasource: carRemoteDatasourceImpl);
    getCarsUsecaseImpl = GetCarsUsecaseImpl(carRepositoryImpl);
    updateCarAsFavoriteUsecase = UpdateCarAsFavoriteUsecaseImpl(carRepository: carRepositoryImpl);
    getFavoriteCarsUsecaseImpl = GetFavoriteCarsUsecaseImpl(carRepositoryImpl);
    syncLeadsUsecaseImpl = SyncLeadsUsecaseImpl(carRepository: carRepositoryImpl, updateCarAsFavoriteUsecase: updateCarAsFavoriteUsecase);
    saveCarAsFavoriteUsecaseImpl = SaveCarAsFavoriteUsecaseImpl(repository: carRepositoryImpl);
    removeCarAsFavoriteUsecaseImpl = RemoveCarAsFavoriteUsecaseImpl(carRepository: carRepositoryImpl);
    homeController = HomeController(
      getCarsUsecase: getCarsUsecaseImpl,
      syncLeadsUsecase: syncLeadsUsecaseImpl,
      getFavoriteCarsUsecase: getFavoriteCarsUsecaseImpl,
      saveCarAsFavoriteUsecase: saveCarAsFavoriteUsecaseImpl,
      removeCarAsFavoriteUsecase: removeCarAsFavoriteUsecaseImpl,
    );
  });

  group('HomeScreen E2E Test', () {
    testWidgets('should render HomeScreen', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: HomeScreen(controller: homeController),
      ));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('home_screen')), findsOneWidget);
    });

    testWidgets('should render HomeScreen with cars', (WidgetTester tester) async {
      when(() => http.get(endpoint: "/cars.json")).thenAnswer((_) async => HttpResponse(data: getCarJson()));
      await tester.pumpWidget(MaterialApp(
        home: HomeScreen(controller: homeController),
      ));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 1));
      expect(find.byKey(const Key('home_screen')), findsOneWidget);
      expect(find.byKey(const Key('car_list_view_widget')), findsOneWidget);
    });

    
  });
}

Map getCarJson() {
  return {
    "cars": [
      {
        "id": 1,
        "timestamp_cadastro": 1696539488,
        "modelo_id": 12,
        "ano": 2015,
        "combustivel": "FLEX",
        "num_portas": 4,
        "cor": "BEGE",
        "nome_modelo": "ONIX PLUS",
        "valor": 50.000,
      },
    ]
  };
}

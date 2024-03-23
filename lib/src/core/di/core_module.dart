import 'package:flutter_modular/flutter_modular.dart';
import 'package:ws_work_teste_mobile/src/core/data/datasources/local/local_datasource.dart';
import 'package:ws_work_teste_mobile/src/core/externals/datasources/local/local_datasource_impl.dart';

import '../data/datasources/car_remote_datasource.dart';
import '../data/datasources/local/car_local_datasource.dart';
import '../data/repositories/car_repository_impl.dart';
import '../domain/repositories/car_repository.dart';
import '../domain/usecases/car/get_cars_usecase.dart';
import '../domain/usecases/car/get_favorite_cars_usecase.dart';
import '../domain/usecases/car/remove_car_as_favorite_usecase.dart';
import '../domain/usecases/car/save_car_as_favorite_usecase.dart';
import '../domain/usecases/car/sync_leads_usecase.dart';
import '../domain/usecases/car/update_car_favorite_usecase.dart';
import '../externals/datasources/local/car_local_datasource_impl.dart';
import '../externals/datasources/remote/car_remote_datasource_impl.dart';
import '../utils/constants/api.dart';
import '../utils/services/http/http.dart';
import '../utils/services/http/http_impl.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.add<IHttp>(() => HttpImpl(
          baseUrl: Api.baseUrl,
          interceptors: [],
        ));
    i.add<ILocalDatasource>(() => LocalDatasourceImpl(databaseName: "cars", migrations: [
          "DROP TABLE IF EXISTS cars;",
          "CREATE TABLE cars (id INTEGER PRIMARY KEY, car_id INTEGER, is_sync INTEGER,full_name TEXT,telephone TEXT);",
        ]));
    i.add<ICarLocalDatasource>(CarLocalDatasourceImpl.new);
    i.add<ICarRemoteDatasource>(CarRemoteDatasourceImpl.new);
    i.add<ICarRepository>(CarRepositoryImpl.new);
    i.add<IGetCarsUsecase>(GetCarsUsecaseImpl.new);
    i.add<ISyncLeadsUsecase>(SyncLeadsUsecaseImpl.new);
    i.add<IUpdateCarAsFavoriteUsecase>(UpdateCarAsFavoriteUsecaseImpl.new);
    i.add<IGetFavoriteCarsUsecase>(GetFavoriteCarsUsecaseImpl.new);
    i.add<ISaveCarAsFavoriteUsecase>(SaveCarAsFavoriteUsecaseImpl.new);
    i.add<IRemoveCarAsFavoriteUsecase>(RemoveCarAsFavoriteUsecaseImpl.new);
    super.exportedBinds(i);
  }
}

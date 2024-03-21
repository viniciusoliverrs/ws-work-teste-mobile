import '../../domain/dtos/set_car_favorite.dart';
import '../../domain/entities/car.dart';
import '../../domain/entities/favorite_car.dart';
import '../../domain/exceptions/application_exception.dart';
import '../../domain/exceptions/mapper_exception.dart';
import '../../domain/repositories/car_repository.dart';
import '../../utils/result.dart';
import '../datasources/car_remote_datasource.dart';
import '../datasources/local/car_local_datasource.dart';
import '../mappers/car_mapper.dart';
import '../mappers/favorite_car_mapper.dart';
import '../mappers/set_car_favorite_mapper.dart';

class CarRepositoryImpl implements ICarRepository {
  final ICarRemoteDatasource remoteDatasource;
  final ICarLocalDatasource localDatasource;
  CarRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });
  @override
  Future<Result<ApplicationException, List<CarEntity>>> getCars() async {
    try {
      final carsMap = await remoteDatasource.getCars();
      final carsEntity = carsMap.map((carMap) => CarMapper.fromMap(carMap)).toList();
      return (null, carsEntity);
    } on ApplicationException catch (e) {
      return (e, null);
    } on MapperException catch (e) {
      return (ApplicationException(e.message, stackTrace: e.stackTrace), null);
    } catch (e, s) {
      return (ApplicationException(e.toString(), stackTrace: s), null);
    }
  }

  @override
  Future<Result<ApplicationException, int>> setCarFavorite(SetCarFavoriteDto setCarFavorite) async {
    try {
      final map = SetCarFavoriteMapper.toMap(setCarFavorite);
      final result = await localDatasource.setCarFavorite(map: map);
      return (null, result);
    } on ApplicationException catch (e) {
      return (e, null);
    } on MapperException catch (e) {
      return (ApplicationException(e.message, stackTrace: e.stackTrace), null);
    } catch (e, s) {
      return (ApplicationException(e.toString(), stackTrace: s), null);
    }
  }

  @override
  Future<Result<ApplicationException, List<FavoriteCarEntity>>> getFavoriteCars() async {
    try {
      final carsMap = await localDatasource.getCarsFavorite();
      final carsEntity = carsMap.map((carMap) => FavoriteCarMapper.fromMap(carMap)).toList();
      return (null, carsEntity);
    } on ApplicationException catch (e) {
      return (e, null);
    } on MapperException catch (e) {
      return (ApplicationException(e.message, stackTrace: e.stackTrace), null);
    } catch (e, s) {
      return (ApplicationException(e.toString(), stackTrace: s), null);
    }
  }

  @override
  Future<Result<ApplicationException, int>> removeCarFavorite(SetCarFavoriteDto setCarFavorite) async {
    try {
      final result = await localDatasource.removeCarFavorite(carId: setCarFavorite.carId);
      return (null, result);
    } on ApplicationException catch (e) {
      return (e, null);
    } on MapperException catch (e) {
      return (ApplicationException(e.message, stackTrace: e.stackTrace), null);
    } catch (e, s) {
      return (ApplicationException(e.toString(), stackTrace: s), null);
    }
  }

  @override
  Future<Result<ApplicationException, bool>> syncLeads({required List<FavoriteCarEntity> favoriteCars}) async {
    try {
      final favoriteCarsMap = favoriteCars.map((car) => FavoriteCarMapper.toMap(car)).toList();
      final result = await remoteDatasource.syncLeads(favoriteCars: favoriteCarsMap);
      return (null, result);
    } on ApplicationException catch (e) {
      return (e, null);
    } on MapperException catch (e) {
      return (ApplicationException(e.message, stackTrace: e.stackTrace), null);
    } catch (e, s) {
      return (ApplicationException(e.toString(), stackTrace: s), null);
    }
  }

  @override
  Future<Result<ApplicationException, int>> updateCarAsFavorite(FavoriteCarEntity dto) async {
    try {
      final map = FavoriteCarMapper.toMap(dto);
      final result = await localDatasource.updateCarAsFavorite(map: map);
      return (null, result);
    } on ApplicationException catch (e) {
      return (e, null);
    } on MapperException catch (e) {
      return (ApplicationException(e.message, stackTrace: e.stackTrace), null);
    } catch (e, s) {
      return (ApplicationException(e.toString(), stackTrace: s), null);
    }
  }
}

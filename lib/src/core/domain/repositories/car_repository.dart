import '../../utils/result.dart';
import '../dtos/set_car_favorite.dart';
import '../entities/car.dart';
import '../entities/favorite_car.dart';
import '../exceptions/application_exception.dart';

abstract interface class ICarRepository {
  Future<Result<ApplicationException, List<CarEntity>>> getCars();
  Future<Result<ApplicationException, List<FavoriteCarEntity>>> getFavoriteCars();
  Future<Result<ApplicationException, int>> setCarFavorite(SetCarFavoriteDto setCarFavorite);
  Future<Result<ApplicationException, int>> removeCarFavorite(SetCarFavoriteDto setCarFavorite);
  Future<Result<ApplicationException, bool>> syncLeads({required List<FavoriteCarEntity> favoriteCars});
  Future<Result<ApplicationException, int>> updateCarAsFavorite(FavoriteCarEntity favoriteCarEntity);
}

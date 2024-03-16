import '../../../utils/result.dart';
import '../../entities/favorite_car.dart';
import '../../exceptions/application_exception.dart';
import '../../repositories/car_repository.dart';

abstract interface class IGetFavoriteCarsUsecase {
  Future<Result<ApplicationException, List<FavoriteCarEntity>>> call();
}

class GetFavoriteCarsUsecaseImpl implements IGetFavoriteCarsUsecase {
  final ICarRepository repository;

  GetFavoriteCarsUsecaseImpl(this.repository);

  @override
  Future<Result<ApplicationException, List<FavoriteCarEntity>>> call() async {
    return await repository.getFavoriteCars();
  }
}

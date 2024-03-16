import '../../../utils/result.dart';
import '../../entities/favorite_car.dart';
import '../../exceptions/application_exception.dart';
import '../../repositories/car_repository.dart';
import 'update_car_favorite_usecase.dart';

abstract interface class ISyncLeadsUsecase {
  Future<Result<ApplicationException, List<FavoriteCarEntity>>> call(List<FavoriteCarEntity> favoriteCars);
}

class SyncLeadsUsecaseImpl implements ISyncLeadsUsecase {
  final ICarRepository carRepository;
  final IUpdateCarAsFavoriteUsecase updateCarAsFavoriteUsecase;

  SyncLeadsUsecaseImpl({
    required this.carRepository,
    required this.updateCarAsFavoriteUsecase,
  });

  @override
  Future<Result<ApplicationException, List<FavoriteCarEntity>>> call(List<FavoriteCarEntity> favoriteCars) async {
    favoriteCars = favoriteCars.where((m) => !m.isSync).toList();
    if (favoriteCars.isEmpty) return (null, favoriteCars);

    final syncResponse = await carRepository.syncLeads(favoriteCars: favoriteCars);
    if (syncResponse.isSuccess) {
      favoriteCars = favoriteCars.map((m) => m.copyWith(isSync: true)).toList();
      final favoriteCarsFutureUpdated = favoriteCars.map((m) => updateCarAsFavoriteUsecase(m)).toList();
      final responses = await Future.wait(favoriteCarsFutureUpdated);
      if (responses.every((r) => r.isSuccess)) {
        return (null, favoriteCars);
      }
    }
    return (ApplicationException('Error updating favorite cars'), null);
  }
}

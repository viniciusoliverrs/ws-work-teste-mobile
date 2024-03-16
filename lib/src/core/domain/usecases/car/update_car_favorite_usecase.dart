import '../../../utils/result.dart';
import '../../entities/favorite_car.dart';
import '../../exceptions/application_exception.dart';
import '../../repositories/car_repository.dart';

abstract interface class IUpdateCarAsFavoriteUsecase {
  Future<Result<ApplicationException, int>> call(FavoriteCarEntity dto);
}

class UpdateCarAsFavoriteUsecaseImpl implements IUpdateCarAsFavoriteUsecase {
  final ICarRepository carRepository;

  UpdateCarAsFavoriteUsecaseImpl({
    required this.carRepository,
  });

  @override
  Future<Result<ApplicationException, int>> call(FavoriteCarEntity dto) async {
    return await carRepository.updateCarAsFavorite(dto);
  }
}

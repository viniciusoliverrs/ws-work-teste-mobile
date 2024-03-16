import '../../../utils/result.dart';
import '../../dtos/set_car_favorite.dart';
import '../../exceptions/application_exception.dart';
import '../../repositories/car_repository.dart';

abstract interface class ISaveCarAsFavoriteUsecase {
  Future<Result<ApplicationException, int>> call({required SetCarFavoriteDto setCarFavoriteDto});
}

class SaveCarAsFavoriteUsecaseImpl implements ISaveCarAsFavoriteUsecase {
  final ICarRepository carRepository;
  SaveCarAsFavoriteUsecaseImpl({
    required this.carRepository,
  });
  @override
  Future<Result<ApplicationException, int>> call({required SetCarFavoriteDto setCarFavoriteDto}) async {
    return await carRepository.setCarFavorite(setCarFavoriteDto);
  }
}

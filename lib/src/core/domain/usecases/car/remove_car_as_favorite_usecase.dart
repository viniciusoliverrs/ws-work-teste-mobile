import 'package:ws_work_teste_mobile/src/core/utils/result.dart';

import '../../dtos/set_car_favorite.dart';
import '../../exceptions/application_exception.dart';
import '../../repositories/car_repository.dart';

abstract interface class IRemoveCarAsFavoriteUsecase {
  Future<Result<ApplicationException,int>> call({required SetCarFavoriteDto setCarFavoriteDto});
}

class RemoveCarAsFavoriteUsecaseImpl implements IRemoveCarAsFavoriteUsecase {
  final ICarRepository carRepository;
  RemoveCarAsFavoriteUsecaseImpl({
    required this.carRepository,
  });
  @override
  Future<Result<ApplicationException,int>> call({required SetCarFavoriteDto setCarFavoriteDto}) async {
    return await carRepository.removeCarFavorite(setCarFavoriteDto);
  }
}
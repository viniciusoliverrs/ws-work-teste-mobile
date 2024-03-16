import '../../../utils/result.dart';
import '../../entities/car.dart';
import '../../exceptions/application_exception.dart';
import '../../repositories/car_repository.dart';

abstract interface class IGetCarsUsecase {
  Future<Result<ApplicationException, List<CarEntity>>> call();
}

class GetCarsUsecaseImpl implements IGetCarsUsecase {
  final ICarRepository repository;

  GetCarsUsecaseImpl(this.repository);

  @override
  Future<Result<ApplicationException, List<CarEntity>>> call() async {
    return await repository.getCars();
  }
}

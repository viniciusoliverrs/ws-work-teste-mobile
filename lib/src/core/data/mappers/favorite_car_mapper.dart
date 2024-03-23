import '../../domain/entities/favorite_car.dart';
import '../../domain/exceptions/mapper_exception.dart';

class FavoriteCarMapper {
  static FavoriteCarEntity fromMap(Map<String, dynamic> map) {
    try {
      return FavoriteCarEntity(
        id: map['id'] ?? 0,
        carId: map['car_id'] ?? 0,
        isSync: map['is_sync'] == 1,
        fullName: map['full_name'] ?? '',
        telephone: map['telephone'] ?? '',
      );
    } catch (exception, stacktrace) {
      throw MapperException('Was not possible to map the favorite car.', stackTrace: stacktrace);
    }
  }

  static Map<String, dynamic> toMap(FavoriteCarEntity favoriteCar) {
    return {
      'id': favoriteCar.id,
      'car_id': favoriteCar.carId,
      'is_sync': favoriteCar.isSync ? 1 : 0,
      'full_name': favoriteCar.fullName,
      'telephone': favoriteCar.telephone,
    };
  }
}

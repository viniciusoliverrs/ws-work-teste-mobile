import '../../domain/dtos/set_car_favorite.dart';
import '../../domain/exceptions/mapper_exception.dart';

class SetCarFavoriteMapper {
  static SetCarFavoriteDto fromMap(Map<String, dynamic> map) {
    try {
      return SetCarFavoriteDto(
        carId: map['car_id'] ?? 0,
      );
    } catch (exception, stacktrace) {
      throw MapperException('Was not possible to map the set car favorite.', stackTrace: stacktrace);
    }
  }

  static Map<String, dynamic> toMap(SetCarFavoriteDto setCarFavorite) {
    try {
      return {
        'car_id': setCarFavorite.carId,
      };
    } catch (exception, stacktrace) {
      throw MapperException('Was not possible to map the set car favorite.', stackTrace: stacktrace);
    }
  }
}

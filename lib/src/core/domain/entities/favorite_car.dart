import 'base/entity.dart';

class FavoriteCarEntity extends Entity<int> {
  final int carId;
  final bool isSync;
  const FavoriteCarEntity({
    required super.id,
    required this.carId,
    this.isSync = false,
  });

  FavoriteCarEntity copyWith({
    int? id,
    int? carId,
    bool? isSync,
  }) {
    return FavoriteCarEntity(
      id: id ?? this.id,
      carId: carId ?? this.carId,
      isSync: isSync ?? this.isSync,
    );
  }

  @override
  List<Object> get props => [id, carId, isSync];
}

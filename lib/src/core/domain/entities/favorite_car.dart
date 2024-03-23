import 'base/entity.dart';

class FavoriteCarEntity extends Entity<int> {
  final int carId;
  final bool isSync;
  final String fullName;
  final String telephone;
  const FavoriteCarEntity({
    required super.id,
    required this.carId,
    this.isSync = false,
    required this.fullName,
    required this.telephone,
  });

  FavoriteCarEntity copyWith({
    int? id,
    int? carId,
    bool? isSync,
    String? fullName,
    String? telephone,
  }) {
    return FavoriteCarEntity(
      id: id ?? this.id,
      carId: carId ?? this.carId,
      isSync: isSync ?? this.isSync,
      fullName: fullName ?? this.fullName,
      telephone: telephone ?? this.telephone,
    );
  }

  @override
  List<Object> get props => [id, carId, isSync, fullName, telephone];
}

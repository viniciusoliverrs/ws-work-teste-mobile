import 'base/entity.dart';

class CarEntity extends Entity<int>{
  final DateTime createdAt;
  final int modelId;
  final int year;
  final String fuel;
  final int doors;
  final String color;
  final String modelName;
  final double price;
  final bool isFavorite;
  const CarEntity({
    required super.id,
    required this.createdAt,
    required this.modelId,
    required this.year,
    required this.fuel,
    required this.doors,
    required this.color,
    required this.modelName,
    required this.price,
    this.isFavorite = false,
  });

  CarEntity copyWith({
    int? id,
    DateTime? createdAt,
    int? modelId,
    int? year,
    String? fuel,
    int? doors,
    String? color,
    String? modelName,
    double? price,
    bool? isFavorite,
  }) {
    return CarEntity(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      modelId: modelId ?? this.modelId,
      year: year ?? this.year,
      fuel: fuel ?? this.fuel,
      doors: doors ?? this.doors,
      color: color ?? this.color,
      modelName: modelName ?? this.modelName,
      price: price ?? this.price,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
  
  @override
  List<Object?> get props => [id, createdAt, modelId, year, fuel, doors, color, modelName, price, isFavorite];
}


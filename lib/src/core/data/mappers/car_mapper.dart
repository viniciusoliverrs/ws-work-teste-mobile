import '../../domain/entities/car.dart';
import '../../domain/exceptions/mapper_exception.dart';

class CarMapper {
  static CarEntity fromMap(Map<String, dynamic> json) {
    try {
      return CarEntity(
        id: json['id'] ?? 0,
        createdAt: DateTime.fromMillisecondsSinceEpoch(json['timestamp_cadastro']),
        modelId: json['modelo_id'] ?? 0,
        year: json['ano'] ?? 0,
        fuel: json['combustivel'] ?? '',
        doors: json['num_portas'] ?? 0,
        color: json['cor'] ?? '',
        modelName: json['nome_modelo'] ?? '',
        price: json['valor'] ?? 0.0,
      );
    } catch (exception, stacktrace) {
      throw MapperException('Was not possible to map the car.', stackTrace: stacktrace);
    }
  }

  static Map<String, dynamic> toMap(CarEntity car) {
    try {
      return {
        'id': car.id,
        'timestamp_cadastro': car.createdAt.millisecondsSinceEpoch,
        'modelo_id': car.modelId,
        'ano': car.year,
        'combustivel': car.fuel,
        'num_portas': car.doors,
        'cor': car.color,
        'nome_modelo': car.modelName,
        'valor': car.price,
      };
    } catch (exception, stacktrace) {
      throw MapperException('Was not possible to map the car.', stackTrace: stacktrace);
    }
  }
}

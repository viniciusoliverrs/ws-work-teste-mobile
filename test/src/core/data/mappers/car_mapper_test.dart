import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ws_work_teste_mobile/src/core/data/mappers/car_mapper.dart';
import 'package:ws_work_teste_mobile/src/core/domain/exceptions/mapper_exception.dart';

void main() {
  group('CarMapper', () {
    test('fromMap exception', () {
      final json = {
        "id": Faker().randomGenerator.integer(9999),
        "timestamp_cadastro": null,
        "modelo_id": Faker().randomGenerator.integer(9999),
        "ano": Faker().randomGenerator.integer(9999),
        "combustivel": Faker().randomGenerator.string(10),
        "num_portas": Faker().randomGenerator.integer(9999),
        "cor": Faker().randomGenerator.string(10),
        "nome_modelo": Faker().randomGenerator.string(10),
        "valor": Faker().randomGenerator.decimal(),
      };

      expect(() => CarMapper.fromMap(json), throwsA(isA<MapperException>()));
    });
    test('fromMap', () {
      final json = {
        "id": Faker().randomGenerator.integer(9999),
        "timestamp_cadastro": DateTime.now().millisecondsSinceEpoch,
        "modelo_id": Faker().randomGenerator.integer(9999),
        "ano": Faker().randomGenerator.integer(9999),
        "combustivel": Faker().randomGenerator.string(10),
        "num_portas": Faker().randomGenerator.integer(9999),
        "cor": Faker().randomGenerator.string(10),
        "nome_modelo": Faker().randomGenerator.string(10),
        "valor": Faker().randomGenerator.decimal(),
      };

      final result = CarMapper.fromMap(json);

      expect(result.id, json['id']);
      expect(result.createdAt.millisecondsSinceEpoch, json['timestamp_cadastro']);
      expect(result.modelId, json['modelo_id']);
      expect(result.year, json['ano']);
      expect(result.fuel, json['combustivel']);
      expect(result.doors, json['num_portas']);
      expect(result.color, json['cor']);
      expect(result.modelName, json['nome_modelo']);
      expect(result.price, json['valor']);
    });

    test('toMap', () {
      final car = CarMapper.fromMap({
        "id": Faker().randomGenerator.integer(9999),
        "timestamp_cadastro": DateTime.now().millisecondsSinceEpoch,
        "modelo_id": Faker().randomGenerator.integer(9999),
        "ano": Faker().randomGenerator.integer(9999),
        "combustivel": Faker().randomGenerator.string(10),
        "num_portas": Faker().randomGenerator.integer(9999),
        "cor": Faker().randomGenerator.string(10),
        "nome_modelo": Faker().randomGenerator.string(10),
        "valor": Faker().randomGenerator.decimal(),
      });

      final result = CarMapper.toMap(car);

      expect(result['id'], car.id);
      expect(result['timestamp_cadastro'], car.createdAt.millisecondsSinceEpoch);
      expect(result['modelo_id'], car.modelId);
      expect(result['ano'], car.year);
      expect(result['combustivel'], car.fuel);
      expect(result['num_portas'], car.doors);
      expect(result['cor'], car.color);
      expect(result['nome_modelo'], car.modelName);
      expect(result['valor'], car.price);
    });
  });
}

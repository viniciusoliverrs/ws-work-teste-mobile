import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ws_work_teste_mobile/src/core/domain/entities/car.dart';
import 'package:ws_work_teste_mobile/src/modules/home/presenter/screens/components/cars_listview.dart';

void main() {
  group('CarsListView widget', () {
    testWidgets('should display a list of cars', (WidgetTester tester) async {
      final cars = List.generate(
          3,
          (index) => CarEntity(
                id: index + 1,
                modelName: Faker().randomGenerator.string(6),
                doors: Faker().randomGenerator.integer(4),
                year: Faker().randomGenerator.integer(2022),
                price: Faker().randomGenerator.decimal(),
                isFavorite: Faker().randomGenerator.boolean(),
                color: Faker().randomGenerator.string(6),
                createdAt: DateTime.now(),
                fuel: Faker().randomGenerator.string(6),
                modelId: Faker().randomGenerator.integer(10),
              ));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CarsListView(
              cars: cars,
              onTap: (car) {},
            ),
          ),
        ),
      );
      final listView = find.byKey(const Key('cars_listview'));

      expect(listView, findsOneWidget);
      expect(find.byType(CarItemTile), findsNWidgets(cars.length));
    });

    testWidgets('should call onTap when a car is tapped', (WidgetTester tester) async {
      final cars = List.generate(
          1,
          (index) => CarEntity(
                id: index,
                modelName: Faker().randomGenerator.string(6),
                doors: Faker().randomGenerator.integer(4),
                year: Faker().randomGenerator.integer(2022),
                price: Faker().randomGenerator.decimal(),
                isFavorite: false,
                color: Faker().randomGenerator.string(6),
                createdAt: DateTime.now(),
                fuel: Faker().randomGenerator.string(6),
                modelId: Faker().randomGenerator.integer(10),
              ));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CarsListView(
              cars: cars,
              onTap: (car) {
                final carIndex = cars.indexWhere((c) => c.id == car.id);
                cars[carIndex] = car.copyWith(isFavorite: true);
              },
            ),
          ),
        ),
      );

      final listView = find.byKey(const Key('cars_listview'));
      expect(listView, findsOneWidget);

      final carItemTile = find.byType(GestureDetector).first;
      await tester.tap(carItemTile);
      await tester.pump();

      expect(cars.first.isFavorite, true);
    });

    testWidgets('should display a message when the list is empty', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CarsListView(
              cars: const [],
              onTap: (car) {},
            ),
          ),
        ),
      );

      final listView = find.byKey(const Key('cars_listview'));
      expect(listView, findsNothing);

      final emptyListMessage = find.byKey(const Key('empty_list_icon'));
      expect(emptyListMessage, findsOneWidget);
    });
  });
}

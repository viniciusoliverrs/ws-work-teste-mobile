import 'package:flutter/material.dart';

import '../../../../../core/domain/entities/car.dart';
import 'car_item_tile.dart';

class CarsListViewWidget extends StatelessWidget {
  final List<CarEntity> cars;
  final Function(CarEntity) onTap;
  const CarsListViewWidget({
    super.key,
    required this.cars,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: cars.isNotEmpty,
      replacement: const Center(
        child: Icon(
          key: Key('empty_list_icon'),
          Icons.car_rental_outlined,
          size: 100,
          color: Colors.grey,
        ),
      ),
      child: ListView.separated(
        key: const Key('cars_listview'),
        itemCount: cars.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) => CarItemTileWidget(
          car: cars[index],
          onTap: onTap,
        ),
      ),
    );
  }
}

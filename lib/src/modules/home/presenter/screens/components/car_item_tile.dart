import 'package:flutter/material.dart';

import '../../../../../core/domain/entities/car.dart';

class CarItemTileWidget extends StatelessWidget {
  const CarItemTileWidget({
    super.key,
    required this.car,
    required this.onTap,
  });

  final CarEntity car;
  final Function(CarEntity car) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(car.modelName),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Portas: ',
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                          text: car.doors.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Ano: ',
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                          text: car.year.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Preço: ',
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                          text: car.price.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => onTap(car),
                    child: Row(
                      children: [
                        Icon(
                          car.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: car.isFavorite ? Colors.red : Colors.grey,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

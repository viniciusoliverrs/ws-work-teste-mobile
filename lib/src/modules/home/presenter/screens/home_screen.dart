// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../controllers/home_controller.dart';
import '../states/home_state.dart';
import 'components/cars_listview.dart';

class HomeScreen extends StatefulWidget {
  final HomeController controller;
  const HomeScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ValueListenableBuilder(
          valueListenable: widget.controller,
          builder: (_, state, __) {
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: state is HomeLoadingState ? 0 : 1,
              child: Column(
                children: [
                  if (state is HomeLoadedState)
                    Expanded(
                      child: CarsListView(
                        cars: state.cars,
                        onTap: (car) => widget.controller.favoriteCar(car.id),
                      ),
                    ),
                ],
              ),
            );
          }),
    );
  }
}

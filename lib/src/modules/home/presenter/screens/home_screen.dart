// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ws_work_teste_mobile/src/app/theme/extensions/common_theme_extension.dart';
import 'package:ws_work_teste_mobile/src/core/utils/extensions/theme_extension.dart';

import '../../../../core/data/services/toast_service.dart';
import '../controllers/home_controller.dart';
import '../states/home_state.dart';
import '../viewmodels/contact_viewmodel.dart';
import 'components/cars_listview.dart';
import 'components/form_contact.dart';

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
  final fullNameController = TextEditingController();
  final telephoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.getExtension<CommonThemeExtension>();
    return Scaffold(
      backgroundColor: theme?.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Home',
          style: theme?.paragraph1,
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: widget.controller,
          builder: (_, state, __) {
            if (state is HomeErrorState) {
              WidgetsBinding.instance.addPostFrameCallback((_) => ToastService.show(context, message: state.message));
            }

            return AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: state is HomeLoadingState ? 0 : 1,
              child: Column(
                children: [
                  if (state is HomeLoadedState)
                    Expanded(
                      child: CarsListViewWidget(
                        cars: state.cars,
                        onTap: (car) async {
                          if (car.isFavorite) {
                            await widget.controller.removeFavoriteCar(car.id);
                          } else {
                            final viewModel = await showDialog(
                              context: context,
                              builder: (_) {
                                return FormContactWidget(
                                  fullNameController: fullNameController,
                                  telephoneController: telephoneController,
                                );
                              },
                            );
                            if (viewModel is ContactViewModel) {
                              await widget.controller.addFavoriteCar(carId: car.id, contactViewModel: viewModel);
                            }
                          }
                        },
                      ),
                    ),
                ],
              ),
            );
          }),
    );
  }
}

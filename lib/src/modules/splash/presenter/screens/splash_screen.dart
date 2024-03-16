// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../controllers/splash_controller.dart';
import '../states/splash_state.dart';

class SplashScreen extends StatefulWidget {
  final SplashController controller;
  const SplashScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
        body: ValueListenableBuilder(
      valueListenable: widget.controller,
      builder: (context, state, child) {
        if (state is SplashLoadedState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Modular.to.navigate(state.route);
          });
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}

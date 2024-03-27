// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ws_work_teste_mobile/src/core/utils/extensions/build_context_extension.dart';

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
            context.navigate(state.route);
          });
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}

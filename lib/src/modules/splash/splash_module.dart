import 'package:flutter_modular/flutter_modular.dart';
import 'package:ws_work_teste_mobile/src/modules/splash/presenter/controllers/splash_controller.dart';

import 'presenter/screens/splash_screen.dart';

class SplashModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<SplashController>(SplashController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => SplashScreen(
        controller: Modular.get<SplashController>(),
      ),
    );
  }
}

import 'package:flutter_modular/flutter_modular.dart';

import '../core/utils/constants/app_routes.dart';
import '../modules/home/home_module.dart';
import '../modules/splash/splash_module.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.module(AppRoutes.splash, module: SplashModule());
    r.module(AppRoutes.home, module: HomeModule());
    super.routes(r);
  }
}

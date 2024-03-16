import 'package:flutter_modular/flutter_modular.dart';

import '../../core/core_module.dart';
import 'presenter/controllers/home_controller.dart';
import 'presenter/screens/home_screen.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [
    CoreModule(),
  ];	
  @override
  void binds(Injector i) {
    i.addSingleton<HomeController>(HomeController.new);
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => HomeScreen(controller: Modular.get<HomeController>()));
    super.routes(r);
  }
}

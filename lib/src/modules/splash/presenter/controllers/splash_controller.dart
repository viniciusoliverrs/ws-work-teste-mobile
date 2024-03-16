import '../../../../core/utils/base_controller.dart';
import '../../../../core/utils/constants/app_routes.dart';
import '../states/splash_state.dart';

class SplashController extends BaseController<SplashState> {
  SplashController() : super(SplashInitialState());

  Future<void> initialize() async {
    emit(SplashLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(SplashLoadedState(AppRoutes.home));
  }

}

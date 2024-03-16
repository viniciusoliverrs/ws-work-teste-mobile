abstract class SplashState {}

class SplashInitialState extends SplashState {}

class SplashLoadingState extends SplashState {}
class SplashLoadedState extends SplashState {
  final String route;
  SplashLoadedState(this.route);
}

class SplashErrorState extends SplashState {
  final String message;
  SplashErrorState(this.message);
}

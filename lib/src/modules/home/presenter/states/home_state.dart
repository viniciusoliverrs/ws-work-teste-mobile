import '../../../../core/domain/entities/car.dart';
import '../../../../core/domain/entities/favorite_car.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  List<CarEntity> cars;
  List<FavoriteCarEntity> favoriteCars;
  HomeLoadedState({
    required this.cars,
     this.favoriteCars = const [],
  });

  HomeLoadedState copyWith({
    List<CarEntity>? cars,
    List<FavoriteCarEntity>? favoriteCars,
  }) {
    return HomeLoadedState(
      cars: cars ?? this.cars,
      favoriteCars: favoriteCars ?? this.favoriteCars,
    );
  }
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState(this.message);
}

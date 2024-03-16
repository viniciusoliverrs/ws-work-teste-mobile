import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ws_work_teste_mobile/src/core/domain/usecases/car/sync_leads_usecase.dart';
import 'package:ws_work_teste_mobile/src/core/utils/result.dart';

import '../../../../core/domain/dtos/set_car_favorite.dart';
import '../../../../core/domain/entities/car.dart';
import '../../../../core/domain/usecases/car/get_cars_usecase.dart';
import '../../../../core/domain/usecases/car/get_favorite_cars_usecase.dart';
import '../../../../core/domain/usecases/car/remove_car_as_favorite_usecase.dart';
import '../../../../core/domain/usecases/car/save_car_as_favorite_usecase.dart';
import '../../../../core/utils/base_controller.dart';
import '../states/home_state.dart';

class HomeController extends BaseController<HomeState> {
  final IGetCarsUsecase getCarsUsecase;
  final IGetFavoriteCarsUsecase getFavoriteCarsUsecase;
  final ISaveCarAsFavoriteUsecase saveCarAsFavoriteUsecase;
  final IRemoveCarAsFavoriteUsecase removeCarAsFavoriteUsecase;
  final ISyncLeadsUsecase syncLeadsUsecase;
  Timer? _syncLeadsTimer;
  HomeController(
    this.getCarsUsecase,
    this.getFavoriteCarsUsecase,
    this.saveCarAsFavoriteUsecase,
    this.removeCarAsFavoriteUsecase,
    this.syncLeadsUsecase,
  ) : super(HomeInitialState());

  Future<void> initialize() async {
    await _getCars();
    _syncLeadsTimer?.cancel();
    _syncLeadsTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      final oldState = currentState;
      if (oldState is HomeLoadedState) {
        final syncLedsResponse = await syncLeadsUsecase(oldState.favoriteCars);
        if (syncLedsResponse.isSuccess) {
          debugPrint('Sync leads success');
        } else {
          debugPrint('Sync leads error');
        }
      }
    });
  }

  Future<void> _getCars() async {
    emit(HomeLoadingState());
    final result = await getCarsUsecase();
    if (result.isSuccess) {
      emit(HomeLoadedState(cars: result.getSuccess));
      await _getFavoriteCars();
      return;
    }
    emit(HomeErrorState(result.getFailure.message));
  }

  Future<void> _getFavoriteCars() async {
    final oldState = currentState;
    if (oldState is HomeLoadedState) {
      final cars = oldState.cars;
      final favoriteCarsResponse = await getFavoriteCarsUsecase();
      if (favoriteCarsResponse.isSuccess) {
        final favoriteCars = favoriteCarsResponse.getSuccess;
        final updatedCars = cars.map((car) {
          final isFavorite = favoriteCars.any((favoriteCar) => favoriteCar.carId == car.id);
          return car.copyWith(isFavorite: isFavorite);
        }).toList();
        emit(oldState.copyWith(cars: updatedCars, favoriteCars: favoriteCars));
      }
    }
  }

  Future<void> favoriteCar(int carId) async {
    final oldState = currentState;
    if (oldState is HomeLoadedState) {
      final cars = oldState.cars;
      final index = cars.indexWhere((element) => element.id == carId);
      if (index != -1) {
        CarEntity car = cars[index];
        if (!car.isFavorite) {
          final dto = SetCarFavoriteDto(carId: car.id);
          final saveCarAsFavoriteResponse = await saveCarAsFavoriteUsecase(setCarFavoriteDto: dto);
          if (saveCarAsFavoriteResponse.isFailure) {
            emit(HomeErrorState(saveCarAsFavoriteResponse.getFailure.message));
            return;
          }
          car = car.copyWith(isFavorite: !car.isFavorite);
        } else {
          final dto = SetCarFavoriteDto(carId: car.id);
          final removeCarAsFavoriteResponse = await removeCarAsFavoriteUsecase(setCarFavoriteDto: dto);
          if (removeCarAsFavoriteResponse.isFailure) {
            emit(HomeErrorState(removeCarAsFavoriteResponse.getFailure.message));
            return;
          }
          car = car.copyWith(isFavorite: !car.isFavorite);
        }
        cars[index] = car;
        emit(oldState.copyWith(cars: cars));
        _getFavoriteCars();
      }
    }
  }
}

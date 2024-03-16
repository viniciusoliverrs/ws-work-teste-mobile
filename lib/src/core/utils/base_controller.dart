import 'package:flutter/material.dart';

abstract class BaseController<T> extends ValueNotifier<T> {
  BaseController(T value) : super(value);
  T get currentState => value;

  void emit(T value) {
    super.value = value;
  }
}
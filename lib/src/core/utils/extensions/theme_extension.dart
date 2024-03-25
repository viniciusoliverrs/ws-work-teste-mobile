import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  T? getExtension<T>() {
    return Theme.of(this).extension<T>();
  }
}

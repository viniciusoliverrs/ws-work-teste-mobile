import 'package:flutter/material.dart';

import 'extensions/common_theme_extension.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      extensions: [
        CommonThemeExtension(
          paragraph1: const TextStyle(
            fontSize: 16,
            height: 1.4,
            color: Colors.black,
          ),
          card1: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          card2: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 2,
                offset: Offset(0, 5),
              ),
            ],
          ),
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CommonThemeExtension extends ThemeExtension<CommonThemeExtension> {
  final TextStyle paragraph1;
  final BoxDecoration card1;
  final BoxDecoration card2;
  final Color backgroundColor;
  CommonThemeExtension({
    required this.paragraph1,
    required this.card1,
    required this.card2,
    required this.backgroundColor,
  });

  @override
  ThemeExtension<CommonThemeExtension> copyWith({
    TextStyle? paragraph1,
    BoxDecoration? card1,
    BoxDecoration? card2,
    Color? backgroundColor,
  }) {
    return CommonThemeExtension(
      paragraph1: paragraph1 ?? this.paragraph1,
      card1: card1 ?? this.card1,
      card2: card2 ?? this.card2,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  ThemeExtension<CommonThemeExtension> lerp(covariant ThemeExtension? other, double t) {
    if (other is! CommonThemeExtension) {
      return this;
    }
    return CommonThemeExtension(
      paragraph1: TextStyle.lerp(paragraph1, other.paragraph1, t)!,
      card1: BoxDecoration.lerp(card1, other.card1, t)!,
      card2: BoxDecoration.lerp(card2, other.card2, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:preco_certo/gen/fonts.gen.dart';

/// Tokens tipográficos do Preço Certo definidos em DESIGN.md.
@immutable
class AppTextTheme extends ThemeExtension<AppTextTheme> {
  const AppTextTheme({
    required this.display,
    required this.heading,
    required this.price,
    required this.body,
    required this.button,
    required this.label,
    required this.eyebrow,
  });

  final TextStyle display;
  final TextStyle heading;
  final TextStyle price;
  final TextStyle body;
  final TextStyle button;
  final TextStyle label;
  final TextStyle eyebrow;

  static const standard = AppTextTheme(
    display: TextStyle(
      fontFamily: FontFamily.avenir,
      fontSize: 38,
      height: .98,
      fontWeight: FontWeight.w800,
    ),
    heading: TextStyle(
      fontFamily: FontFamily.avenir,
      fontSize: 20,
      height: 1.15,
      fontWeight: FontWeight.w800,
    ),
    price: TextStyle(
      fontFamily: FontFamily.avenir,
      fontSize: 22,
      height: 1,
      fontWeight: FontWeight.w800,
      letterSpacing: -1.1,
    ),
    body: TextStyle(
      fontFamily: FontFamily.sFPro,
      fontSize: 16,
      height: 1.5,
      fontWeight: FontWeight.w400,
    ),
    button: TextStyle(
      fontFamily: FontFamily.sFPro,
      fontSize: 16,
      height: 1,
      fontWeight: FontWeight.w800,
    ),
    label: TextStyle(
      fontFamily: FontFamily.sFPro,
      fontSize: 13,
      height: 1.2,
      fontWeight: FontWeight.w800,
    ),
    eyebrow: TextStyle(
      fontFamily: FontFamily.sFPro,
      fontSize: 12,
      height: 1.2,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.2,
    ),
  );

  TextTheme toMaterialTextTheme(Color foreground, Color muted) {
    return TextTheme(
      displayLarge: display.copyWith(color: foreground),
      headlineMedium: heading.copyWith(color: foreground),
      titleLarge: heading.copyWith(color: foreground),
      titleMedium: heading.copyWith(fontSize: 18, color: foreground),
      bodyLarge: body.copyWith(color: foreground),
      bodyMedium: body.copyWith(fontSize: 14, color: foreground),
      bodySmall: body.copyWith(fontSize: 13, color: muted),
      labelLarge: button.copyWith(color: foreground),
      labelMedium: label.copyWith(color: foreground),
      labelSmall: eyebrow.copyWith(color: muted),
    );
  }

  @override
  AppTextTheme copyWith({
    TextStyle? display,
    TextStyle? heading,
    TextStyle? price,
    TextStyle? body,
    TextStyle? button,
    TextStyle? label,
    TextStyle? eyebrow,
  }) {
    return AppTextTheme(
      display: display ?? this.display,
      heading: heading ?? this.heading,
      price: price ?? this.price,
      body: body ?? this.body,
      button: button ?? this.button,
      label: label ?? this.label,
      eyebrow: eyebrow ?? this.eyebrow,
    );
  }

  @override
  AppTextTheme lerp(AppTextTheme? other, double t) {
    if (other is! AppTextTheme) return this;

    return AppTextTheme(
      display: TextStyle.lerp(display, other.display, t)!,
      heading: TextStyle.lerp(heading, other.heading, t)!,
      price: TextStyle.lerp(price, other.price, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      button: TextStyle.lerp(button, other.button, t)!,
      label: TextStyle.lerp(label, other.label, t)!,
      eyebrow: TextStyle.lerp(eyebrow, other.eyebrow, t)!,
    );
  }
}

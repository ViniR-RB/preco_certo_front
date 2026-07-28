import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preco_certo/app/core/themes/app_colors.dart';
import 'package:preco_certo/app/core/themes/app_text_theme.dart';

ThemeData get appTheme {
  const colors = AppColors.light;
  const text = AppTextTheme.standard;
  final textTheme = text.toMaterialTextTheme(colors.foreground, colors.muted);
  final colorScheme = ColorScheme.light(
    primary: colors.accent,
    onPrimary: colors.onAccent,
    secondary: colors.offer,
    onSecondary: colors.onAccent,
    surface: colors.surface,
    onSurface: colors.foreground,
    error: const Color(0xFFBA1A1A),
    outline: colors.border,
  );

  final outline = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: colors.border),
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colors.background,
    canvasColor: colors.background,
    dividerColor: colors.border,
    focusColor: colors.focusRing,
    extensions: const [colors, text],
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: colors.background,
      foregroundColor: colors.foreground,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: text.heading.copyWith(color: colors.foreground),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFFF8F9FA),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    ),
    cardTheme: CardThemeData(
      color: colors.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colors.border),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      labelStyle: text.label.copyWith(color: colors.foreground),
      hintStyle: text.body.copyWith(color: colors.muted),
      enabledBorder: outline,
      border: outline,
      focusedBorder: outline.copyWith(
        borderSide: BorderSide(color: colors.accent, width: 2),
      ),
      errorBorder: outline.copyWith(
        borderSide: const BorderSide(color: Color(0xFFBA1A1A)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: colors.accent,
        foregroundColor: colors.onAccent,
        disabledBackgroundColor: colors.border,
        disabledForegroundColor: colors.muted,
        minimumSize: const Size.fromHeight(54),
        textStyle: text.button,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colors.accent,
        minimumSize: const Size(44, 44),
        textStyle: text.button,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colors.offer,
      foregroundColor: colors.onAccent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}

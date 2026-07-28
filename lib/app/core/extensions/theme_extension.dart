import 'package:flutter/material.dart';
import 'package:preco_certo/app/core/themes/app_colors.dart';
import 'package:preco_certo/app/core/themes/app_text_theme.dart';

extension ThemeDataColorsExtension on ThemeData {
  AppColors get colors => extension<AppColors>()!;
  AppTextTheme get text => extension<AppTextTheme>()!;
}

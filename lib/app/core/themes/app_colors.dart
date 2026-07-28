import 'package:flutter/material.dart';

/// Tokens de cor do Preço Certo definidos em DESIGN.md.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surface,
    required this.foreground,
    required this.muted,
    required this.border,
    required this.accent,
    required this.offer,
    required this.onAccent,
    required this.focusRing,
  });

  final Color background;
  final Color surface;
  final Color foreground;
  final Color muted;
  final Color border;
  final Color accent;
  final Color offer;
  final Color onAccent;
  final Color focusRing;

  /// Tema claro padrão do aplicativo.
  static const light = AppColors(
    background: Color(0xFFF8F9FA),
    surface: Color(0xFFFFFFFF),
    foreground: Color(0xFF15395B),
    muted: Color(0xFF6F7885),
    border: Color(0xFFDEE2E7),
    accent: Color(0xFF0C5AA4),
    offer: Color(0xFFFF841C),
    onAccent: Color(0xFFFFFFFF),
    focusRing: Color(0x260C5AA4),
  );

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? foreground,
    Color? muted,
    Color? border,
    Color? accent,
    Color? offer,
    Color? onAccent,
    Color? focusRing,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      foreground: foreground ?? this.foreground,
      muted: muted ?? this.muted,
      border: border ?? this.border,
      accent: accent ?? this.accent,
      offer: offer ?? this.offer,
      onAccent: onAccent ?? this.onAccent,
      focusRing: focusRing ?? this.focusRing,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) return this;

    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      foreground: Color.lerp(foreground, other.foreground, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      border: Color.lerp(border, other.border, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      offer: Color.lerp(offer, other.offer, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      focusRing: Color.lerp(focusRing, other.focusRing, t)!,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:preco_certo/app/core/extensions/theme_extension.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colors;
    return LoadingAnimationWidget.threeArchedCircle(
      color: colors.accent,
      size: 60,
    );
  }
}

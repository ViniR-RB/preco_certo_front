import 'package:flutter/material.dart';
import 'package:preco_certo/l10n/app_localizations.dart';

mixin SuccessTranslator<T extends StatefulWidget> on State<T> {
  String translateSuccess(BuildContext context, String code) {
    final l10n = AppLocalizations.of(context)!;
    switch (code) {
      default:
        return l10n.unknownError;
    }
  }
}
import 'package:flutter/material.dart';
import 'package:preco_certo/app/core/config/message_constants.dart';
import 'package:preco_certo/app/core/exceptions/app_exception.dart';
import 'package:preco_certo/l10n/app_localizations.dart';

mixin ErrorTranslator<T extends StatefulWidget> on State<T> {
  String translateError(AppException exception) {
    return translateErrorCode(exception.code);
  }

  String translateErrorCode(String code) {
    final l10n = AppLocalizations.of(context)!;
    switch (code) {
      case MessageConstants.invalidCredentials:
        return l10n.invalidCredentials;
      default:
        return l10n.unknownError;
    }
  }
}

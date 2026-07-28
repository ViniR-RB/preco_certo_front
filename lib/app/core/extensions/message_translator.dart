import 'package:flutter/material.dart';
import 'package:preco_certo/app/core/config/message_constants.dart';
import 'package:preco_certo/l10n/app_localizations.dart';

mixin MessageTranslator<T extends StatefulWidget> on State<T> {
  String translateMessage(BuildContext context, String code) {
    final l10n = AppLocalizations.of(context)!;

    switch (code) {
      case MessageConstants.loginEyebrow:
        return l10n.loginEyebrow;
      case MessageConstants.loginTitle:
        return l10n.loginTitle;
      case MessageConstants.loginSubtitle:
        return l10n.loginSubtitle;
      case MessageConstants.loginEmailLabel:
        return l10n.loginEmailLabel;
      case MessageConstants.loginEmailHint:
        return l10n.loginEmailHint;
      case MessageConstants.loginPasswordLabel:
        return l10n.loginPasswordLabel;
      case MessageConstants.loginPasswordHint:
        return l10n.loginPasswordHint;
      case MessageConstants.loginShowPassword:
        return l10n.loginShowPassword;
      case MessageConstants.loginHidePassword:
        return l10n.loginHidePassword;
      case MessageConstants.loginUnlockButton:
        return l10n.loginUnlockButton;
      case MessageConstants.loginNoAccount:
        return l10n.loginNoAccount;
      case MessageConstants.loginCreateAccount:
        return l10n.loginCreateAccount;
      case MessageConstants.registerBack:
        return l10n.registerBack;
      case MessageConstants.registerEyebrow:
        return l10n.registerEyebrow;
      case MessageConstants.registerTitle:
        return l10n.registerTitle;
      case MessageConstants.registerSubtitle:
        return l10n.registerSubtitle;
      case MessageConstants.registerNameLabel:
        return l10n.registerNameLabel;
      case MessageConstants.registerNameHint:
        return l10n.registerNameHint;
      case MessageConstants.registerNameRequired:
        return l10n.registerNameRequired;
      case MessageConstants.registerEmailLabel:
        return l10n.registerEmailLabel;
      case MessageConstants.registerEmailHint:
        return l10n.registerEmailHint;
      case MessageConstants.registerEmailRequired:
        return l10n.registerEmailRequired;
      case MessageConstants.registerEmailInvalid:
        return l10n.registerEmailInvalid;
      case MessageConstants.registerPasswordLabel:
        return l10n.registerPasswordLabel;
      case MessageConstants.registerPasswordHint:
        return l10n.registerPasswordHint;
      case MessageConstants.registerPasswordRequired:
        return l10n.registerPasswordRequired;
      case MessageConstants.registerPasswordInvalid:
        return l10n.registerPasswordInvalid;
      case MessageConstants.registerSubmit:
        return l10n.registerSubmit;
      default:
        return l10n.unknownError;
    }
  }
}

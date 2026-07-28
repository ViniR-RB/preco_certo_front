// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Preço Certo';

  @override
  String get unknownError =>
      'Ocorreu um erro desconhecido. Por favor, tente novamente mais tarde.';

  @override
  String get invalidCredentials => 'E-mail ou senha inválidos.';

  @override
  String get loginEyebrow => 'ECONOMIZE NA COMPRA';

  @override
  String get loginTitle => 'Seu mercado rende mais.';

  @override
  String get loginSubtitle =>
      'Encontre ofertas perto de você e organize sua lista em poucos toques.';

  @override
  String get loginEmailLabel => 'E-mail';

  @override
  String get loginEmailHint => 'voce@email.com';

  @override
  String get loginPasswordLabel => 'Senha';

  @override
  String get loginPasswordHint => 'Sua senha';

  @override
  String get loginShowPassword => 'Mostrar senha';

  @override
  String get loginHidePassword => 'Ocultar senha';

  @override
  String get loginUnlockButton => 'Entrar';

  @override
  String get loginNoAccount => 'Ainda não tem conta? ';

  @override
  String get loginCreateAccount => 'Criar cadastro';

  @override
  String get registerBack => 'Voltar';

  @override
  String get registerEyebrow => 'PRIMEIRO ACESSO';

  @override
  String get registerTitle => 'Vamos começar.';

  @override
  String get registerSubtitle => 'Crie seu perfil para guardar suas listas.';

  @override
  String get registerNameLabel => 'Nome';

  @override
  String get registerNameHint => 'Como podemos te chamar?';

  @override
  String get registerNameRequired => 'Informe seu nome.';

  @override
  String get registerEmailLabel => 'E-mail';

  @override
  String get registerEmailHint => 'voce@email.com';

  @override
  String get registerEmailRequired => 'Informe seu e-mail.';

  @override
  String get registerEmailInvalid => 'Informe um e-mail válido.';

  @override
  String get registerPasswordLabel => 'Senha';

  @override
  String get registerPasswordHint => 'Mínimo de 6 caracteres';

  @override
  String get registerPasswordRequired => 'Informe sua senha.';

  @override
  String get registerPasswordInvalid =>
      'A senha deve ter pelo menos 6 caracteres.';

  @override
  String get registerSubmit => 'Criar minha conta';
}

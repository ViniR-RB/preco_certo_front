// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Preço Certo';

  @override
  String get unknownError =>
      'An unknown error has occurred. Please try again later.';

  @override
  String get invalidCredentials => 'Invalid email or password.';

  @override
  String get loginEyebrow => 'SAVE ON GROCERIES';

  @override
  String get loginTitle => 'Make your grocery budget go further.';

  @override
  String get loginSubtitle =>
      'Find offers near you and organize your list in just a few taps.';

  @override
  String get loginEmailLabel => 'Email';

  @override
  String get loginEmailHint => 'you@email.com';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginPasswordHint => 'Your password';

  @override
  String get loginShowPassword => 'Show password';

  @override
  String get loginHidePassword => 'Hide password';

  @override
  String get loginUnlockButton => 'Sign in';

  @override
  String get loginNoAccount => 'Don\'t have an account? ';

  @override
  String get loginCreateAccount => 'Create an account';

  @override
  String get registerBack => 'Back';

  @override
  String get registerEyebrow => 'FIRST ACCESS';

  @override
  String get registerTitle => 'Let\'s get started.';

  @override
  String get registerSubtitle => 'Create your profile to save your lists.';

  @override
  String get registerNameLabel => 'Name';

  @override
  String get registerNameHint => 'What should we call you?';

  @override
  String get registerNameRequired => 'Enter your name.';

  @override
  String get registerEmailLabel => 'Email';

  @override
  String get registerEmailHint => 'you@email.com';

  @override
  String get registerEmailRequired => 'Enter your email.';

  @override
  String get registerEmailInvalid => 'Enter a valid email address.';

  @override
  String get registerPasswordLabel => 'Password';

  @override
  String get registerPasswordHint => 'At least 6 characters';

  @override
  String get registerPasswordRequired => 'Enter your password.';

  @override
  String get registerPasswordInvalid =>
      'Password must be at least 6 characters.';

  @override
  String get registerSubmit => 'Create my account';
}

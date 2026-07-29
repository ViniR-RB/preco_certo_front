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

  @override
  String get offersEyebrow => 'OFFERS NEAR YOU';

  @override
  String get offersTitle => 'Shop smarter today.';

  @override
  String get offersLocationUnset => 'Set your location';

  @override
  String get offersLocationHint => 'Find the best stores near you';

  @override
  String get offersSearchHint => 'Search for a product or store';

  @override
  String get offersListTitle => 'Offers for your list';

  @override
  String get offersListSubtitle => 'Stores with the best prices in your area.';

  @override
  String get offersLocationTitle => 'Where are you?';

  @override
  String get offersLocationSubtitle =>
      'Use your position or enter an address to see nearby stores.';

  @override
  String get offersUseDeviceLocation => 'Use device location';

  @override
  String get offersUseDeviceLocationHint => 'Find nearby stores automatically';

  @override
  String get offersUseAddress => 'Enter an address';

  @override
  String get offersUseAddressHint =>
      'Enter your street, neighborhood or postal code';

  @override
  String get offersAddressLabel => 'Address to search for stores';

  @override
  String get offersAddressHint => 'E.g. 1200 Beira Mar Ave.';

  @override
  String get offersSearchAddress => 'Search addresses';

  @override
  String get offersAddressResults => 'Select an address';

  @override
  String get offersRadiusLabel => 'Show stores within';

  @override
  String get offersRadiusHint => 'You can adjust this radius at any time.';

  @override
  String get offersLocationRequired => 'Set your location to continue.';

  @override
  String get offersNoResults => 'There are no offers near you yet.';

  @override
  String get offersNoSearchResults => 'No offers found.';

  @override
  String get offersLoadFailure => 'We couldn\'t load the offers.';

  @override
  String get offersRetry => 'Try again';

  @override
  String get offersAdd => 'Add to list';

  @override
  String get offersRemove => 'Remove from list';

  @override
  String get offersHome => 'Home';

  @override
  String get offersList => 'List';

  @override
  String get offersDeviceLocationDenied =>
      'Location permission was not granted.';

  @override
  String get offersDeviceLocationUnavailable =>
      'We couldn\'t get your location. Try entering an address.';

  @override
  String get offersAddressNotFound => 'No address was found.';
}

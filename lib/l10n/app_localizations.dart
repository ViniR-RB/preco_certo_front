import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Preço Certo'**
  String get appTitle;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'An unknown error has occurred. Please try again later.'**
  String get unknownError;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password.'**
  String get invalidCredentials;

  /// No description provided for @loginEyebrow.
  ///
  /// In en, this message translates to:
  /// **'SAVE ON GROCERIES'**
  String get loginEyebrow;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Make your grocery budget go further.'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find offers near you and organize your list in just a few taps.'**
  String get loginSubtitle;

  /// No description provided for @loginEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get loginEmailLabel;

  /// No description provided for @loginEmailHint.
  ///
  /// In en, this message translates to:
  /// **'you@email.com'**
  String get loginEmailHint;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordLabel;

  /// No description provided for @loginPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Your password'**
  String get loginPasswordHint;

  /// No description provided for @loginShowPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get loginShowPassword;

  /// No description provided for @loginHidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get loginHidePassword;

  /// No description provided for @loginUnlockButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get loginUnlockButton;

  /// No description provided for @loginNoAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get loginNoAccount;

  /// No description provided for @loginCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get loginCreateAccount;

  /// No description provided for @registerBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get registerBack;

  /// No description provided for @registerEyebrow.
  ///
  /// In en, this message translates to:
  /// **'FIRST ACCESS'**
  String get registerEyebrow;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s get started.'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create your profile to save your lists.'**
  String get registerSubtitle;

  /// No description provided for @registerNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get registerNameLabel;

  /// No description provided for @registerNameHint.
  ///
  /// In en, this message translates to:
  /// **'What should we call you?'**
  String get registerNameHint;

  /// No description provided for @registerNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your name.'**
  String get registerNameRequired;

  /// No description provided for @registerEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get registerEmailLabel;

  /// No description provided for @registerEmailHint.
  ///
  /// In en, this message translates to:
  /// **'you@email.com'**
  String get registerEmailHint;

  /// No description provided for @registerEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your email.'**
  String get registerEmailRequired;

  /// No description provided for @registerEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get registerEmailInvalid;

  /// No description provided for @registerPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get registerPasswordLabel;

  /// No description provided for @registerPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'At least 6 characters'**
  String get registerPasswordHint;

  /// No description provided for @registerPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your password.'**
  String get registerPasswordRequired;

  /// No description provided for @registerPasswordInvalid.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters.'**
  String get registerPasswordInvalid;

  /// No description provided for @registerSubmit.
  ///
  /// In en, this message translates to:
  /// **'Create my account'**
  String get registerSubmit;

  /// No description provided for @offersEyebrow.
  ///
  /// In en, this message translates to:
  /// **'OFFERS NEAR YOU'**
  String get offersEyebrow;

  /// No description provided for @offersTitle.
  ///
  /// In en, this message translates to:
  /// **'Shop smarter today.'**
  String get offersTitle;

  /// No description provided for @offersLocationUnset.
  ///
  /// In en, this message translates to:
  /// **'Set your location'**
  String get offersLocationUnset;

  /// No description provided for @offersLocationHint.
  ///
  /// In en, this message translates to:
  /// **'Find the best stores near you'**
  String get offersLocationHint;

  /// No description provided for @offersSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a product or store'**
  String get offersSearchHint;

  /// No description provided for @offersListTitle.
  ///
  /// In en, this message translates to:
  /// **'Offers for your list'**
  String get offersListTitle;

  /// No description provided for @offersListSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Stores with the best prices in your area.'**
  String get offersListSubtitle;

  /// No description provided for @offersLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Where are you?'**
  String get offersLocationTitle;

  /// No description provided for @offersLocationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use your position or enter an address to see nearby stores.'**
  String get offersLocationSubtitle;

  /// No description provided for @offersUseDeviceLocation.
  ///
  /// In en, this message translates to:
  /// **'Use device location'**
  String get offersUseDeviceLocation;

  /// No description provided for @offersUseDeviceLocationHint.
  ///
  /// In en, this message translates to:
  /// **'Find nearby stores automatically'**
  String get offersUseDeviceLocationHint;

  /// No description provided for @offersUseAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter an address'**
  String get offersUseAddress;

  /// No description provided for @offersUseAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your street, neighborhood or postal code'**
  String get offersUseAddressHint;

  /// No description provided for @offersAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Address to search for stores'**
  String get offersAddressLabel;

  /// No description provided for @offersAddressHint.
  ///
  /// In en, this message translates to:
  /// **'E.g. 1200 Beira Mar Ave.'**
  String get offersAddressHint;

  /// No description provided for @offersSearchAddress.
  ///
  /// In en, this message translates to:
  /// **'Search addresses'**
  String get offersSearchAddress;

  /// No description provided for @offersAddressResults.
  ///
  /// In en, this message translates to:
  /// **'Select an address'**
  String get offersAddressResults;

  /// No description provided for @offersRadiusLabel.
  ///
  /// In en, this message translates to:
  /// **'Show stores within'**
  String get offersRadiusLabel;

  /// No description provided for @offersRadiusHint.
  ///
  /// In en, this message translates to:
  /// **'You can adjust this radius at any time.'**
  String get offersRadiusHint;

  /// No description provided for @offersLocationRequired.
  ///
  /// In en, this message translates to:
  /// **'Set your location to continue.'**
  String get offersLocationRequired;

  /// No description provided for @offersNoResults.
  ///
  /// In en, this message translates to:
  /// **'There are no offers near you yet.'**
  String get offersNoResults;

  /// No description provided for @offersNoSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No offers found.'**
  String get offersNoSearchResults;

  /// No description provided for @offersLoadFailure.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load the offers.'**
  String get offersLoadFailure;

  /// No description provided for @offersRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get offersRetry;

  /// No description provided for @offersAdd.
  ///
  /// In en, this message translates to:
  /// **'Add to list'**
  String get offersAdd;

  /// No description provided for @offersRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove from list'**
  String get offersRemove;

  /// No description provided for @offersHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get offersHome;

  /// No description provided for @offersList.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get offersList;

  /// No description provided for @offersDeviceLocationDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission was not granted.'**
  String get offersDeviceLocationDenied;

  /// No description provided for @offersDeviceLocationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t get your location. Try entering an address.'**
  String get offersDeviceLocationUnavailable;

  /// No description provided for @offersAddressNotFound.
  ///
  /// In en, this message translates to:
  /// **'No address was found.'**
  String get offersAddressNotFound;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

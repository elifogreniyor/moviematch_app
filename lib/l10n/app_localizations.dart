import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  /// No description provided for @login_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get login_title;

  /// No description provided for @login_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Tempus varius at urna interdum id tortor elementum tristique eleifend at.'**
  String get login_subtitle;

  /// No description provided for @login_email_hint.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get login_email_hint;

  /// No description provided for @login_password_hint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get login_password_hint;

  /// No description provided for @login_forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get login_forgot_password;

  /// No description provided for @login_button.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get login_button;

  /// No description provided for @login_no_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get login_no_account;

  /// No description provided for @login_register.
  ///
  /// In en, this message translates to:
  /// **'Register!'**
  String get login_register;

  /// No description provided for @register_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get register_title;

  /// No description provided for @register_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Tempus varius at urna interdum id tortor elementum tristique eleifend at.'**
  String get register_subtitle;

  /// No description provided for @register_name_hint.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get register_name_hint;

  /// No description provided for @register_email_hint.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get register_email_hint;

  /// No description provided for @register_password_hint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get register_password_hint;

  /// No description provided for @register_confirm_password_hint.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get register_confirm_password_hint;

  /// No description provided for @register_button.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get register_button;

  /// No description provided for @register_agreement_prefix.
  ///
  /// In en, this message translates to:
  /// **'User agreement '**
  String get register_agreement_prefix;

  /// No description provided for @register_agreement_link.
  ///
  /// In en, this message translates to:
  /// **'I have read and accept.'**
  String get register_agreement_link;

  /// No description provided for @register_agreement_suffix.
  ///
  /// In en, this message translates to:
  /// **' Please read before continuing.'**
  String get register_agreement_suffix;

  /// No description provided for @register_already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get register_already_have_account;

  /// No description provided for @register_login.
  ///
  /// In en, this message translates to:
  /// **'Sign In!'**
  String get register_login;

  /// No description provided for @login_success.
  ///
  /// In en, this message translates to:
  /// **'Login successful.'**
  String get login_success;

  /// No description provided for @login_failed.
  ///
  /// In en, this message translates to:
  /// **'Login failed.'**
  String get login_failed;

  /// No description provided for @register_failed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed.'**
  String get register_failed;

  /// No description provided for @register_success.
  ///
  /// In en, this message translates to:
  /// **'Registration successful.'**
  String get register_success;

  /// No description provided for @register_passwords_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get register_passwords_not_match;

  /// No description provided for @photo_upload_success.
  ///
  /// In en, this message translates to:
  /// **'Photo uploaded successfully!'**
  String get photo_upload_success;

  /// No description provided for @photo_upload_failed.
  ///
  /// In en, this message translates to:
  /// **'Photo upload failed.'**
  String get photo_upload_failed;

  /// No description provided for @photo_upload_appBar_title.
  ///
  /// In en, this message translates to:
  /// **'Profile Detail'**
  String get photo_upload_appBar_title;

  /// No description provided for @profile_appBar_title.
  ///
  /// In en, this message translates to:
  /// **'Profile Detail'**
  String get profile_appBar_title;

  /// No description provided for @photo_upload_title.
  ///
  /// In en, this message translates to:
  /// **'Upload Your Photos'**
  String get photo_upload_title;

  /// No description provided for @photo_upload_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Resources out incentivize relaxation floor loss cc.'**
  String get photo_upload_subtitle;

  /// No description provided for @photo_upload_button.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get photo_upload_button;

  /// No description provided for @copy_id_message.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copy_id_message;

  /// No description provided for @profile_add_photo.
  ///
  /// In en, this message translates to:
  /// **'Add Photo'**
  String get profile_add_photo;

  /// No description provided for @profile_favorite_movies.
  ///
  /// In en, this message translates to:
  /// **'Favorite Movies'**
  String get profile_favorite_movies;

  /// No description provided for @exit_button_text.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit_button_text;

  /// No description provided for @error_message.
  ///
  /// In en, this message translates to:
  /// **'An error occurred.'**
  String get error_message;

  /// No description provided for @bottom_nav_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get bottom_nav_home;

  /// No description provided for @bottom_nav_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get bottom_nav_profile;

  /// No description provided for @expand_text.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get expand_text;

  /// No description provided for @collapse_text.
  ///
  /// In en, this message translates to:
  /// **'Less'**
  String get collapse_text;

  /// No description provided for @weeklyPerHead.
  ///
  /// In en, this message translates to:
  /// **'Weekly Per Head'**
  String get weeklyPerHead;

  /// No description provided for @premium_account.
  ///
  /// In en, this message translates to:
  /// **'Premium\nAccount'**
  String get premium_account;

  /// No description provided for @more_matches.
  ///
  /// In en, this message translates to:
  /// **'More\nMatches'**
  String get more_matches;

  /// No description provided for @up_more.
  ///
  /// In en, this message translates to:
  /// **'Up\nMore'**
  String get up_more;

  /// No description provided for @like_more.
  ///
  /// In en, this message translates to:
  /// **'Like\nMore'**
  String get like_more;

  /// No description provided for @limited_offer_title.
  ///
  /// In en, this message translates to:
  /// **'Limited Offer'**
  String get limited_offer_title;

  /// No description provided for @limited_offer_subTitle.
  ///
  /// In en, this message translates to:
  /// **'Select your bonus\npackage and unlock your new\nfeatures!'**
  String get limited_offer_subTitle;

  /// No description provided for @get_your_bonus.
  ///
  /// In en, this message translates to:
  /// **'Get Your Bonus'**
  String get get_your_bonus;

  /// No description provided for @unlock_with_token_package.
  ///
  /// In en, this message translates to:
  /// **'Unlock with token package'**
  String get unlock_with_token_package;

  /// No description provided for @see_all_tokens.
  ///
  /// In en, this message translates to:
  /// **'See all tokens'**
  String get see_all_tokens;

  /// No description provided for @favorite_updated.
  ///
  /// In en, this message translates to:
  /// **'Favorite updated'**
  String get favorite_updated;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'tr': return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

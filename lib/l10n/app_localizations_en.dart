// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login_title => 'Welcome';

  @override
  String get login_subtitle => 'Tempus varius at urna interdum id tortor elementum tristique eleifend at.';

  @override
  String get login_email_hint => 'E-mail';

  @override
  String get login_password_hint => 'Password';

  @override
  String get login_forgot_password => 'Forgot password';

  @override
  String get login_button => 'Sign In';

  @override
  String get login_no_account => 'Don\'t have an account?';

  @override
  String get login_register => 'Register!';

  @override
  String get register_title => 'Welcome';

  @override
  String get register_subtitle => 'Tempus varius at urna interdum id tortor elementum tristique eleifend at.';

  @override
  String get register_name_hint => 'Full Name';

  @override
  String get register_email_hint => 'E-mail';

  @override
  String get register_password_hint => 'Password';

  @override
  String get register_confirm_password_hint => 'Confirm Password';

  @override
  String get register_button => 'Sign Up';

  @override
  String get register_agreement_prefix => 'User agreement ';

  @override
  String get register_agreement_link => 'I have read and accept.';

  @override
  String get register_agreement_suffix => ' Please read before continuing.';

  @override
  String get register_already_have_account => 'Already have an account?';

  @override
  String get register_login => 'Sign In!';
}

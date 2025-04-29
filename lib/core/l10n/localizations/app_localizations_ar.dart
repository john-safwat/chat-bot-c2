// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'Flutter';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get forgetPassword => 'نسيت كلمة المرور';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get invalidEmail => 'عنوان البريد الإلكتروني غير صالح';

  @override
  String get invalidPassword => 'كلمة المرور غير صالحة';
}

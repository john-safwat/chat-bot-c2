import 'package:chat_bot_c2/core/di/di.dart';
import 'package:chat_bot_c2/core/l10n/localizations/app_localizations.dart';
import 'package:chat_bot_c2/core/provider/app_config_provider.dart';
import 'package:chat_bot_c2/core/routes/app_routes.dart';
import 'package:chat_bot_c2/core/theme/app_theme.dart';
import 'package:chat_bot_c2/core/utils/constants.dart';
import 'package:chat_bot_c2/feature/login/view/login_view.dart';
import 'package:chat_bot_c2/feature/login/view_model/login_view_model.dart';
import 'package:chat_bot_c2/feature/onboarding/view/on_boarding_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  getIt<AppConfigProvider>().changeLocale(
    getIt<SharedPreferences>().getString(Constants.localeKey) ?? "en",
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => getIt<AppConfigProvider>(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  late AppConfigProvider appConfigProvider;

  @override
  Widget build(BuildContext context) {
    appConfigProvider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(appConfigProvider.getLocale()),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: appConfigProvider.getThemeMode(),
      initialRoute: AppRoutes.loginRoute,
      routes: {
        AppRoutes.onboardingRoute: (_) => OnBoardingView(),
        AppRoutes.loginRoute:
            (_) => LoginView(),
      },
    );
  }
}

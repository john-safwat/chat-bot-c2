import 'package:chat_bot_c2/core/di/di.dart';
import 'package:chat_bot_c2/core/l10n/localizations/app_localizations.dart';
import 'package:chat_bot_c2/core/provider/app_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  // AppViewModel viewModel = getIt<AppViewModel>();
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Scaffold(
        appBar: AppBar(title: Text("data")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(),

            OutlinedButton(
              onPressed: () {
                getIt<AppConfigProvider>().changeLocale(
                  getIt<AppConfigProvider>().isEn() ? "ar" : "en",
                );
              },
              child: Text(getIt<AppLocalizations>().appName),
            ),
            Skeleton.replace(
              replace: true,
              replacement:  Container(
                color:  Colors.red,
                height: 100,
                width: 100,
              ),
              child: OutlinedButton(
                onPressed: () {
                  getIt<AppConfigProvider>().changeThemeMode(
                    getIt<AppConfigProvider>().isDark()
                        ? ThemeMode.light
                        : ThemeMode.dark,
                  );
                },
                child: Text(getIt<AppLocalizations>().appName),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:chat_bot_c2/core/di/di.dart';
import 'package:chat_bot_c2/core/l10n/localizations/app_localizations.dart';
import 'package:chat_bot_c2/core/provider/app_config_provider.dart';
import 'package:flutter/material.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  // AppViewModel viewModel = getIt<AppViewModel>();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("data")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(),
          OutlinedButton(
            key: const ValueKey("localeButton"),
            onPressed: () {
              setState(() {
                isLoading = !isLoading;
              });
            },
            child: Text(getIt<AppLocalizations>().appName),
          ),
          OutlinedButton(
            onPressed: () {
              getIt<AppConfigProvider>().changeThemeMode(
                getIt<AppConfigProvider>().isDark()
                    ? ThemeMode.light
                    : ThemeMode.dark,
              );
            },
            child: Text(getIt<AppLocalizations>().appName),
          ),
          OutlinedButton(
            onPressed: () {},
            child: Text(getIt<AppLocalizations>().appName),
          ),

          if(isLoading)
            CircularProgressIndicator()
        ],
      ),
    );
  }
}

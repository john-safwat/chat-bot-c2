import 'package:chat_bot_c2/core/di/di.dart';
import 'package:chat_bot_c2/core/l10n/localizations/app_localizations.dart';
import 'package:chat_bot_c2/feature/onboarding/view/on_boarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'on_boarding_view_test.mocks.dart';

@GenerateMocks([AppLocalizations])
void main() {
  group("Test Onboarding Screen Buttons", () {
    setUpAll(() {
      MockAppLocalizations localizations = MockAppLocalizations();
      getIt.registerSingleton<AppLocalizations>(localizations);

      // setup translation keys
      when(localizations.appName).thenReturn("Flutter");
    });

    testWidgets("check if the buttons is rendered", (widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(home: OnBoardingView()));

      var buttons = find.byKey(const ValueKey("localeButton"));

      await widgetTester.tap(buttons.first);

      await widgetTester.pump();

      var progressIndicator = find.byType(CircularProgressIndicator);

      expect(progressIndicator, findsExactly(1));

      await widgetTester.tap(buttons.first);

      await widgetTester.pump();

      progressIndicator = find.byType(CircularProgressIndicator);

      expect(progressIndicator, findsNothing);
    });
  });
}

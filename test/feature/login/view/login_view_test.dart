import 'package:chat_bot_c2/core/di/di.dart';
import 'package:chat_bot_c2/core/l10n/localizations/app_localizations.dart';
import 'package:chat_bot_c2/feature/login/view/login_view.dart';
import 'package:chat_bot_c2/feature/login/view_model/login_states.dart';
import 'package:chat_bot_c2/feature/login/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// @GenerateMocks([AppLocalizations])
void main() {

  late AppLocalizations appLocalizations;
  setUpAll(() async {
    appLocalizations = await AppLocalizations.delegate.load(const Locale("en"));
    getIt.registerSingleton<AppLocalizations>(appLocalizations);
    getIt.registerFactory<LoginViewModel>(() => LoginViewModel());
  });

  Widget buildWidget() {
    return const MaterialApp(home: LoginView());
  }

  group("Test Login Screen Items", () {

    testWidgets("Check if The image is rendered", (tester) async {
      await tester.pumpWidget(buildWidget());
      var image = find.image(const AssetImage("asset/images/logo.png"));
      expect(image, findsOneWidget);
    });

    testWidgets("check if text fields is rendered", (tester) async {
      await tester.pumpWidget(buildWidget());
      var textFields = find.byType(TextFormField);
      expect(textFields, findsNWidgets(2));
    });

    testWidgets("check if filled buttons is rendered", (tester) async {
      await tester.pumpWidget(buildWidget());
      var filledButton = find.byType(FilledButton);
      expect(filledButton, findsOneWidget);
    });

    testWidgets("check if text buttons is rendered", (tester) async {
      await tester.pumpWidget(buildWidget());
      var textButton = find.byType(TextButton);
      expect(textButton, findsOneWidget);
    });
  });

  group("from fields validation on user interactions", () {

    testWidgets("error message appear when writing invalid email address", (
      tester,
    ) async {
      await tester.pumpWidget(buildWidget());

      await tester.enterText(
        find.byKey(const ValueKey("loginEmailFormFieldKey")),
        "joh",
      );

      await tester.pump();

      var errorMessage = find.text(appLocalizations.invalidEmail);

      expect(errorMessage, findsOneWidget);
    });

    testWidgets("no error message appear when writing valid email address", (
      tester,
    ) async {
      await tester.pumpWidget(buildWidget());

      await tester.enterText(
        find.byKey(const ValueKey("loginEmailFormFieldKey")),
        "john@gmail.com",
      );

      await tester.pump();

      var errorMessage = find.text(appLocalizations.invalidEmail);

      expect(errorMessage, findsNothing);
    });

    testWidgets("Error Message appear when Writing week password", (
      tester,
    ) async {
      await tester.pumpWidget(buildWidget());
      await tester.enterText(
        find.byKey(const ValueKey("loginPasswordFormFiled")),
        "john",
      );

      await tester.pump();

      var errorMessage = find.text(appLocalizations.invalidPassword);

      expect(errorMessage, findsOneWidget);
    });

    testWidgets("No Error Message appear when Writing strong password", (
      tester,
    ) async {
      await tester.pumpWidget(buildWidget());
      await tester.enterText(
        find.byKey(const ValueKey("loginPasswordFormFiled")),
        "John@123123",
      );

      await tester.pump();

      var errorMessage = find.text(appLocalizations.invalidPassword);

      expect(errorMessage, findsNothing);
    });
  });

  group("Login Button Action Test", () {

    testWidgets(
      "When User Press On Login Button Without Entering the Email And Password",
      (tester) async {
        await tester.pumpWidget(buildWidget());
        await tester.pump();
        await tester.ensureVisible(find.byKey(const ValueKey("loginButton")));
        await tester.tap(find.byKey(const ValueKey("loginButton")));

        await tester.pump();

        var emailErrorMessage = find.text(appLocalizations.invalidEmail);
        var passwordErrorMessage = find.text(appLocalizations.invalidPassword);

        expect(emailErrorMessage, findsOneWidget);
        expect(passwordErrorMessage, findsOneWidget);
      },
    );
    testWidgets(
      "When User Press On Login Button Without Entering the Password",
      (tester) async {
        await tester.pumpWidget(buildWidget());

        await tester.enterText(
          find.byKey(const ValueKey("loginEmailFormFieldKey")),
          "john@gmail.com",
        );
        await tester.pump();
        await tester.ensureVisible(find.byKey(const ValueKey("loginButton")));
        await tester.tap(find.byKey(const ValueKey("loginButton")));

        await tester.pump();

        var emailErrorMessage = find.text(appLocalizations.invalidEmail);
        var passwordErrorMessage = find.text(appLocalizations.invalidPassword);

        expect(emailErrorMessage, findsNothing);
        expect(passwordErrorMessage, findsOneWidget);
      },
    );
    testWidgets("When User Press On Login Button Without Entering the Email", (
      tester,
    ) async {
      await tester.pumpWidget(buildWidget());

      await tester.enterText(
        find.byKey(const ValueKey("loginPasswordFormFiled")),
        "John@123123",
      );
      await tester.pump();
      await tester.ensureVisible(find.byKey(const ValueKey("loginButton")));
      await tester.tap(find.byKey(const ValueKey("loginButton")));

      await tester.pump();

      var emailErrorMessage = find.text(appLocalizations.invalidEmail);
      var passwordErrorMessage = find.text(appLocalizations.invalidPassword);

      expect(emailErrorMessage, findsOneWidget);
      expect(passwordErrorMessage, findsNothing);
    });

    testWidgets("When User Enter invalid Email or Password", (tester) async {
      await tester.pumpWidget(buildWidget());

      await tester.enterText(
        find.byKey(const ValueKey("loginPasswordFormFiled")),
        "John",
      );

      await tester.enterText(
        find.byKey(const ValueKey("loginEmailFormFieldKey")),
        "john",
      );
      await tester.pump();
      await tester.ensureVisible(find.byKey(const ValueKey("loginButton")));
      await tester.tap(find.byKey(const ValueKey("loginButton")));
      await tester.pump();
      var emailErrorMessage = find.text(appLocalizations.invalidEmail);
      var passwordErrorMessage = find.text(appLocalizations.invalidPassword);

      expect(emailErrorMessage, findsOneWidget);
      expect(passwordErrorMessage, findsOneWidget);
    });

    testWidgets("When User Enter valid Email and Password", (tester) async {
      getIt.unregister<LoginViewModel>();
      getIt.registerSingleton<LoginViewModel>(LoginViewModel());
      await tester.pumpWidget(buildWidget());

      await tester.enterText(
        find.byKey(const ValueKey("loginPasswordFormFiled")),
        "John@12312312",
      );

      await tester.enterText(
        find.byKey(const ValueKey("loginEmailFormFieldKey")),
        "john@gmail.com",
      );
      await tester.pump();
      await tester.ensureVisible(find.byKey(const ValueKey("loginButton")));
      await tester.tap(find.byKey(const ValueKey("loginButton")));
      await tester.pumpAndSettle();


      expect(getIt<LoginViewModel>().state.loginState, isA<LoginSuccessState<bool>>());
    });
  });
}

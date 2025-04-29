import 'package:chat_bot_c2/core/di/di.dart';
import 'package:chat_bot_c2/core/extentions/spacing.dart';
import 'package:chat_bot_c2/core/l10n/localizations/app_localizations.dart';
import 'package:chat_bot_c2/feature/login/view_model/login_states.dart';
import 'package:chat_bot_c2/feature/login/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {


  const LoginView({ super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel viewModel = getIt<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(getIt<AppLocalizations>().login)),
      body: BlocProvider.value(
        value: viewModel,
        child: BlocConsumer<LoginViewModel, LoginStates>(
          listener: (context, state) {
            if (state.loginState is LoginLoadingState) {
              showDialog(
                context: context,
                builder:
                    (context) =>
                        const Center(child: CircularProgressIndicator()),
              );
            } else {
              Navigator.pop(context);
            }
          },
          builder:
              (context, state) => SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: viewModel.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "asset/images/logo.png",
                            width: MediaQuery.sizeOf(context).width * 0.3,
                          ),
                        ],
                      ),
                      32.spaceVertical,

                      TextFormField(
                        key: const ValueKey("loginEmailFormFieldKey"),
                        validator:
                            (email) =>
                                viewModel.emailValidation(email ?? ""),
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: getIt<AppLocalizations>().email,
                        ),
                      ),

                      16.spaceVertical,
                      TextFormField(
                        key: const ValueKey("loginPasswordFormFiled"),
                        validator:
                            (email) =>
                                viewModel.isValidPassword(email ?? ""),
                        keyboardType: TextInputType.visiblePassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: getIt<AppLocalizations>().password,
                        ),
                      ),

                      16.spaceVertical,
                      TextButton(
                        onPressed: () {
                          // todo navigate to forget password screen
                        },
                        child: Text(getIt<AppLocalizations>().forgetPassword),
                      ),
                      16.spaceVertical,
                      FilledButton(
                        key: const ValueKey("loginButton"),
                        onPressed: () {
                          viewModel.login();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text(getIt<AppLocalizations>().login)],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ),
      ),
    );
  }
}

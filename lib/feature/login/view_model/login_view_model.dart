import 'package:chat_bot_c2/core/di/di.dart';
import 'package:chat_bot_c2/core/l10n/localizations/app_localizations.dart';
import 'package:chat_bot_c2/feature/login/view_model/login_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Cubit<LoginStates> {
  LoginViewModel() : super(LoginStates());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? emailValidation(String email) {
    if (!RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
    ).hasMatch(email)) {
      return getIt<AppLocalizations>().invalidEmail;
    }

    return null;
  }

  String? isValidPassword(String password) {
    // Password must be at least 8 characters long.
    if (password.length < 8 ||
        !password.contains(RegExp(r'[A-Z]')) ||
        !password.contains(RegExp(r'[a-z]')) ||
        !password.contains(RegExp(r'[0-9]')) ||
        !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return getIt<AppLocalizations>().invalidPassword;
    }

    return null;
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(loginState: LoginLoadingState()));
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(loginState: LoginSuccessState<bool>(data: true)));
    }
  }
}

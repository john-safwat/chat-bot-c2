sealed class LoginState {}

class LoginInitialState extends LoginState {}

class LoginSuccessState<T> extends LoginState {
  T? data;

  LoginSuccessState({this.data});
}

class LoginLoadingState extends LoginState {
  String? message;

  LoginLoadingState({this.message});
}

class LoginFailState extends LoginState {
  String? message;
  Exception? exception;

  LoginFailState({this.message, this.exception});
}

class LoginStates {
  LoginState? loginState;

  LoginStates({this.loginState});

  LoginStates copyWith({LoginState? loginState}) {
    return LoginStates(loginState: loginState ?? this.loginState);
  }
}

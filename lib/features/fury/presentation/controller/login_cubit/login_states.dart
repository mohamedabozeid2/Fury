abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class FuryLoginChangeVisibility extends LoginStates{}

class UserLoginLoadingState extends LoginStates{}

class UserLoginSuccessState extends LoginStates{}

class RequestTokenErrorState extends LoginStates{
  final String error;

  RequestTokenErrorState(this.error);
}

class CreateSessionWithLoginErrorState extends LoginStates{
  final String error;

  CreateSessionWithLoginErrorState(this.error);
}

class CreateNewSessionErrorState extends LoginStates{
  final String error;

  CreateNewSessionErrorState(this.error);
}

class GetAccountDetailsErrorState extends LoginStates{}


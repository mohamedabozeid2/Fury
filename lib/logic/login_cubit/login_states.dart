abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class FuryLoginChangeVisibility extends LoginStates{}

class FuryLoginLoadingState extends LoginStates{}
class FuryLoginSuccessState extends LoginStates{
  final String uId;
  FuryLoginSuccessState({required this.uId});
}
class FuryLoginErrorState extends LoginStates{}
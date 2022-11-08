abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class RegisterChangeVisibility extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{
  final String uId;
  RegisterSuccessState({required this.uId});
}
class RegisterErrorState extends RegisterStates{}
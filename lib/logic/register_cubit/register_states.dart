abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class FuryRegisterChangeVisibility extends RegisterStates{}

class FuryRegisterLoadingState extends RegisterStates{}
class FuryRegisterSuccessState extends RegisterStates{
  final String uId;
  FuryRegisterSuccessState({required this.uId});
}
class FuryRegisterErrorState extends RegisterStates{}
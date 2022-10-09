import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/logic/login_cubit/login_states.dart';


class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);


  bool isVisible = true;
  IconData icon = Icons.visibility;

  void changeVisibility() {
    isVisible = !isVisible;
    if (isVisible) {
      icon = Icons.visibility;
    } else {
      icon = Icons.visibility_off;
    }
    emit(FuryLoginChangeVisibility());
  }

  void userLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) {
    emit(FuryLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.trim(), password: password)
        .then((value) {
      if(!FirebaseAuth.instance.currentUser!.emailVerified){
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
      }
      emit(FuryLoginSuccessState(uId: value.user!.uid));
    }).catchError((error) {
      print("Error from Login===> ${error.toString()}");
      emit(FuryLoginErrorState());
    });
  }

}
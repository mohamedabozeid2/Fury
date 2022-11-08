import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/logic/home_layout/home_cubit.dart';
import 'package:movies_application/logic/register_cubit/register_states.dart';

import '../../features/fury/data/models/user_model.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isVisible = true;
  IconData icon = Icons.visibility;

  void changeVisibility() {
    isVisible = !isVisible;
    if (isVisible) {
      icon = Icons.visibility;
    } else {
      icon = Icons.visibility_off;
    }
    emit(RegisterChangeVisibility());
  }

  void userRegister({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required BuildContext context,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email.trim(), password: password)
        .then((value) {
      userCreate(
          firstName: firstName,
          lastName: lastName,
          email: email,
          uId: value.user!.uid,
          context: context);
    }).catchError((error) {
      print("Error in creating user ${error.toString()}");
      emit(RegisterErrorState());
    });
  }

  void userCreate({
    required String firstName,
    required String lastName,
    required String email,
    required String uId,
    required BuildContext context,
  }) {
    UserModel model = UserModel(
      email: email,
      firstName: firstName,
      lastName: lastName,
      uId: uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toJson())
        .then((value) {
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
      emit(RegisterSuccessState(uId: uId));
    }).catchError((error) {
      print('Error in adding user to database ===> ${error.toString()}');
      emit(RegisterErrorState());
    });
  }
}

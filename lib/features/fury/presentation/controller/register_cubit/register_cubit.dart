
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/features/fury/presentation/controller/register_cubit/register_states.dart';

import '../../../domain/entities/user_data.dart';



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

  }

  void userCreate({
    required String firstName,
    required String lastName,
    required String email,
    required String uId,
    required BuildContext context,
  }) {

  }
}

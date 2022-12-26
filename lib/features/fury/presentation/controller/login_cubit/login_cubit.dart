import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/hive/hive_helper.dart';
import 'package:movies_application/core/hive/hive_keys.dart';
import 'package:movies_application/core/network/network.dart';
import 'package:movies_application/core/utils/constants.dart';
import 'package:movies_application/features/fury/domain/entities/request_token.dart';

import '../../../domain/entities/session_id.dart';
import '../../../domain/use_cases/create_new_session.dart';
import '../../../domain/use_cases/create_session_with_login.dart';
import '../../../domain/use_cases/get_account_details.dart';
import '../../../domain/use_cases/request_token_for_login.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  final RequestTokenUseCase requestTokenUseCase;
  final CreateSessionWithLoginUseCase createSessionWithLoginUseCase;
  final CreateNewSessionUseCase createNewSessionUseCase;
  final GetAccountDetailsUseCase getAccountDetailsUseCase;

  LoginCubit(
    this.requestTokenUseCase,
    this.createSessionWithLoginUseCase,
    this.createNewSessionUseCase,
    this.getAccountDetailsUseCase,
  ) : super(LoginInitialState());

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

  RequestToken? token;
  SessionId? sessionId;

  void userLogin({
    required String userName,
    required String password,
  }) {
    emit(UserLoginLoadingState());
    CheckConnection.checkConnection().then((value) {
      internetConnection = value;
      if (value == true) {
        requestToken().then((value) async {
          await createSessionWithLogin(
            requestToken: token!.requestToken,
            password: password,
            userName: userName,
          ).then((value) async {
            await createNewSession(
              requestToken: token!.requestToken,
            ).then((value) {
              getAccountDetails(sessionId: sessionId!.sessionId).then((value) {
                emit(UserLoginSuccessState());
              });
            });
          }).catchError((error) {});
        }).catchError((error) {});
      }
    });
  }

  Future<void> requestToken() async {
    await requestTokenUseCase.execute().then((value) {
      value.fold((l) {
        emit(RequestTokenErrorState(l.message));
      }, (r) {
        token = r;
      });
    }).catchError((error) {
      emit(RequestTokenErrorState(error.toString()));
    });
  }

  Future<void> createSessionWithLogin({
    required String userName,
    required String password,
    required String requestToken,
  }) async {
    await createSessionWithLoginUseCase
        .execute(
      userName: userName,
      password: password,
      requestToken: requestToken,
    )
        .then((value) {
      value.fold((l) {
        emit(CreateSessionWithLoginErrorState(l.message));
      }, (r) {});
    }).catchError((error) {
      emit(CreateSessionWithLoginErrorState(error.toString()));
    });
  }

  Future<void> createNewSession({
    required String requestToken,
  }) async {
    await createNewSessionUseCase
        .execute(requestToken: requestToken)
        .then((value) {
      value.fold((l) {
        emit(CreateNewSessionErrorState(l.message));
      }, (r) {
        sessionId = r;
        HiveHelper.putInBox(
          box: HiveHelper.userId,
          key: HiveKeys.userId,
          data: sessionId!.sessionId,
        );
      });
    }).catchError((error) {
      emit(CreateNewSessionErrorState(error.toString()));
    });
  }

  Future<void> getAccountDetails({
    required String sessionId,
  }) async {
    await getAccountDetailsUseCase
        .execute(
      sessionId: sessionId,
    )
        .then((value) {
      value.fold((l) {
        emit(GetAccountDetailsErrorState());
      }, (r) {
        accountDetails = r;
        HiveHelper.putInAccountDetails(data: r);
        // HiveHelper.putInBox(box: box, key: key, data: data)
      });
    }).catchError((error) {
      emit(GetAccountDetailsErrorState());
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/app_fonts.dart';
import 'package:movies_application/core/utils/border_radius.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/utils/helper.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/core/widgets/button.dart';
import 'package:movies_application/core/widgets/text_button.dart';
import 'package:movies_application/core/widgets/text_field.dart';
import 'package:movies_application/features/fury/presentation/screens/register_screen/register_screen.dart';
import 'package:movies_application/logic/login_cubit/login_cubit.dart';
import 'package:movies_application/logic/login_cubit/login_states.dart';

import '../../../../../core/shared_preference/cache_helper.dart';
import '../../../../../core/utils/constants.dart';
import '../Layout/Layout.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is FuryLoginSuccessState) {
          Components.navigateAndFinish(context: context, widget: Layout());
          CacheHelper.saveData(key: 'uId', value: state.uId);
          uId = state.uId;
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              Helper.maxWidth = constraints.maxWidth;
              Helper.maxHeight = constraints.maxHeight;
              return SizedBox(
                height: Helper.maxHeight,
                width: Helper.maxWidth,
                child: Stack(
                  children: [
                    Container(
                      height: Helper.maxHeight,
                      width: Helper.maxWidth,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                              AssetImage('assets/images/loginWallpaper.jpg'))),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Helper.maxHeight * 0.05,
                        horizontal: Helper.maxWidth * 0.03,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                  Helper.maxHeight *
                                      0.05,
                                  horizontal:
                                  Helper.maxHeight *
                                      0.05),
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.7),
                                  borderRadius:
                                  BorderRadius.circular(AppRadius.medium2)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppStrings.signIn,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: AppColors.mainColor),
                                  ),
                                  SizedBox(
                                    height:
                                    Helper.maxHeight *
                                        0.02,
                                  ),
                                  DefaultTextField(
                                    fillColor: Colors.white,
                                    borderRadius: AppRadius.medium2,
                                    context: context,
                                    onChangeFunction: (value) {
                                      setState(() {});
                                    },
                                    contentStyle: Theme
                                        .of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                        color: Colors.black
                                    ),
                                    controller: emailController,
                                    hintStyle: Theme
                                        .of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(color: AppColors.greyColor),
                                    type: TextInputType.emailAddress,
                                    label: AppStrings.emailAddress,
                                  ),
                                  SizedBox(
                                    height:
                                    Helper.maxHeight *
                                        0.02,
                                  ),
                                  DefaultTextField(
                                    fillColor: Colors.white,
                                    borderRadius: AppRadius.medium2,
                                    context: context,
                                    onChangeFunction: (value) {
                                      setState(() {});
                                    },
                                    contentStyle: Theme
                                        .of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                        color: Colors.black
                                    ),
                                    controller: passwordController,
                                    isPassword: LoginCubit
                                        .get(context)
                                        .isVisible,
                                    sufIconFun: () {
                                      LoginCubit.get(context)
                                          .changeVisibility();
                                    },
                                    suffixIcon: LoginCubit
                                        .get(context)
                                        .icon,
                                    hintStyle: Theme
                                        .of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(color: AppColors.greyColor),
                                    type: TextInputType.visiblePassword,
                                    label: AppStrings.password,
                                  ),
                                  SizedBox(
                                    height:
                                    Helper.maxHeight *
                                        0.02,
                                  ),
                                  DefaultButton(
                                    fun: () {
                                      if (emailController.text.isNotEmpty &&
                                          passwordController.text.isNotEmpty) {
                                        LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          context: context,
                                        );
                                      } else {
                                        Components.showSnackBar(
                                            title: AppStrings.appName,
                                            message: AppStrings.emailAndPassword,
                                            backgroundColor: Colors.redAccent,
                                            textColor: Colors.white);
                                      }
                                    },
                                    text: AppStrings.login,
                                    textColor: Colors.white,
                                    backgroundColor:
                                    emailController.text.isNotEmpty &&
                                        passwordController.text.isNotEmpty
                                        ? AppColors.mainColor
                                        : AppColors.lightBlack,
                                    height:
                                    Helper.maxHeight *
                                        0.07,
                                    fontSize: AppFontSize.s20,
                                    borderRadius: AppRadius.medium2,
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        AppStrings.noAccount,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(color: Colors.white),
                                      ),
                                      DefaultTextButton(
                                        text: AppStrings.signUp,
                                        fun: () {
                                          Components.scaleNavigateTo(
                                              context, RegisterScreen());
                                        },
                                        fontSize: AppFontSize.s14,
                                        fontWeight: FontWeightManager.semiBold,
                                        textColor: AppColors.mainColor,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

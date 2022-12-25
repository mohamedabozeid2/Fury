import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/app_fonts.dart';
import 'package:movies_application/core/utils/app_values.dart';
import 'package:movies_application/core/utils/assets_manager.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/utils/helper.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/core/widgets/adaptive_indicator.dart';
import 'package:movies_application/core/widgets/button.dart';
import 'package:movies_application/core/widgets/text_button.dart';
import 'package:movies_application/core/widgets/text_field.dart';
import 'package:movies_application/features/fury/presentation/screens/Layout/Layout.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/login_cubit/login_cubit.dart';
import '../../controller/login_cubit/login_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var userNameController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(ImageAssets.loginWallpaper),
                    ),
                  ),
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
                              vertical: Helper.maxHeight * 0.05,
                              horizontal: Helper.maxHeight * 0.05),
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(AppSize.s12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.signIn,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: AppColors.mainColor),
                              ),
                              SizedBox(
                                height: Helper.maxHeight * 0.02,
                              ),
                              DefaultTextField(
                                fillColor: Colors.white,
                                borderRadius: AppSize.s12,
                                context: context,
                                contentStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: Colors.black),
                                controller: userNameController,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: AppColors.greyColor),
                                type: TextInputType.name,
                                label: AppStrings.userName,
                              ),
                              SizedBox(
                                height: Helper.maxHeight * 0.02,
                              ),
                              BlocConsumer<LoginCubit, LoginStates>(
                                listener: (context, state) {},
                                buildWhen: (previous, current) =>
                                    current is FuryLoginChangeVisibility,
                                builder: (context, state) {
                                  return DefaultTextField(
                                    fillColor: Colors.white,
                                    borderRadius: AppSize.s12,
                                    context: context,
                                    contentStyle: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(color: Colors.black),
                                    controller: passwordController,
                                    isPassword:
                                        LoginCubit.get(context).isVisible,
                                    sufIconFun: () {
                                      LoginCubit.get(context)
                                          .changeVisibility();
                                    },
                                    suffixIcon: LoginCubit.get(context).icon,
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(color: AppColors.greyColor),
                                    type: TextInputType.visiblePassword,
                                    label: AppStrings.password,
                                  );
                                },
                              ),
                              SizedBox(
                                height: Helper.maxHeight * 0.02,
                              ),
                              BlocConsumer<LoginCubit, LoginStates>(
                                listener: (context, state) {
                                  if (state is CreateNewSessionErrorState) {
                                    Components.showSnackBar(
                                      title: 'Fury',
                                      message: 'Wrong data',
                                      backgroundColor: AppColors.redErrorColor,
                                      textColor: AppColors.textWhiteColor,
                                    );
                                  } else if (state is UserLoginSuccessState) {
                                    Components.navigateAndFinish(
                                        context: context,
                                        widget: const Layout());
                                  }
                                },
                                buildWhen: (previous, current) =>
                                    current is UserLoginSuccessState ||
                                    current is UserLoginLoadingState ||
                                    previous is UserLoginLoadingState,
                                builder: (context, state) {
                                  return state is UserLoginLoadingState
                                      ? Center(
                                          child: AdaptiveIndicator(
                                            os: Components.getOS(),
                                            color: AppColors.mainColor,
                                          ),
                                        )
                                      : DefaultButton(
                                          fun: () {
                                            if (userNameController
                                                    .text.isNotEmpty &&
                                                passwordController
                                                    .text.isNotEmpty) {
                                              LoginCubit.get(context).userLogin(
                                                userName:
                                                    userNameController.text,
                                                password:
                                                    passwordController.text,
                                              );
                                            } else {
                                              Components.showSnackBar(
                                                  title: AppStrings.appName,
                                                  message: AppStrings
                                                      .emailAndPassword,
                                                  backgroundColor:
                                                      AppColors.redErrorColor,
                                                  textColor:
                                                      AppColors.textWhiteColor);
                                            }
                                          },
                                          text: AppStrings.login,
                                          textColor: Colors.white,
                                          backgroundColor: AppColors.mainColor,
                                          height: AppSize.s50,
                                          fontSize: AppFontSize.s20,
                                          borderRadius: AppSize.s12,
                                        );
                                },
                              ),
                              SizedBox(
                                height: AppSize.s15,
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppStrings.noAccount,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(color: Colors.white),
                                  ),
                                  DefaultTextButton(
                                    text: AppStrings.signUp,
                                    fun: () {
                                      launchUrl(Uri.parse(
                                          'https://www.themoviedb.org/signup'));
                                    },
                                    fontSize: AppFontSize.s14,
                                    fontWeight: FontWeightManager.semiBold,
                                    textColor: AppColors.mainColor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: AppSize.s8,
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppStrings.forgetPassword,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(color: Colors.white),
                                  ),
                                  DefaultTextButton(
                                    text: AppStrings.resetPassword,
                                    fun: () {
                                      launchUrl(Uri.parse(
                                          'https://www.themoviedb.org/reset-password'));
                                    },
                                    fontSize: AppFontSize.s14,
                                    fontWeight: FontWeightManager.semiBold,
                                    textColor: AppColors.mainColor,
                                  ),
                                ],
                              ),
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
  }
}

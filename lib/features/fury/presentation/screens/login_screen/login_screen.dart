import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/app_fonts.dart';
import 'package:movies_application/core/utils/border_radius.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/utils/helper.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/core/widgets/button.dart';
import 'package:movies_application/core/widgets/cached_image.dart';
import 'package:movies_application/core/widgets/text_button.dart';
import 'package:movies_application/core/widgets/text_field.dart';
import 'package:movies_application/features/fury/presentation/screens/register_screen/register_screen.dart';
import 'package:movies_application/logic/login_cubit/login_cubit.dart';
import 'package:movies_application/logic/login_cubit/login_states.dart';

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
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          body: Container(
            height: Helper.getScreenHeight(context: context),
            width: Helper.getScreenWidth(context: context),
            child: Stack(
              children: [
                Container(
                  height: Helper.getScreenHeight(context: context),
                  width: Helper.getScreenWidth(context: context),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              AssetImage('assets/images/loginWallpaper.jpg'))),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Helper.getScreenHeight(context: context) * 0.05,
                    horizontal: Helper.getScreenWidth(context: context) * 0.03,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  Helper.getScreenHeight(context: context) *
                                      0.05,
                              horizontal:
                                  Helper.getScreenWidth(context: context) *
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: AppColors.mainColor),
                              ),
                              SizedBox(
                                height:
                                    Helper.getScreenHeight(context: context) *
                                        0.02,
                              ),
                              DefaultTextField(
                                fillColor: Colors.white,
                                borderRadius: AppRadius.medium2,
                                context: context,
                                onChangeFunction: (value) {
                                  setState(() {});
                                },
                                controller: emailController,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: AppColors.greyColor),
                                type: TextInputType.emailAddress,
                                label: AppStrings.emailAddress,
                              ),
                              SizedBox(
                                height:
                                    Helper.getScreenHeight(context: context) *
                                        0.02,
                              ),
                              DefaultTextField(
                                fillColor: Colors.white,
                                borderRadius: AppRadius.medium2,
                                context: context,
                                onChangeFunction: (value) {
                                  setState(() {});
                                },
                                controller: passwordController,
                                isPassword: LoginCubit.get(context).isVisible,
                                sufIconFun: () {
                                  LoginCubit.get(context).changeVisibility();
                                },
                                suffixIcon: LoginCubit.get(context).icon,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: AppColors.greyColor),
                                type: TextInputType.visiblePassword,
                                label: AppStrings.password,
                              ),
                              SizedBox(
                                height:
                                    Helper.getScreenHeight(context: context) *
                                        0.02,
                              ),
                              DefaultButton(
                                fun: () {
                                  if (emailController.text.isNotEmpty &&
                                      passwordController.text.isNotEmpty) {
                                    print('text');
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
                                    Helper.getScreenHeight(context: context) *
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(color: Colors.white),
                                  ),
                                  DefaultTextButton(
                                    text: AppStrings.signUp,
                                    fun: () {
                                      Components.navigateTo(context, RegisterScreen());
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
          ),
        );
      },
    );
  }
}

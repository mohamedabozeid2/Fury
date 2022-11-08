import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:movies_application/core/utils/app_fonts.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/core/widgets/adaptive_indicator.dart';
import 'package:movies_application/core/widgets/button.dart';
import 'package:movies_application/core/widgets/text_field.dart';
import 'package:movies_application/logic/register_cubit/register_cubit.dart';
import 'package:movies_application/logic/register_cubit/register_states.dart';
import '../../../../../core/shared_preference/cache_helper.dart';
import '../../../../../core/utils/Colors.dart';
import '../../../../../core/utils/border_radius.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/helper.dart';
import '../Layout/Layout.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var firstNameController = TextEditingController();

  var lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          Get.snackbar('Fury', 'Registered Successfully',
              colorText: Colors.white, backgroundColor: Colors.greenAccent);
          CacheHelper.saveData(key: 'uId', value: state.uId);
          uId = state.uId;
          Components.navigateAndFinish(context: context, widget: Layout());
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.center,
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
                      horizontal:
                          Helper.getScreenWidth(context: context) * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DefaultTextField(
                                fillColor: Colors.white,
                                borderRadius: AppRadius.medium2,
                                context: context,
                                onChangeFunction: (value) {
                                  setState(() {});
                                },
                                controller: firstNameController,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: AppColors.greyColor),
                                type: TextInputType.text,
                                label: AppStrings.firstName,
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
                                controller: lastNameController,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: AppColors.greyColor),
                                type: TextInputType.text,
                                label: AppStrings.lastName,
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
                                isPassword:
                                    RegisterCubit.get(context).isVisible,
                                sufIconFun: () {
                                  RegisterCubit.get(context).changeVisibility();
                                },
                                suffixIcon: RegisterCubit.get(context).icon,
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
                                        0.03,
                              ),
                              state is RegisterLoadingState
                                  ? Center(
                                      child: AdaptiveIndicator(
                                      os: Components.getOS(),
                                      color: AppColors.mainColor,
                                    ))
                                  : DefaultButton(
                                      fun: () {
                                        if (emailController.text.isNotEmpty &&
                                            passwordController
                                                .text.isNotEmpty &&
                                            firstNameController
                                                .text.isNotEmpty &&
                                            lastNameController
                                                .text.isNotEmpty) {
                                          RegisterCubit.get(context)
                                              .userRegister(
                                            firstName: firstNameController.text,
                                            lastName: lastNameController.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                            context: context,
                                          );
                                        }
                                      },
                                      text: AppStrings.register,
                                      textColor: Colors.white,
                                      backgroundColor: emailController
                                                  .text.isNotEmpty &&
                                              passwordController
                                                  .text.isNotEmpty &&
                                              firstNameController
                                                  .text.isNotEmpty &&
                                              lastNameController.text.isNotEmpty
                                          ? AppColors.mainColor
                                          : AppColors.lightBlack,
                                      height: Helper.getScreenHeight(
                                              context: context) *
                                          0.07,
                                      fontSize: AppFontSize.s20,
                                      borderRadius: AppRadius.medium2,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
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

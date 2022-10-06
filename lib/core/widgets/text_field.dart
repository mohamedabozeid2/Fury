import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/border_radius.dart';

class DefaultTextField extends StatelessWidget {
  final BuildContext? context;
  final TextEditingController controller;
  final TextInputType type;
  final String label;
  bool isPassword;
  String validation;
  Color? iconColor;
  Color? cursorColor;
  Color fillColor;
  TextStyle? hintStyle;
  TextStyle? contentStyle;
  Widget? prefixIcon;
  Widget? prefixWidget;
  Color borderColor;
  double? paddingInside;
  IconData? suffixIcon;
  void Function()? sufIconFun;
  void Function(String)? onSubmitFunction;
  void Function(String)? onChangeFunction;
  double borderRadius;

  DefaultTextField({
    required this.context,
    required this.controller,
    required this.type,
    required this.label,
    this.isPassword = false,
    this.validation = "",
    this.fillColor = Colors.transparent,
    this.iconColor,
    this.cursorColor,
    this.sufIconFun,
    this.onSubmitFunction,
    this.onChangeFunction,
    this.prefixWidget,
    this.borderColor = Colors.white,
    this.borderRadius = AppRadius.low1,
    this.paddingInside,
    this.prefixIcon,
    this.hintStyle,
    this.contentStyle,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      // maxLines: 1,
      cursorColor: cursorColor,
      obscureText: isPassword,
      validator: (String? value) {
        if (value!.isEmpty) {
          return validation;
        }
      },
      style: contentStyle,
      onChanged: onChangeFunction,
      onFieldSubmitted: onSubmitFunction,
      decoration: InputDecoration(
          fillColor: fillColor,
          filled: true,
          hintText: label,
          hintStyle: hintStyle,
          prefix: prefixWidget,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: prefixIcon ?? prefixIcon,
          ),
          suffixIcon: IconButton(
            onPressed: sufIconFun,
            icon: Icon(
                suffixIcon == null
                    ? suffixIcon = null
                    : suffixIcon = suffixIcon,
                color: AppColors.mainColor),
          ),
          contentPadding: paddingInside != null
              ? EdgeInsets.symmetric(vertical: paddingInside!)
              : null,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor))),
    );
  }
}

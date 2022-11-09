import 'package:flutter/material.dart';

class Helper{
  static late double maxHeight;
  static late double maxWidth;
  // static double getScreenWidth({required BuildContext context}){
  //   return MediaQuery.of(context).size.width;
  // }
  // static double getScreenHeight({required BuildContext context}){
  //   return MediaQuery.of(context).size.height;
  // }
  static double getPaddingTop({required BuildContext context}){
    return MediaQuery.of(context).viewPadding.top;
  }
  static double getPaddingBot({required BuildContext context}){
    return MediaQuery.of(context).viewPadding.bottom;
  }
  static double getPaddingLeft({required BuildContext context}){
    return MediaQuery.of(context).viewPadding.left;
  }
  static double getPaddingRight({required BuildContext context}){
    return MediaQuery.of(context).viewPadding.right;
  }
}

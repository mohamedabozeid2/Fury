import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/strings.dart';

import '../../../../../core/widgets/button.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultButton(
          fun: () {

          },
          text: AppStrings.signOut,
          height: 100,
          fontSize: 20,
          borderRadius: 0,
        )
      ],
    );
  }
}

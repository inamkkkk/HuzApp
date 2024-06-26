import 'package:flutter/material.dart';
import 'package:huz/Responsive/ResponsiveClass.dart';

import '../../../TextStyles/AppFonts.dart';
import '../../../TextStyles/Color.dart';




class AuthHeaderText extends StatelessWidget {
  final String headerText;
  const AuthHeaderText({
    required this.headerText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      headerText,
      style: TextStyle(
          fontFamily: AppFonts.poppinsBold,
          color: AppColors.black,
          fontSize:responsive(20,context),
      ),
    );
  }
}
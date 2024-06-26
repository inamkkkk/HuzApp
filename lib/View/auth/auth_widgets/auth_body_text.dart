import 'package:flutter/material.dart';
import 'package:huz/Responsive/ResponsiveClass.dart';

import '../../../TextStyles/AppFonts.dart';
import '../../../TextStyles/Color.dart';



class AuthBodyText extends StatelessWidget {
  final String bodyText;
  const AuthBodyText({
    required this.bodyText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      bodyText,
      style: TextStyle(
          fontFamily: AppFonts.poppinsRegular,
          color: AppColors.black,
          fontSize: responsive(12,context),

      ),
      textAlign: TextAlign.center,
    );
  }
}
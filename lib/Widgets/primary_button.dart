
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:huz/TextStyles/styles.dart';

import '../Responsive/ResponsiveClass.dart';
import '../TextStyles/AppFonts.dart';
import '../TextStyles/Color.dart';



class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    super.key,
    required this.btnText,
    required this.onPressed,
    this.width,

  });
  final Callback onPressed;
  final String btnText;
  double? width;
  @override
  Widget build(BuildContext context) {
    debugPrint(width.toString());
    return GestureDetector(
      onTap: onPressed,
      child: Container(

        height: responsive(52,context),
        width: width,

        decoration: BoxDecoration(
          color: AppColors.GlobelColor,
          borderRadius: BorderRadius.circular(responsive(5,context)),),
        child: Center(
          child: customFonts(text: btnText, size: 20, color: Colors.white, fontWeight: FontWeight.bold, context: context)
        ),
      ),
    );
  }
}

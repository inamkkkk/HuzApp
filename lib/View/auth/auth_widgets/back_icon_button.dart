import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:huz/Responsive/ResponsiveClass.dart';




class BackIconButton extends StatelessWidget {
  const BackIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.back();
      },
      child: SvgPicture.asset(
        width: responsive(27,context),
        'assets/images/arrowBackIcon.svg',
      ),
    );
  }
}
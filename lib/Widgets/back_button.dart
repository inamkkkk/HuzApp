
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../Responsive/ResponsiveClass.dart';






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
        child: Icon(Icons.arrow_back,
          size: responsive(35, context),
        )
    );
  }
}
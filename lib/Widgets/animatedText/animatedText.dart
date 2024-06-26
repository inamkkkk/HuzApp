import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../Responsive/ResponsiveClass.dart';
import '../../TextStyles/Color.dart';

class LoadingDots extends StatefulWidget {
  var isfrombooking;
  LoadingDots({super.key,required this.isfrombooking});

  @override
  _LoadingDotsState createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots>{



  @override
  Widget build(BuildContext context) {
    return  Container(

        height: widget.isfrombooking?responsive(52,context):responsive(44.03,context),
      width: MediaQuery.sizeOf(context).width,

        decoration: BoxDecoration(
          color: AppColors.GlobelColor,
          borderRadius: BorderRadius.circular(responsive(5,context)),),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Lottie.asset(
            'assets/anim.json',
            width: responsive(50, context),
            height: 200,
            repeat: true,
            // fit: BoxFit.fill,

          ),
        ),

    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:huz/Responsive/ResponsiveClass.dart';
import 'package:huz/TextStyles/Color.dart';

Widget filterbutton(context){
  return Container(
    width: responsive(55, context),
    height: responsive(52, context),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.GlobelColor, // Change the color as needed
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Padding(
      padding:  EdgeInsets.symmetric(horizontal:responsive(10, context)),
      child: SvgPicture.asset(
        width: responsive(23, context),
        height: responsive(23, context),
        'images/filter.svg',
        semanticsLabel: 'vector',
        fit: BoxFit.fitWidth,
      
      ),
    ),
    // Additional child widgets can be added here if needed
  );
}
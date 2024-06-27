import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Responsive/ResponsiveClass.dart';
import '../../../../TextStyles/Color.dart';
import '../../../../TextStyles/styles.dart';


class CustomTab extends StatelessWidget {
  final String text;
  final bool isSelected;
  final String url;
  final String count;

   CustomTab({
    Key? key,
     required this.count,
    required this.url,
    required this.text,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return Container(
      // width: responsive(112, context),
      height: responsive(51, context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(

        Radius.circular(responsive(05, context))
            ),

        color: Colors.white,
        border: Border.all(
          color: AppColors.primaryfade,
          width: responsive(1, context),
        ),

      ),


      // width: responsive(100, context),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: responsive(10, context)),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textPoppins(context: context, text: '$count', size: 16,
                    fontWeight: FontWeight.w600,
            color: AppColors.textSecondary.withOpacity(0.9),

                ) ,
                textPoppins(context: context, text: '$text', size: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary.withOpacity(0.9),

                ) ,



              ],

            ),
                SizedBox(width: responsive(35, context),),
                SvgPicture.asset(
                  width: responsive(32, context),
                  height: responsive(36, context),
                  '$url',
                  semanticsLabel: 'vector',
                  // color: isSelected ? Colors.black : AppColors.grayboxcolor,
                  // fit: BoxFit.fitWidth,
            ),
          ],
        ),
      ),
    );





    // Container(
    //   //  width: responsiveDesign(57, context),
    //     height: responsive(45, context),
    //     padding:  EdgeInsets.symmetric(horizontal: responsive(20, context), vertical: responsive(7, context)),
    //     decoration: ShapeDecoration(
    //       color: isSelected ? AppColors.GlobelColor : Colors.white,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(responsive(10, context)),
    //         side: BorderSide(
    //           color: isSelected ? Colors.transparent : AppColors.grayboxcolor, // Define your border color
    //           width: 1.0, // Define the width of the border
    //         ),
    //       ),
    //     ),
    //     child: Center(
    //       child: Padding(
    //         padding:  EdgeInsets.symmetric(horizontal: responsive(02, context)),
    //         child: cardsubtitle(
    //           text: text,
    //           color: isSelected ? Colors.white : AppColors.grayboxcolor,
    //           context: context,
    //         ),
    //       ),
    //     )
    // ),

    // );
  }
}
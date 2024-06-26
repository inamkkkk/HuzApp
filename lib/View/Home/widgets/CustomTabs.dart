import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/utils.dart';
import 'package:huz/TextStyles/Color.dart';

import '../../../Responsive/ResponsiveClass.dart';
import '../../../TextStyles/styles.dart';

class CustomTab extends StatelessWidget {
  final String text;
  final bool isSelected;
  // final String url;

  const CustomTab({
    Key? key,
    // required this.url,
    required this.text,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    

    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: responsive(15, context)),
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: responsive(2, context)),
        decoration: BoxDecoration(
          border: isSelected?Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 2.5, // Adjust border width as needed
            ),
          ):null,
          color: Colors.transparent,
        ),


         // width: responsive(100, context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        //     SvgPicture.asset(
        //       width: responsive(23, context),
        //       height: responsive(23, context),
        //       '$url',
        //       semanticsLabel: 'vector',
        //       color: isSelected ? Colors.black : AppColors.grayboxcolor,
        //       // fit: BoxFit.fitWidth,
        // ),
            SizedBox(height: responsive(10, context),),
            isSelected?alt2cardsubtitle(
              text: text,
              center: true,
              color: isSelected ? Colors.black : AppColors.grayboxcolor,
              context: context
            ):alt1cardsubtitle(
                text: text,
                center: true,
                color: isSelected ? Colors.black : AppColors.grayboxcolor,
                context: context
            ),
            SizedBox(height: responsive(04, context),),

            // Visibility(
            //   visible: isSelected ? true : false,
            //   child: Container(
            //
            //     // margin: EdgeInsets.symmetric(horizontal: 10),
            //     height: responsive(02, context),
            //      width:responsive(100, context),
            //       color: isSelected ? Colors.black : AppColors.grayboxcolor,
            //   ),
            // )
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:huz/Responsive/ResponsiveClass.dart';
import 'package:huz/TextStyles/Color.dart';

import '../../../TextStyles/styles.dart';

class CustomContainer extends StatelessWidget {
  var title , meccanights, madinanights, starDate, endDate, amount,pkg, onView;
  CustomContainer({super.key,required this.title,this.madinanights,this.meccanights,this.starDate, this.endDate, this.amount,this.pkg, required this.onView});

  @override
  Widget build(BuildContext context) {
    return       Container(
      width: MediaQuery.sizeOf(context).width,

      decoration: BoxDecoration(
        // borderRadius : BorderRadius.all(
        //   Radius.circular(responsive(05, context)),
        // ),
        color : Colors.white,
        border : Border.all(
          color: Color(0xFFDCDCDC),
          width: responsive(2, context),
        ),

      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: responsive(20, context),vertical: responsive(10, context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customFonts(
                    text: title,
                    size: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.GlobelColor,
                    context: context),
                GestureDetector(
                  onTap: onView,
                  child: Container(
                    alignment: Alignment.center,
                    height: responsive(21, context),
                    width: responsive(46, context),
                    padding: EdgeInsets.symmetric(horizontal: responsive(6, context)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(responsive(6, context)),
                        border: Border.all(

                          color: Color(0xFFBBBBBB),
                        )
                    ),
                    child: customFonts(text: "View", size: 12, fontWeight: FontWeight.w500, color: AppColors.GlobelColor, context: context),
                  ),
                )
              ],
            ),
            SizedBox(
              height: responsive(05, context),
            ),
            customFonts(text: "$starDate to $endDate", size: 14, fontWeight: FontWeight.w500, color: AppColors.primaryBlackColor.withOpacity(0.9), context: context),

            SizedBox(
              height: responsive(05, context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: responsive(220, context),
                  child: Wrap(
                    spacing: 0.0,

                    children: List.generate(
                      pkg.include.length+1,
                          (index) => index ==0 ?
                      customFonts(text: "Includes: ",
                          size: 12, color: AppColors.primaryBlackColor,
                          fontWeight: FontWeight.bold, context: context):
                      customFonts(
                          text: "${pkg.include[index-1]}",
                          size: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryBlackColor,
                          context: context),
                    ),
                  ),
                ),
                customFonts(text: "PKR $amount", size: 16, fontWeight: FontWeight.w700, color: AppColors.GlobelColor, context: context),

              ],
            ),


          ],
        ),
      ),

    );
  }
}
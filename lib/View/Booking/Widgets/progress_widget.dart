
import 'package:flutter/material.dart';


import '../../../Responsive/ResponsiveClass.dart';
import '../../../TextStyles/Color.dart';
import '../../../TextStyles/styles.dart';


class ProgressWidget extends StatelessWidget {
  ProgressWidget({
    super.key,
    required this.packageName,
    required this.companyName,
    required this.percentage,
   
  });

  var packageName,companyName;
  var percentage;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: responsive(66, context),
      decoration: BoxDecoration(

        color: Colors.white,
        border: Border.all(
          color: Color(0xFFF2F2F2),
          width: responsive(2, context),
        ),
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: responsive(20, context)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customFonts(context: context, text: '$packageName', size: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlackColor.withOpacity(0.9),

                ) ,
                SizedBox(
                  height: responsive(04, context),
                ),
                customFonts(context: context, text: '$companyName', size: 12,
                  color: AppColors.primaryBlackColor.withOpacity(0.9),



                )
              ],
            ),
            // SimpleCircularProgressBar(
            //   valueNotifier: [01.0,023.0,34.0],
            //   mergeMode: true,
            //   onGetText: (double value) {
            //     return Text(
            //       '${value.toInt()}',
            //       style: const TextStyle(
            //         fontSize: 30,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white,
            //       ),
            //     );
            //   },
            // ),

            Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: percentage/100, // Convert percentage to a value between 0 and 1
                  backgroundColor: Color(0xFFDAE8E5),
                  color: AppColors.GlobelColor,
                  strokeWidth: responsive(5, context),
                ),

                customFonts(context: context, text: '${percentage == 0.0?0:percentage.toInt()}%', color: AppColors.GlobelColor,size: 15, fontWeight: FontWeight.w500,)


              ],
            ),


          ],
        ),
      ),

    );
  }
}

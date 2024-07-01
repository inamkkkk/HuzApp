


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Responsive/ResponsiveClass.dart';
import 'AppFonts.dart';
import 'Color.dart';

Widget  Heading1({var center, text,context,Color? color}){
  return Text(
    '$text',
    textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
    style: TextStyle(
      color: color,
      fontSize: responsive(40, context),
        fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
            fontWeight: FontWeight.bold
        )).fontFamily,
      // fontFamily: AppFonts.poppinsSemiBold,
      fontWeight: FontWeight.w600,
        height: 1
    ),
  );
}
Widget  Heading2({var center, text,context,Color? color}){
  return Text(
    '$text',
    textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
    style: TextStyle(
      color: color,
      fontSize: responsive(20, context),
      fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
          fontWeight: FontWeight.bold
      )).fontFamily,
      // fontFamily: AppFonts.poppinsSemiBold,
      fontWeight: FontWeight.w600,
    ),
  );
}

Widget  Heading3({var center, text,context,Color? color, isbold, isunderline}){
  return Text(
    '$text',
    textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
    style: TextStyle(
      decoration: isunderline==null?null:TextDecoration.underline,
      color: color,
      fontSize: responsive(16, context),
      fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
          fontWeight: isbold == null ? FontWeight.bold:FontWeight.normal,
      )).fontFamily,
      // fontFamily: AppFonts.poppinsMedium,
      fontWeight:  isbold == null ? FontWeight.w600:FontWeight.normal,
    ),
  );
}
Widget  Heading4({var center, text,context,Color? color}){
  return Text(
    '$text',
    textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
    style: TextStyle(
      color: color,
      fontSize: responsive(16, context),
      fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
          fontWeight: FontWeight.bold
      )).fontFamily,
      // fontFamily: AppFonts.poppinsSemiBold,
      fontWeight: FontWeight.w600,
    ),
  );
}
Widget  Heading44({var center, text,context,Color? color}){
  return Text(
    '$text',
    overflow: TextOverflow.ellipsis,
    textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
    style: TextStyle(
      overflow: TextOverflow.ellipsis,
      color: color,
      fontSize: responsive(20, context),
      fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
          fontWeight: FontWeight.bold
      )).fontFamily,
      // fontFamily: AppFonts.poppinsSemiBold,
      fontWeight: FontWeight.w600,
    ),
  );
}
Widget  Heading444({var center, text,context,Color? color}){
  return Container(
    width: responsive(300, context),
    child: Text(
      '$text',
      overflow: TextOverflow.ellipsis,
      textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: color,
        fontSize: responsive(20, context),
        fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
            fontWeight: FontWeight.bold
        )).fontFamily,
        // fontFamily: AppFonts.poppinsSemiBold,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
Widget  cardtitle({var center, text,context,Color? color}){
  return Text(
    '$text',
    textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
    style: TextStyle(
      color: color,
      fontSize: responsive(15, context),
      fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
          fontWeight: FontWeight.bold
      )).fontFamily,
      // fontFamily: AppFonts.poppinsSemiBold,
      fontWeight: FontWeight.w600,
    ),
  );
}
Widget  cardsubtitle({var center, text,context,Color? color}){
  return Text(
    '$text',
    textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      color: color,
      fontSize: responsive(15, context),
      fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
          fontWeight: FontWeight.bold
      )).fontFamily,
      fontWeight: FontWeight.w600,
    ),
  );
}
Widget  alt2cardsubtitle({var center, text,context,Color? color}){
  return Text(
    '$text',
    textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      color: color,
      fontSize: responsive(15, context),
      fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
          fontWeight: FontWeight.bold
      )).fontFamily,
      fontWeight: FontWeight.w600,
    ),
  );
}
Widget  alt1cardsubtitle({var center, text,context,Color? color}){
  return Text(
    '$text',
    textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      color: color,
      fontSize: responsive(15, context),
      fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
          // fontWeight: FontWeight.bold
      )).fontFamily,
      fontWeight: FontWeight.normal,
    ),
  );
}
Widget  altcardsubtitle({var center, text,context,Color? color}){
  return Text(
    '$text',
    textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      color: color,
      fontSize: responsive(15, context),
      fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
          // fontWeight: FontWeight.bold
      )).fontFamily,
      fontWeight: FontWeight.normal,
    ),
  );
}

Widget  alttcardsubtitle({var center, text,context,Color? color}){
  return Text(
    '$text',
    textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      color: color,
      fontSize: responsive(12, context),
      fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
        // fontWeight: FontWeight.bold
      )).fontFamily,
      fontWeight: FontWeight.normal,
    ),
  );
}
Widget customtabstext({var center, text,context,Color? color, isbold}){
  return Text(
    '$text',
    textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      color: color,
      fontSize: responsive(12, context),
      fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
          fontWeight: isbold == null ? FontWeight.bold:FontWeight.normal
      )).fontFamily,
      // fontFamily: AppFonts.poppinsRegular,
      fontWeight: FontWeight.normal,
    ),
  );
}

Widget bookingcarddescription({var center, text,context,Color? color, isbold}){
  return Text(
    '$text',
    maxLines: 6,
    textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      color: color,
      fontSize: responsive(12, context),
      fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
          fontWeight: isbold == null ? FontWeight.bold:FontWeight.normal
      )).fontFamily,
      // fontFamily: AppFonts.poppinsRegular,
      fontWeight: FontWeight.normal,
    ),
  );
}
Widget  cardtrailing({var center, text,context,Color? color}){
  return Container(
// alignment: Alignment.centerRight,
    width: responsive(140, context),
    child: Text(
      '$text',
      textAlign: center == null? TextAlign.right:center!=null&&center == false?TextAlign.left:TextAlign.center,
      overflow: TextOverflow.ellipsis,

      style: TextStyle(
        color: color,
        fontSize: responsive(16, context),
        fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
            fontWeight: FontWeight.bold
        )).fontFamily,
        // fontFamily: AppFonts.poppinsSemiBold,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget  Dcardtrailing({var center, text,context,Color? color}){
  return Container(
// alignment: Alignment.centerRight,

    child: Text(
      '$text',
      textAlign: center == null? TextAlign.right:center!=null&&center == false?TextAlign.left:TextAlign.center,
      overflow: TextOverflow.ellipsis,

      style: TextStyle(
        color: color,
        fontSize: responsive(16, context),
        fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
            fontWeight: FontWeight.w900
        )).fontFamily,
        // fontFamily: AppFonts.poppinsSemiBold,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
Widget  Tcardtrailing({var center, text,context,Color? color}){
  return Container(
// alignment: Alignment.centerRight,

    child: Text(
      '$text',
      textAlign: center == null? TextAlign.right:center!=null&&center == false?TextAlign.left:TextAlign.center,
      overflow: TextOverflow.ellipsis,

      style: TextStyle(
        color: color,
        fontSize: responsive(16, context),
        fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
            // fontWeight: FontWeight.w900
        )).fontFamily,
        // fontFamily: AppFonts.poppinsSemiBold,
        // fontWeight: FontWeight.w600,
      ),
    ),
  );
}
Widget  Datetext({var center, text,context,Color? color}){
  return Container(
// alignment: Alignment.centerRight,
//     width: responsive(140, context),
    child: Text(
      '$text',
      textAlign: center == null? TextAlign.right:center!=null&&center == false?TextAlign.left:TextAlign.center,
      overflow: TextOverflow.ellipsis,

      style: TextStyle(
        color: color,
        fontSize: responsive(16, context),
        fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
            fontWeight: FontWeight.bold
        )).fontFamily,
        // fontFamily: AppFonts.poppinsSemiBold,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
Widget  cardtrailing2({var center, text,context,Color? color}){
  return Text(
    '$text',
    textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
    style: TextStyle(
      color: color,
      fontSize: responsive(20, context),
      fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
        fontWeight: FontWeight.bold
      )).fontFamily,
      // fontFamily: AppFonts.poppinsSemiBold,
      fontWeight: FontWeight.w600,
    ),
  );
}


Widget  mainheading({var center, text,context,Color? color}){
  return Text(
    '$text',
    textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
    style: TextStyle(
      color: color,
      fontSize: responsive(24, context),
      fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
          fontWeight: FontWeight.bold
      )).fontFamily,
      // fontFamily: AppFonts.poppinsSemiBold,
      fontWeight: FontWeight.w600,
    ),
  );
}
Widget  cardtrailingsubtitle({var center, text,context,Color? color,isbold,isunderline}){
  return Text(
    '$text',
    textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
    style: TextStyle(
      decoration: isunderline==null?null:TextDecoration.underline,
      color: color,
      fontSize: responsive(14, context),
      fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
          fontWeight: isbold==null ? FontWeight.bold :FontWeight.normal
      )).fontFamily,
      // fontFamily: AppFonts.poppinsMedium,
      fontWeight:  isbold==null ?FontWeight.w600:FontWeight.normal,
    ),
  );
}

Widget  Discription({var center, text,context,Color? color}){
  return Text(
      '$text',
      textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
      // overflow: TextOverflow.ellipsis,
      //  maxLines: 6,
      style: TextStyle(
    // overflow: TextOverflow.ellipsis,
        color: color,
        fontSize: responsive(15, context),
        fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
            // fontWeight: FontWeight.bold
        )).fontFamily,
        // fontFamily: AppFonts.poppinsMedium,
        fontWeight: FontWeight.normal,
      ),
    );
}
Widget  Discriptions({var center, text,context,Color? color}){
  return Container(
    width: responsive(200, context),
    child: Text(
      '$text',
      textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
     overflow: TextOverflow.ellipsis,
      // maxLines: 6,
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: color,
        fontSize: responsive(15, context),
        fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
          // fontWeight: FontWeight.bold
        )).fontFamily,
        // fontFamily: AppFonts.poppinsMedium,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}


Widget  card({var center, text,context,Color? color}){
  return Text(
    '$text',
    textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
    style: TextStyle(
      color: color,
      fontSize: responsive(15, context),
      fontFamily: AppFonts.poppinsMedium,
      fontWeight: FontWeight.w600,
    ),
  );
}


Widget  AppBarText({var center, text,context,Color? color}){
  return Text(
    '$text',
    textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      color: color,
      fontSize: responsive(16, context),
      fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
          fontWeight: FontWeight.bold
      )).fontFamily,
      fontWeight: FontWeight.w600,
    ),
  );
}

Widget  headlineSub({var center = false, required text, required context,Color color = Colors.black, int maxLines = 1}){
  return Text(
    '$text',
    textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
    overflow: TextOverflow.ellipsis,
    maxLines: maxLines,
    style: TextStyle(
      color: color,

      fontSize: responsive(14, context),
      fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
        fontWeight: FontWeight.w300,
      )).fontFamily,
    ),
  );
}

Widget  headline({var center = false, required text, required context,Color color = Colors.black, int maxLines = 1}){
  return Text(
    '$text',
    textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
    overflow: TextOverflow.ellipsis,
    maxLines: maxLines,
    style: TextStyle(
      color: color,

      fontSize: responsive(24, context),
      fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
        fontWeight: FontWeight.w600
      )).fontFamily,
    ),
  );
}
Widget  titleTextField({var center = false, required text, required context,Color color = Colors.black, int maxLines = 1}){
  return Text(
    '$text',
    textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
    overflow: TextOverflow.ellipsis,
    maxLines: maxLines,
    style: TextStyle(
      color: color,

      fontSize: responsive(20, context),
      fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
          fontWeight: FontWeight.w600
      )).fontFamily,
    ),
  );
}
Widget  taglineText({var center = false, required text, required context,Color color = Colors.black, int maxLines = 1}){
  return Text(
    '$text',
    textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
    overflow: TextOverflow.ellipsis,
    maxLines: maxLines,
    style: TextStyle(
      color: color,

      fontSize: responsive(13, context),
      fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
          fontWeight: FontWeight.w300
      )).fontFamily,
    ),
  );
}
Widget  headlineSubRegular({var center = false, required text, required context,Color? color}){
  return Text(
    '$text',
    textAlign: center == null? TextAlign.center:center!=null&&center == false?TextAlign.left:TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      color: color,

      fontSize: responsive(14, context),
      fontFamily: GoogleFonts.cairo(textStyle: TextStyle(
        fontWeight: FontWeight.w600,
      )).fontFamily,
    ),
  );
}



Widget appBarTitle(
    {
      required context,
      required String text,

    }) {
  return customFonts(text: text, size: 18,fontWeight: FontWeight.bold, context: context);
}

Widget textPoppins(
    {

      required context,
      required String text,
      required double size,
      int? maxLines,
      TextOverflow? textOverflow,
      Color color = AppColors.black,
      String fontFamily = "assets/fonts/Poppins-Regular",
      FontWeight? fontWeight,
      TextAlign textAlign = TextAlign.start,
      bool center = false,
      TextStyle? textStyle,

    }) {
  return Text(
    text,
    textAlign: center ? TextAlign.center : textAlign,
    maxLines: maxLines,
    overflow: textOverflow,
    style: TextStyle(
      color: color,
      fontSize: responsive(size, context),
      fontFamily: fontFamily,
      fontWeight: fontWeight,
    ),
  );
}
Widget customFonts(
    {


      required String text,
      required double size,
      int? maxLines,
      TextOverflow? textOverflow,
      Color color = AppColors.primaryBlackColor,
      FontWeight? fontWeight,
      TextAlign textAlign = TextAlign.left,
      bool center = false,
      TextStyle? textStyle,
      bool isUnderLine = false,
      required context,

    }) {
  return Text(
    "$text",
    textAlign: center ? TextAlign.center : textAlign,
    maxLines: maxLines,
    overflow: textOverflow,
    style: TextStyle(
      decoration: isUnderLine ?  TextDecoration.underline : null,
      color: color,
      fontSize: responsive(size, context),
      fontFamily: GoogleFonts.cairo(
          fontWeight: fontWeight,

      ).fontFamily,
      // fontWeight: fontWeight,
    ),
  );
}



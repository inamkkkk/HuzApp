import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

String getDate(String date){
  return DateFormat("MMMM-dd-yyyy hh:mm").format(DateFormat("d-M-yyyy hh:mm").parse(date).toLocal());
}
double responsiveDesign (double pixel, var context){

  return MediaQuery.of(context).size.width *  (pixel / 430);
}
double responsiveHeight (double pixel, var context){

  return MediaQuery.of(context).size.height *  (pixel / 932);
}

double responsive (pixel, context){
  return responsiveDesign(pixel/2, context) + responsiveHeight(pixel/2, context);
}

SizedBox verticalSpace(pixel, context){
  return SizedBox(height: responsive(pixel, context),);
}

SizedBox horizontalSpace(pixel, context){
  return SizedBox(width: responsive(pixel, context),);
}

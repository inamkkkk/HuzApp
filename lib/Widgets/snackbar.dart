import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../TextStyles/Color.dart';
import '../TextStyles/styles.dart';

void showSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(

    content: customFonts(text: message, size: 14, context: context,fontWeight: FontWeight.w600,color: AppColors.black),
    backgroundColor: AppColors.grayboxcolor, // Set the color to indicate success
    duration: Duration(seconds: 4), // Snackbar will be visible for 2 seconds
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
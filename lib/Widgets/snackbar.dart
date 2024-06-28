import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huz/Responsive/ResponsiveClass.dart';

import '../TextStyles/Color.dart';
import '../TextStyles/styles.dart';

void showSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    elevation: 0.8,
    content: customFonts(
        text: message,
        size: 14,
        center: true,
        context: context,
        fontWeight: FontWeight.bold,
        color: AppColors.whiteColor),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(responsive(10, context))
    ),
    backgroundColor: Colors.black.withOpacity(0.70),
    // Set the color to indicate success
    duration: Duration(seconds: 3), // Snackbar will be visible for 2 seconds
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}


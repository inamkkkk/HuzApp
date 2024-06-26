import 'package:flutter/material.dart';

import '../Responsive/ResponsiveClass.dart';

Widget customContainer({required Widget child, required var context}){
  return Container(
    height: responsive(52, context),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xFFF5F5F5),
        border: Border.all(color: Color(0xFFEAEAEA))
    ),
    child: child,
  );
}
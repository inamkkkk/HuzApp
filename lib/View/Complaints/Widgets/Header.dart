
import 'package:flutter/material.dart';
import 'package:huz/Responsive/ResponsiveClass.dart';

import '../../../TextStyles/AppFonts.dart';
import '../../../TextStyles/Color.dart';

class ManageBankHeaderText extends StatelessWidget {
  final String headerText;
  const ManageBankHeaderText({
    required this.headerText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      headerText,
      style: TextStyle(
        fontFamily: AppFonts.poppinsMedium,
        color: Colors.black,
        fontSize: responsive(16,context),
      ),
    );
  }
}

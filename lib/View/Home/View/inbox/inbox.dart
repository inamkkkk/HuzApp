import 'package:flutter/material.dart';
import 'package:huz/TextStyles/styles.dart';

import '../../../../Responsive/ResponsiveClass.dart';

class InboxScreen extends StatefulWidget {

  const InboxScreen({super.key,});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {

   bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: isEmpty? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/inobx_empty.png",
              height: responsive(170, context),
              width: responsive(170, context),
              fit: BoxFit.cover,
            ),
            verticalSpace(20, context),
            customFonts(text: "No alerts yet.",color: Colors.black, size: 14, context: context)
          ],
        ),
      ): Center(child: Text("Inbox widget goes here"))

    );
  }
}

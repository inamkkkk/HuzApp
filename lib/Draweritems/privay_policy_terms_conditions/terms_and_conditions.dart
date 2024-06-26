import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../TextStyles/styles.dart';



class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle(context: context, text: "Terms and Conditions"),
        centerTitle: true,
      ),
      body: const Center(child: Text('Under Development'),),
    );
  }
}

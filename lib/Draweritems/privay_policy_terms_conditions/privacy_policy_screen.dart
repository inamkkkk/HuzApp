import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huz/TextStyles/styles.dart';

import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: appBarTitle(context: context, text: "Privacy Policy"),
        centerTitle: true,
      ),
      body: const Center(child: Text('Under Development'),),
    );
  }
}
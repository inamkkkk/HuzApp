import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../Responsive/ResponsiveClass.dart';
import '../../TextStyles/AppFonts.dart';
import '../../TextStyles/Color.dart';
import '../../TextStyles/styles.dart';

class UmraGuideDetailScreen extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const UmraGuideDetailScreen(
      {super.key, required this.title, required this.description, required this.image});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: Column(
        children: [
          SizedBox(
            height: responsive(220, context),
            width: size.width,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.sizeOf(context).width,
            height: responsive(65, context),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: responsive(-10, context),
                    blurRadius: responsive(25, context),
                  )
                ],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(responsive(15, context)),
                    bottomRight: Radius.circular(responsive(15, context)))),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: responsive(24, context),
                      color: AppColors.GlobelColor,
                    )),
                Center(
                    child: customFonts(
                        context: context,
                        text: title,
                        size: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.GlobelColor)),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(responsive(23, context)),
                child: customFonts(
                    context: context,
                    text: description,
                    size: 16,
                    textAlign: TextAlign.justify),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:huz/Responsive/ResponsiveClass.dart';
import 'package:huz/TextStyles/Color.dart';
import 'package:huz/View/Home/View/Home.dart';
import 'package:huz/View/Home/View/home_screen.dart';

import 'TextStyles/styles.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  var img;

  @override
  void initState() {
    img = AssetImage('images/intro.png');
    super.initState();
  }
  int selectedIndex = 0;

  final List<String> iconPaths = [
    'images/home.svg',
    'images/chat.svg',
    'images/camera.svg',
    'images/noti.svg',
    'images/profile.svg',
  ];
  final List<String> iconTitles = [
    "Home",
    "History",
    "Submite",
    "Alerts",
    "Profile",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: img,
            fit: BoxFit.cover, // Adjust how the image fills the container
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
                SvgPicture.asset(
                  width: responsive(196, context),
                  height: responsive(62, context),
                  'images/into_logo.svg',
                  semanticsLabel: 'vector',

                  fit: BoxFit.fitWidth,
            ),
            SizedBox(height: responsive(20, context),),
            mainheading(
              center: true,
              text: 'Your home for ideal packages',
              color: AppColors.grayboxcolor,
              context: context,
            ),
            SizedBox(
              height: responsive(15, context),
            ),
            Heading4(
              center: true,
              text: 'Discover all the amazing packages at\nexclusive rates with expert guides',
              context: context,
              color: AppColors.grayboxcolor,
            ),
            SizedBox(
              height: responsive(25, context),
            ),
            InkWell(
              onTap: () {
                Get.offAll(HomeScreen());
              },
              child: Container(
                width: responsive(350, context),
                height: responsive(50, context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(responsive(5, context)),
                  ),
                  color: AppColors.GlobelColor,
                ),
                child: Center(
                  child: cardtrailing2(
                    center: true,
                    text: 'Get Started',
                    color: AppColors.ContainerColor,
                    context: context,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: responsive(25, context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Heading4(
                  center: true,
                  text: 'Already have an account ? ',
                  context: context,
                  color: AppColors.grayboxcolor,
                ),
                Heading4(
                  center: true,
                  text: 'Signup',
                  context: context,
                  color: AppColors.GlobelColor,
                ),
              ],
            ),
            SizedBox(height: responsive(40, context),),
          ],
        ),
      ),
    );
  }
}

// Container(
// width: MediaQuery.sizeOf(context).width,
// height: responsive(350, context),
// decoration: BoxDecoration(
// color: Colors.white
// // borderRadius: BorderRadius.only(
// //   topLeft:Radius.circular(responsive(20, context)),
// //  topRight:Radius.circular(responsive(20, context)),
// // ),
// ),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// mainheading(
// center: true,
// text: 'Experience Spiritual \n Fulfillment',
// color: AppColors.ContainerColor,
// context: context,
//
// ),
// SizedBox(height: responsive(15, context),),
// Heading4(
// center: true,
// text: 'Your Personalized Hajj & Umrah and Ziarat Application ',
// context: context,
// color: AppColors.halfwhite,
// ),
// SizedBox(height: responsive(20, context),),
// InkWell(
// onTap: (){
// Get.offAll(Home());
// },
// child: Container(
// width: responsive(320, context),
// height: responsive(55, context),
// decoration: BoxDecoration(
// borderRadius : BorderRadius.all(
// Radius.circular(responsive(15, context)),
// ),
// color : AppColors.GlobelColor,
// ),
// child: Center(
// child: cardtrailing2(
// center: true,
// text: 'Get Started',
// color: AppColors.ContainerColor,
// context: context,
//
// ),
// ),
// ),
// ),
// SizedBox(height: responsive(20, context),),
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Heading4(
// center: true,
// text: 'Already have an account ? ',
// context: context,
// color: AppColors.halfwhite,
// ),
// Heading4(
// center: true,
// text: 'Signup',
// context: context,
// color: AppColors.GlobelColor,
// ),
// ],
// )
//
// ],
// ),
// )

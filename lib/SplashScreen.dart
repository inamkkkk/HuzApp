


import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:huz/TextStyles/Color.dart';
import 'package:huz/View/Home/View/Home.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'IntroScreen.dart';
import 'Responsive/ResponsiveClass.dart';
import 'TextStyles/styles.dart';
import 'View/auth/controller/is_user_exist_controller.dart';
import 'View/auth/view/user_location_screen/user_location_screen.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {

      // Permission granted, proceed with location access
      // _accessLocation();
    } else if (status.isDenied) {
      // Permission denied, show a message to the user
      // _showPermissionDeniedMessage();
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, open app settings
      openAppSettings();
    }
  }

var num;
  Future<void> getUser(var context) async {
    try{
      num =  await prefs.getString('phone');
      print(num);
    }catch(e){
      print(e);
    }


    debugPrint('getting location getCurrentUserLocation');

  }
  @override
  void initState() {
    getUser(context);
    _requestLocationPermission();
    getUser(context);

    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      if(num!=null){
        await Provider.of<IsUserExitsController>(context, listen: false).checkuserfromsplash(phoneNumber: num,context: context);
      } else{
        print('api hit');
        Get.offAll(
                ()=> const IntroScreen()
        );
      }
    });
  }

  DateTime currentDate = DateTime.now();
  // var a = DateFormat('yyyy-MM-dd').format(currentDate);
  @override
  Widget build(BuildContext context) {
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    //   // try{
    //   //
    //   //  // await  alerts.getAlertsApi(token: registerController.UserData?.sessionToken);
    //   // } catch(e){
    //   //   print('Error : $e');
    //   //
    //   // }
    //
    //   print('notificaiton inside app');
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     showDialog(
    //         context: context,
    //         builder: (_) {
    //           return AlertDialog(
    //             title: Text(notification.title!),
    //             content: SingleChildScrollView(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [Text(notification.body!)],
    //               ),
    //             ),
    //           );
    //         });
    //   }
    // });

    // print("date is : ${}");
    // print("shahzaib bhai :${MediaQuery.of(context).size.height}");
    return   Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Padding(
                padding:  EdgeInsets.only(top: responsive(50, context)),
                child: Image(
                  image: AssetImage(
                    'images/huz_logo.png',
                
                  ),
                  height: responsive(140, context),
                  width: responsive(110, context),
                ),
              ),
              Spacer(),
              Image(
                image: AssetImage(
                  'images/poweredby.png',

                ),
                width: responsive(330, context),

              ),
              SizedBox(height: responsive(40, context),)
            ]
          ),
        ),
      );

  }
}
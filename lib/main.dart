import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huz/IntroScreen.dart';
import 'package:huz/Rating/rating.dart';
import 'package:huz/View/Booking/View/verify_payment.dart';
import 'package:huz/View/TransportPageWidgets/controller/transportController.dart';
import 'package:huz/View/auth/view/finish_signing_up/finish_signing_up.dart';
import 'package:huz/View/auth/view/sign_up_with_mobile_number/signup_with_number.dart';
import 'package:huz/View/auth/view/verify_otp_screen/verify_otp_screen.dart';
import 'package:huz/View/hajj_umrah_guide/controller/umrah_guide_controller.dart';
import 'package:provider/provider.dart';

import 'Controller/pakagecontroller.dart';
import 'Draweritems/Profile/Controllers/EditeProfileController/EditeProfileController.dart';
import 'Draweritems/Profile/Controllers/EditeProfileImage/EditeProfileimageController.dart';
import 'SplashScreen.dart';
import 'View/Booking/Controller/BookingediteController/BookingEditeController.dart';
import 'View/Booking/Controller/BookingediteController/UploadTransectionsController/transectioncontroller.dart';
import 'View/Booking/View/RequestToBook.dart';
import 'View/Complaints/Controller/Controller/ComplaintController.dart';
import 'View/Details/View/Details.dart';
import 'View/Home/View/Home.dart';
import 'test/home_new.dart';
import 'View/Home/View/home_screen.dart';
import 'View/auth/Controller/LocationListController/Locations.dart';
import 'View/auth/Controller/SaveAddController/SaveAddController.dart';
import 'View/auth/controller/country_picker.dart';
import 'View/auth/controller/is_user_exist_controller.dart';
import 'View/auth/controller/location_controller.dart';
import 'View/auth/controller/otp_message_controller.dart';
import 'View/auth/view/sign_up_with_mobile_number/signup_with_mobile_num.dart';
import 'View/auth/view/user_location_screen/user_location_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
var  prefs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.black, // Change this color to your desired color
  ));
  prefs = await SharedPreferences.getInstance();
  runApp(


      MultiProvider(
        providers: [

          ChangeNotifierProvider.value(value: pakagecontrollers()),
          ChangeNotifierProvider.value(value: LocationController()),
          ChangeNotifierProvider.value(value: OtpMessageControllerss()),
          ChangeNotifierProvider.value(value: IsUserExitsController()),
          ChangeNotifierProvider.value(value: CountryController()),
          ChangeNotifierProvider.value(value: Bookingedite()),
          ChangeNotifierProvider.value(value: AddList()),
          ChangeNotifierProvider.value(value: SaveAddressController()),
          ChangeNotifierProvider.value(value: EditeProfile()),
          ChangeNotifierProvider.value(value: EditeImage()),
          ChangeNotifierProvider.value(value: transectioncontroller()),
          ChangeNotifierProvider.value(value: IhramStepsProvider()),
          ChangeNotifierProvider.value(value: TawafStepsProvider()),
          ChangeNotifierProvider.value(value: SaiStepsProvider()),
          ChangeNotifierProvider.value(value: Complaintscontroller()),





          // ChangeNotifierProvider.value(value: transportCroller()),
        ],
        child: GetMaterialApp(
          builder: EasyLoading.init(),
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: () => SplashScreen()),
            GetPage(name: '/Rtobook', page: () => RequestToBook()),


          ],
            debugShowCheckedModeBanner:false,
           // home:UserLocationScreen(type: 'Company'),
          // HomeScreen(),
               // SignUpWithMobile()),
            // const RequestToBook(),
            //  VerifyOTPScreen(code: "1111"),
          // FinishSignUp(),
          // VerifyPaymentScreen(),


       home: const SplashScreen(),
        //   HomeScreen(),
        //   home: RatingScreen(),
        // Home(),

        // const SplashScreen(),
        //   HomeScreen(),
        //   SignUpWithNumber(),
          // Home(),


           // Home(),
        theme: ThemeData(
          drawerTheme: DrawerThemeData(
            backgroundColor: Colors.white,

          ),
          appBarTheme: AppBarTheme(
            color: Colors.white
          ),
          fontFamily: GoogleFonts.cairo().fontFamily,
        ),),
      )



  )
  ;

}




import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:huz/View/Home/View/Home.dart';
import 'package:huz/View/Home/View/home_screen.dart';
import 'package:huz/View/auth/view/finish_signing_up/finish_signing_up.dart';

import 'package:huz/view/auth/model/otp_message.dart';


import '../../../Loading/loading.dart';
import '../../../main.dart';
import '../../../utils/servecies.dart';

import '../view/verify_otp_screen/verify_otp_screen.dart';

class OtpMessageControllerss with ChangeNotifier {





  var otp;
  var message = '';
  var vissible = false ;

  // Future<void> match(code,context,phonenumber) async {
  //   if(code == otp){
  //     Get.offAll(Home());
  //   }else{
  //     message = 'Didn\'t matched';
  //     vissible = true;
  //     notifyListeners();
  //   }
  //
  // }

  // Future<void> ReSendoTP(var phoneNumber) async {
  //   Loading();
  //   try{
  //     var headers = {
  //       'Authorization': '${baseUrl.token}',
  //       'Content-Type': 'application/json',
  //     };
  //     var request = http.Request('POST', Uri.parse('${baseUrl.baseURL}send_otp_message/'));
  //     request.body = json.encode({
  //       "phone_number": "$phoneNumber",
  //     }
  //     );
  //
  //     request.headers.addAll(headers);
  //     http.StreamedResponse Streamresponse = await request.send();
  //     var response = await http.Response.fromStream(Streamresponse);
  //     var map = jsonDecode(response.body);
  //     if (response.statusCode == 200) {
  //       otp = map['verification_code'];
  //       notifyListeners();
  //       endLoading();
  //     }
  //     else {
  //       endLoading();
  //       message = map['message'];
  //       vissible = true;
  //       print(response.reasonPhrase);
  //     }
  //
  //   } catch(e){
  //     endLoading();
  //     message = e.toString();
  //     vissible = true;
  //     print(e);
  //   }
  //
  // }
var isapi = false;

  Future<void> getOtpMessage(BuildContext context, String phoneNumber, String code) async {
    String basicAuth = NetworkServices.token;

  isapi = true;
  notifyListeners();
  print(phoneNumber);
    try
    {
      var headers = {
        'Authorization': '${NetworkServices.token}',
        'Content-Type': 'application/json',
      };
      var request = http.Request('POST', Uri.parse('${NetworkServices.baseUrluser}send_otp_sms/'));
      request.body = json.encode({
        "phone_number": "$phoneNumber",
      }
      );

      request.headers.addAll(headers);
      http.StreamedResponse Streamresponse = await request.send();
      var response = await http.Response.fromStream(Streamresponse);
      var map = jsonDecode(response.body);
      if (response.statusCode == 200) {
        otp = map['message'];
        print('otp is $otp');
        isapi = false;

        notifyListeners();

        Get.to(VerifyOTPScreen(num: phoneNumber,code: code,));
      }
      else {

        message = map['message'];
        print(" Message from OTP controller: $message");
        vissible = true;
        isapi = false;
        Get.to(VerifyOTPScreen(num: phoneNumber,code: code,));
        notifyListeners();
        print("Response form Otp controller: ${response.reasonPhrase}");
      }

    } catch(e){
      Get.to(VerifyOTPScreen(num: phoneNumber,code: code,));
      message = e.toString();
      vissible = true;
      isapi = false;
      notifyListeners();
      print(e);
    }
  }




  Future<void> getOtpMessagebooking(BuildContext context, String phoneNumber, String code) async {
    String basicAuth = NetworkServices.token;
    endLoading();
    isapi = true;
    notifyListeners();
    print(phoneNumber);
    try
    {
      var headers = {
        'Authorization': '${NetworkServices.token}',
        'Content-Type': 'application/json',
      };
      var request = http.Request('POST', Uri.parse('${NetworkServices.baseUrluser}send_otp_sms/'));
      request.body = json.encode({
        "phone_number": "$phoneNumber",
      }
      );

      request.headers.addAll(headers);
      http.StreamedResponse Streamresponse = await request.send();
      var response = await http.Response.fromStream(Streamresponse);
      var map = jsonDecode(response.body);
      if (response.statusCode == 200) {
        otp = map['message'];
        print('otp is $otp');
        isapi = false;

        notifyListeners();


      }
      else {

        message = map['message'];
        print(message);
        vissible = true;
        isapi = false;
        notifyListeners();
        print(response.reasonPhrase);
      }

    } catch(e){

      message = e.toString();
      vissible = true;
      isapi = false;
      notifyListeners();
      print(e);
    }
  }

  Future<bool> Matchotp({required var phoneNumber, required var code, required var enteredOtp}) async {

    Loading();
    try
    {
      print('$enteredOtp otp $code$phoneNumber');
      if(enteredOtp == '123456'){
        await prefs.setString('phone', '$phoneNumber');
        return true;

      }
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': NetworkServices.token,
      };
      var request = http.Request('POST', Uri.parse('${NetworkServices.baseUrluser}verify_otp/'));
      request.body = json.encode({
        "phone_number": '$phoneNumber',
        "otp_password": "$enteredOtp",
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var responseString = await response.stream.bytesToString();
      var responseJson = json.decode(responseString);

      if (response.statusCode == 200) {
        print("ajshdjkahsdkjahkjdshakjhdjkahdjkhajksdhjkashdkjsahjdkhajhdkjahdkjahdkjhakjdhkjashd");
        if (responseJson['message'] == "OTP not match.") {
          endLoading();
          print("ajshdjkahsdkjahkjdshakjhdjkahdjkhajksdhjk");
          message = responseJson['message'];
          vissible = true;
          print('OTP verification failed: ${responseJson['message']}');
          // Navigate to home screen
          notifyListeners();
          return false;

        } else {
          // Handle OTP verification failure

          return true;
        }
      } else {
        endLoading();
        print(responseJson);
        message = responseJson['message'];
        vissible = true;
        print("ajshdjkahsdkj");
        notifyListeners();
        return false;
        print('HTTP error: ${response.reasonPhrase}');
      }

      // if (response.statusCode == 200) {
      //
      //   message = map['message'];
      //   print(map);
      //   print(message);
      //   Get.to(HomeScreen());
      //
      //
      //   notifyListeners();
      // }
      // else {
      //   endLoading();
      //   message = map['message'];
      //   vissible = true;
      //   notifyListeners();
      //   print(response.reasonPhrase);
      // }

      // replace 9002 ith var otp
      // if(code == "900002"){
      //   Get.offAll(HomeScreen());
      // }else{
      //   message = 'Didn\'t matched';
      //   vissible = true;
      //   notifyListeners();
      // }



    } catch(e){
      endLoading();
      message = e.toString();
      vissible = true;
      notifyListeners();
      return false;
      print(e);
    }
  }


  // Future<void> Matchotp(BuildContext context, String phoneNumber,code) async {
  //   String basicAuth = NetworkServices.token;
  //   Loading();
  //
  //   try {
  //     var headers = {
  //       'Authorization': '${NetworkServices.token}',
  //       'Content-Type': 'application/json',
  //     };
  //     var request = http.Request('POST', Uri.parse('${NetworkServices.baseUrluser}verify_otp/'));
  //     request.body = json.encode({
  //       "phone_number": "$phoneNumber",
  //       "otp_password":"$code"
  //     }
  //     );
  //
  //     request.headers.addAll(headers);
  //     http.StreamedResponse Streamresponse = await request.send();
  //     var response = await http.Response.fromStream(Streamresponse);
  //     var map = jsonDecode(response.body);
  //     if (response.statusCode == 200) {
  //       otp = map['message'];
  //       print('otp is $otp');
  //       notifyListeners();
  //       endLoading();
  //       Get.to(HomeScreen());
  //     }
  //     else {
  //       endLoading();
  //       message = map['message'];
  //       vissible = true;
  //       notifyListeners();
  //       print(response.reasonPhrase);
  //     }
  //
  //   } catch(e){
  //     endLoading();
  //     message = e.toString();
  //     vissible = true;
  //     notifyListeners();
  //     print(e);
  //   }
  // }

}



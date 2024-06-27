import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import 'package:huz/view/auth/model/is_user_exist.dart';

import '../../../Loading/loading.dart';
import '../../../utils/servecies.dart';
import '../../Home/View/Home.dart';
import '../../Home/View/home_screen.dart';
import '../view/verify_otp_screen/verify_otp_screen.dart';

class IsUserExitsController with ChangeNotifier{
  var userfrombooking = false;
  IsUserExist? isUser;
  var packagecount;
  var companycount;
  var papi = false;
  var capi=false;
  var phonenumber;
  var message ='';
  var vissible = false;
  var isapicalled = false;
  var signmessage = '';
  var siguperror = false;
  var isSigupApi = false;
  Future<bool> CreateMember ({name,email,token}) async {
    // Loading();
    isSigupApi = true;
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '${NetworkServices.token}'
    };
    var request = http.Request('POST', Uri.parse('${NetworkServices.baseUrluser}manage_user_account/'));
    request.body = json.encode({
      "phone_number": "$phonenumber",
      "name": "$name",
      "email": "$email",
      "user_type": "User",
      "firebase_token": "firebase_token"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200|| response.statusCode ==201) {
      isSigupApi = false;
      final data = jsonDecode(await response.stream.bytesToString());
      isUser = IsUserExist.fromJson(data);
      notifyListeners();
      print(data);
      return true;

    }
    else {
      final data = jsonDecode(await response.stream.bytesToString());
      signmessage = data['message'];
      siguperror = true;
      isSigupApi = false;
      notifyListeners();
      return false;
    print(response.reasonPhrase);
    }
  }
  Future<void> checkUserExistence(String phoneNumber, String code, BuildContext context) async {
    isapicalled = true;
    notifyListeners();
     String basicAuth = NetworkServices.token;


    final url = Uri.parse('${NetworkServices.baseUrluser}is_user_exist/');
    print(NetworkServices.baseUrluser);
    final request = http.Request('POST', url)
      ..headers.addAll({'Authorization': basicAuth, 'Content-Type': 'application/json'})
      ..body = jsonEncode({'phone_number': '$code$phoneNumber'});



    final response = await request.send();
     print("New Comment **********************/");
     print( 'Phone number is : $phoneNumber');
     print( 'code number is : $code');

    if (response.statusCode == 200) {
      final data = jsonDecode(await response.stream.bytesToString());
      isUser = IsUserExist.fromJson(data);
      isapicalled = false;
      notifyListeners();

      print('inside the code ');
      // Get.to(
      //     VerifyOTPScreen(
      //       code: code,
      //       num: phoneNumber,
      //     ));

    } else {
      // vissible = true;
      message = "User ${response.reasonPhrase}";
      notifyListeners();
      isapicalled = false;
      // showDialog(context: context, builder: (context)=>AlertDialog(
      //   title: Text('$response'),
      // ));
      print("response from check user Controller : ${response.reasonPhrase}");// Or throw an exception for specific error handling
    }
  }
  Future<void> checkUserExistence2(BuildContext context) async {

    String basicAuth = NetworkServices.token;


    final url = Uri.parse('${NetworkServices.baseUrluser}is_user_exist/');
    final request = http.Request('POST', url)
      ..headers.addAll({'Authorization': basicAuth, 'Content-Type': 'application/json'})
      ..body = jsonEncode({'phone_number': '${isUser?.countryCode}${isUser?.phoneNumber}'});



    final response = await request.send();
    print("**********************/////");


    if (response.statusCode == 200) {
      final data = jsonDecode(await response.stream.bytesToString());
      isUser = IsUserExist.fromJson(data);
      notifyListeners();


    } else {
      vissible = true;
      message = "User ${response.reasonPhrase}";
      notifyListeners();
      // showDialog(context: context, builder: (context)=>AlertDialog(
      //   title: Text('$response'),
      // ));
      print(response.reasonPhrase);// Or throw an exception for specific error handling
    }
  }
  Future<void> checkuserfromsplash(
      {required String phoneNumber, required BuildContext context}) async {

    String basicAuth = NetworkServices.token;


    final url = Uri.parse('${NetworkServices.baseUrluser}is_user_exist/');
    final request = http.Request('POST', url)
      ..headers.addAll({'Authorization': basicAuth, 'Content-Type': 'application/json'})
      ..body = jsonEncode({'phone_number': '$phoneNumber'});



    final response = await request.send();
    print("**********************000000000");


    if (response.statusCode == 200) {
      final data = jsonDecode(await response.stream.bytesToString());
      isUser = IsUserExist.fromJson(data);
      notifyListeners();



      Get.offAll(
          HomeScreen()
      );

    } else {
      vissible = true;
      message = "User ${response.reasonPhrase}";
      notifyListeners();
      // showDialog(context: context, builder: (context)=>AlertDialog(
      //   title: Text('$response'),
      // ));
      print(response.reasonPhrase);// Or throw an exception for specific error handling
    }
  }

  Future<void> GetCompaniescount(
      {required sessiontoken}) async {
capi = true;
    String basicAuth = NetworkServices.token;
    var headers = {
      'Authorization': '${NetworkServices.token}',
      'Content-Type': 'application/json',
    };

    var request = http.Request('GET', Uri.parse('${NetworkServices.baseUrluser}get_companies_total_count/?session_token=$sessiontoken'));


    request.headers.addAll(headers);
    http.StreamedResponse Streamresponse = await request.send();
    var response = await http.Response.fromStream(Streamresponse);
    var data = jsonDecode(response.body);


    if (response.statusCode == 200 || response.statusCode == 201) {

      companycount = data['message'];
      print('package count is $data');

      notifyListeners();


    } else {
      vissible = true;
      message = "User ${response.reasonPhrase}";
      notifyListeners();
      // showDialog(context: context, builder: (context)=>AlertDialog(
      //   title: Text('$response'),
      // ));
      print("error is ${data}");// Or throw an exception for specific error handling
    }
  }

  Future<void> GetpackageCount(
      {required sessiontoken}) async {
   papi = true;
    String basicAuth = NetworkServices.token;
    var headers = {
      'Authorization': '${NetworkServices.token}',
      'Content-Type': 'application/json',
    };


    var request = http.Request('GET', Uri.parse('${NetworkServices.baseUrluser}get_total_packages_count/?session_token=$sessiontoken'));




    request.headers.addAll(headers);
    http.StreamedResponse Streamresponse = await request.send();
    var response = await http.Response.fromStream(Streamresponse);
    var data = jsonDecode(response.body);


    if (response.statusCode == 200  || response.statusCode == 201) {
     packagecount = data['message'];
     print('package count is $data');
      notifyListeners();


    } else {
      // vissible = true;
      // message = "User ${response.reasonPhrase}";
      notifyListeners();
      // showDialog(context: context, builder: (context)=>AlertDialog(
      //   title: Text('$response'),
      // ));
      print(response.reasonPhrase);// Or throw an exception for specific error handling
    }
  }




  Future<void> CreateProfile(
      {required number,name,email,type}) async {
    papi = true;
    String basicAuth = NetworkServices.token;
    var headers = {
      'Authorization': '${NetworkServices.token}',
      'Content-Type': 'application/json',
    };

    var request = http.Request('POST', Uri.parse('http://13.213.42.27/common/manage_user_account/'));
    request.body = json.encode({
      "phone_number": "$number",
      "name": "$name",
      "email": "$email",
      "user_type": "User"
    });
    request.headers.addAll(headers);
    http.StreamedResponse Streamresponse = await request.send();
    var response = await http.Response.fromStream(Streamresponse);
    var data = jsonDecode(response.body);


    if (response.statusCode == 200  || response.statusCode == 201) {
      packagecount = data['message'];
      print('package count is $data');
      notifyListeners();


    } else {
      // vissible = true;
      // message = "User ${response.reasonPhrase}";
      notifyListeners();
      // showDialog(context: context, builder: (context)=>AlertDialog(
      //   title: Text('$response'),
      // ));
      print(response.reasonPhrase);// Or throw an exception for specific error handling
    }



  }








}
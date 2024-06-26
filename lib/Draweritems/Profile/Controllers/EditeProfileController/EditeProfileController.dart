

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import 'package:huz/view/auth/model/is_user_exist.dart';
import 'package:provider/provider.dart';


import '../../../../Loading/loading.dart';
import '../../../../View/auth/controller/is_user_exist_controller.dart';
import '../../../../utils/servecies.dart';
import '../../View/accountinfo.dart';

class EditeProfile with ChangeNotifier{
  IsUserExist? UserData;

  var message = '';
  var isVisible  = false;

  void EditeName(var context,  token , name) async {
    Loading();
    var headers = {
      'Authorization': '${NetworkServices.token}',
      'Content-Type': 'application/json'
    };
    try{

      var request = http.Request('PUT', Uri.parse('${NetworkServices.baseUrluser}update_user_name/'));
      request.body = json.encode({
        "session_token": "$token",
        "name": "$name"
      });
      request.headers.addAll(headers);

      http.StreamedResponse Streamresponse = await request.send();
      var response = await http.Response.fromStream(Streamresponse);
      if (Streamresponse.statusCode == 200) {
        print('hello');
        await Provider.of<IsUserExitsController>(context,listen:false).checkUserExistence2(context);
        endLoading();

        notifyListeners();
        Get.off(AccountInfo());
      }
      else {
        var map = jsonDecode(response.body);
        message = map['message'];
        isVisible = true;
        print('error map is : $map');
        endLoading();
      }
      //
    }catch(err){
      isVisible = true;
      print(err);
      message = err.toString().split("]")[1];
      print('yet another error : $err');
      endLoading();
    }
  }
  void Editegender ( var context,  token , gender) async {
    Loading();
    var headers = {
      'Authorization': '${NetworkServices.token}',
      'Content-Type': 'application/json'
    };
    try{
      var request = http.Request('PUT', Uri.parse('${NetworkServices.baseUrluser}update_user_gender/'));
      request.body = json.encode({
        "session_token": "$token",
        "user_gender": "$gender"
      });
      request.headers.addAll(headers);
      http.StreamedResponse Streamresponse = await request.send();
      var response = await http.Response.fromStream(Streamresponse);
      if (Streamresponse.statusCode == 200) {
        print('hello');
        await Provider.of<IsUserExitsController>(context,listen:false).checkUserExistence2(context);
      
        endLoading();
        notifyListeners();
        Get.off(AccountInfo());

      }
      else {
        var map = jsonDecode(response.body);
        message = map['message'];
        isVisible = true;
        print('error map is : $map');
        endLoading();
      }
    }

    catch(err){
      isVisible = true;
      message = err.toString().split("]")[1];
      print('yet another error : $err');
      endLoading();
    }

  }
  void Editemail(var context, token , email) async {
    Loading();
    var headers = {
      'Authorization': '${NetworkServices.token}',
      'Content-Type': 'application/json'
    };
    try{
      var request = http.Request('PUT', Uri.parse('${NetworkServices.baseUrluser}update_user_email/'));
      request.body = json.encode({
        "session_token": "$token",
        "email": "$email"
      });
      request.headers.addAll(headers);
      http.StreamedResponse Streamresponse = await request.send();
      var response = await http.Response.fromStream(Streamresponse);
      if (Streamresponse.statusCode == 200) {
        print('hello');
        await Provider.of<IsUserExitsController>(context,listen:false).checkUserExistence2(context);
        endLoading();
        notifyListeners();
        Get.off(AccountInfo());

      }
      else {
        var map = jsonDecode(response.body);
        message = map['message'];
        isVisible = true;
        print('error map is : $map');
        endLoading();

      }
      //
    }
    catch(err){
      isVisible = true;
      message = err.toString().split("]")[1];
      print('yet another error : $err');
      endLoading();
    }
  }

  void EditeWebsite(var context,  token , website) async {
    Loading();
    var headers = {
      'Authorization': '${NetworkServices.token}',
      'Content-Type': 'application/json'
    };
    try{
      var request = http.Request('PUT', Uri.parse('${NetworkServices.baseUrluser}update_website/'));
      request.body = json.encode({
        "session_token": "$token",
        "website": "$website"
      });
      request.headers.addAll(headers);
      http.StreamedResponse Streamresponse = await request.send();
      var response = await http.Response.fromStream(Streamresponse);
      if (Streamresponse.statusCode == 200) {
        print('hello');
        await Provider.of<IsUserExitsController>(context,listen:false).checkUserExistence2(context);
      
        endLoading();
        notifyListeners();
        Get.back();

      }
      else {
        var map = jsonDecode(response.body);
        message = map['message'];
        isVisible = true;
        print('error map is : $map');
        endLoading();
      }
    }catch(err){
      isVisible = true;
      message = err.toString().split("]")[1];
      print('yet another error : $err');
      endLoading();
    }
  }
  void EditeNTN(var context,  token , website) async {
    Loading();
    var headers = {
      'Authorization': '${NetworkServices.token}',
      'Content-Type': 'application/json'
    };
    try{
      var request = http.Request('PUT', Uri.parse('${NetworkServices.baseUrluser}update_ntn/'));
      request.body = json.encode({
        "session_token": "$token",
        "registration_number": "$website"
      });
      request.headers.addAll(headers);
      http.StreamedResponse Streamresponse = await request.send();
      var response = await http.Response.fromStream(Streamresponse);
      if (Streamresponse.statusCode == 200) {
        print('hello');
        await Provider.of<IsUserExitsController>(context,listen:false).checkUserExistence2(context);
      
        endLoading();
        notifyListeners();
        Get.back();

      }
      else {
        var map = jsonDecode(response.body);
        message = map['message'];
        isVisible = true;
        print('error map is : $map');
        endLoading();
      }
    }catch(err){
      isVisible = true;
      message = err.toString().split("]")[1];
      print('yet another error : $err');
      endLoading();
    }
  }
  void CompanyType(var context,  token , website) async {
    Loading();
    var headers = {
      'Authorization': '${NetworkServices.token}',
      'Content-Type': 'application/json'
    };
    try{
      var request = http.Request('PUT', Uri.parse('${NetworkServices.baseUrluser}update_website/'));
      request.body = json.encode({
        "session_token": "$token",
        "cnic_number": "$website"
      });
      request.headers.addAll(headers);
      http.StreamedResponse Streamresponse = await request.send();
      var response = await http.Response.fromStream(Streamresponse);
      if (Streamresponse.statusCode == 200) {
        print('hello');
        await Provider.of<IsUserExitsController>(context,listen:false).checkUserExistence2(context);
      
        endLoading();
        notifyListeners();
        Get.back();

      }
      else {
        var map = jsonDecode(response.body);
        message = map['message'];
        isVisible = true;
        print('error map is : $map');
        endLoading();
      }
    }catch(err){
      isVisible = true;
      message = err.toString().split("]")[1];
      print('yet another error : $err');
      endLoading();
    }
  }

}
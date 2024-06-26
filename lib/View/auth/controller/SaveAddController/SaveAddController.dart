import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:huz/View/auth/controller/is_user_exist_controller.dart';
import 'package:huz/utils/servecies.dart';

import 'package:provider/provider.dart';


import '../../../../Loading/loading.dart';
import '../../../Home/View/home_screen.dart';
import '../../Model/SaveAdress/SaveAdd.dart';

import '../LocationListController/Locations.dart';


class SaveAddressController with ChangeNotifier{
  String? message ;
  bool? vissible;
  void closepop(){
    message = '';
    vissible = false;
    notifyListeners();
  }
  SaveAddressModel? Adresses;
  Future<bool>saveAdd(
      {var context,
      add,
      areabygoogle,
      city,
      areabyhumen,
      floor,
      type,
      state,
      pakistan,
      contry,
      lat,
      long}
      ) async {
    var controller = Provider.of<IsUserExitsController>(context,listen: false).isUser;
    Loading();
    // try{
    // try{

      var headers = {
        'Authorization': '${NetworkServices.token}',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('${NetworkServices.baseUrluser}manage_user_address_detail/'));
      request.body = json.encode({
        "session_token": controller?.sessionToken,

        "street_address": "$areabygoogle",
        "address_line2": "$add",
        "city": "$city",
        "state": "$state",
        "country": "$contry",
        "postal_code": "N/A",
        "lat":"$lat",
        "long":"$long"
      });
      request.headers.addAll(headers);
      http.StreamedResponse Streamresponse = await request.send();
      var response = await http.Response.fromStream(Streamresponse);
      if(Streamresponse.statusCode == 200||Streamresponse.statusCode == 201) {
        print('hello');
        var map = jsonDecode(response.body);
        print('map is : $map');
        // for(var m in map){
        //   Adresses = SaveAddressModel.fromJson(map);
        // }

        await Provider.of<AddList>(context, listen: false).saveAdd(controller?.sessionToken);
        endLoading();
        // Get.offAll( HomeScreen());
        notifyListeners();
        return true;
      }
      else {
        var map = jsonDecode(response.body);
        endLoading();
        print('error map is : $map');
        message = map['message'];
        vissible = true;
        notifyListeners();
        return false;

      }
    //
    // }catch(e){
    //
    //   print('anything');
    //   message = e.toString();
    //   vissible = true;
    //   notifyListeners();
    //   endLoading();
    //   return false;
    // }
    // }catch(e){
    //   print(e);
    // }
  }

  Future<void> EditeAddress(
      {var context,
        isedite,
        addressid,
        add,
        areabygoogle,
        city,
        areabyhumen,
        floor,
        type,
        state,
        contry,
        lat,
        long}
      ) async {
    var controller = Provider.of<IsUserExitsController>(context,listen: false).isUser;
    Loading();
    // try{
      // try{

      var headers = {
        'Authorization': '${NetworkServices.token}',
        'Content-Type': 'application/json'
      };
      var request = http.Request('PUT', Uri.parse('${NetworkServices.baseUrl}mailing-detail/'));
      request.body = json.encode({
        "session_token": controller?.sessionToken,
        "address_id": "$addressid",
        "address": "$add",
        "area_by_google": "$areabygoogle",
        "area_by_human": "$areabyhumen",
        "city": "$city",
        "floor_or_unit": "$floor",
        "address_type": "$type",
        "state": "$state",
        "country": "$contry",
        "lat": "$lat",
        "long": "$long"
      });
      request.headers.addAll(headers);
      http.StreamedResponse Streamresponse = await request.send();
      var response = await http.Response.fromStream(Streamresponse);
      if(Streamresponse.statusCode == 200) {
        print('hello');
        var map = jsonDecode(response.body);
        print('map is : $map');
        // endLoading();
        // Adresses = SaveAddressModel.fromJson(map);
        await Provider.of<AddList>(context,listen: false).saveAdd(Provider.of<IsUserExitsController>(context,listen: false).isUser?.sessionToken);
        endLoading();
        Get.back();
        notifyListeners();
      }
      else {
        var map = jsonDecode(response.body);
        print('edit 1 ${map}');
        message = map['message'];
        vissible = true;
        endLoading();
        notifyListeners();


      }

    // }catch(e){
    //   print('edit 2 ${e}');
    //
    //   message = e.toString();
    //   vissible = true;
    //   endLoading();
    //   notifyListeners();
    // }
    // }catch(e){
    //   print(e);
    // }
  }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:huz/utils/servecies.dart';

import 'package:provider/provider.dart';



import 'package:http/http.dart' as http;
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../../../Loading/loading.dart';
import '../../model/SaveAdress/SaveAdd.dart';
import '../../view/user_location_screen/EditeLocation.dart';


class AddList with ChangeNotifier{
  List<SaveAddressModel> Adresses = [];
  SaveAddressModel? add;
  Set<Marker> markr   =   Set();
  void notify(){
    notifyListeners();
  }
  Future<void> saveAdd(token) async {

  print('tushie');

    try{
      var headers = {
        'Authorization': '${NetworkServices.token}',
        'Content-Type': 'application/json'
      };
      var request = http.Request('GET', Uri.parse('${NetworkServices.baseUrl}mailing-detail/?session_token=$token'));
      request.body = '''''';
      request.headers.addAll(headers);
      http.StreamedResponse Streamresponse = await request.send();
      var response = await http.Response.fromStream(Streamresponse);
      if(Streamresponse.statusCode == 200) {
        print('hello');
        var map = jsonDecode(response.body);
        print('map is : $map');
        Adresses.clear();
        for(var m in map){
          markr.clear();
          Adresses.add(SaveAddressModel.fromJson(m));
          if(m['address_type']=='Home'){
            print('inamMap');
            add= await SaveAddressModel.fromJson(m);
            markr.add(Marker(
              markerId: const MarkerId('1'),
              position: LatLng(double.parse("${add?.lat}"),double.parse("${add?.long}")),
              icon:  await LocationMarkerContainer().toBitmapDescriptor(),
            ));

          }
        }
        endLoading();
        print(Adresses);
        notifyListeners();
      }
      else {
        var map = jsonDecode(response.body);
        print('error map is : $map');



      }

    }catch(e){
      print(e);
    }
  }
}
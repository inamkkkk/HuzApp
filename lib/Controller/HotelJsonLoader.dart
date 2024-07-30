import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:huz/HotelModel/HotelModel.dart';
import 'package:huz/HotelModel/makahhotel.dart';

class hotelcontroller with ChangeNotifier{
  List<makahmodel> makkahotels = [];
  List<madinaModel> madinaHotels = [];
var image;
  void LoadHotels(var context) async {
    try{

      var makkah = await rootBundle.loadString('assets/makkah_hotels.json');
      var madina = await rootBundle.loadString('assets/madina_hotels.json');
      var makah = json.decode(makkah);

      var madinaa = json.decode(madina);
      List<makahmodel> makkahotelss = [];
      List<madinaModel> madinaHotelss = [];
      for(var m in makah){
        makkahotelss.add(makahmodel.fromJson(m));
      }
      for(var m in madinaa){
        madinaHotelss.add(madinaModel.fromJson(m));
      }
      makkahotels = makkahotelss;
      madinaHotels = madinaHotelss;
      for(var m in madinaHotels){


      }

      notifyListeners();
    } catch(e){
      print(e);
    }

  }
}
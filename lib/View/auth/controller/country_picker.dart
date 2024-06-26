
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../model/country_model/country_model.dart';
import 'location_controller.dart';



class CountryController with ChangeNotifier {
  List<CountryPicker> countries = [];
  var selectedCountry;
  var flag;
  var code;
  var dialCode ;
  var called = false;



  void loadCountryList(var context) async {
    try{
      var country = await Provider.of<LocationController>(context,listen:false).country;
      print("contry is : $country");
      var jsonString = await rootBundle.loadString('countryjson/countryjson.json');
      List countryList = json.decode(jsonString);

      // countries=ContryPicker.fromJson(country[0]);
      countries = countryList.map((country) => CountryPicker.fromJson(country)).toList();
      for(var m in countryList){

        // print('${m['map']}');
        if(country == m['name']) {
          print('country selected');
          flag = m['flag'];
          selectedCountry = m['name'];
          code = m['code'];
          dialCode = m['dial_code'];
          notifyListeners();
        }
      }
      called = true;
      notifyListeners();
    } catch(e){
      // print(e);
    }
    //
  }

  void selectCountry(var country,Flag,Code) {
    selectedCountry =  country;
    flag =  Flag;
    code =  Code;
    notifyListeners();
  }
}

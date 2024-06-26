import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../model/umrah_guide.dart';

// Ihram Steps

class IhramStepsProvider with ChangeNotifier{

  List<UmraSteps> ihramSteps = [];

  IhramStepsProvider() {
    loadIhramStems();
  }

  void loadIhramStems() async{

    try{
      var jsonString = await rootBundle.loadString('umra_json/umra_json.json');
      List stepList = json.decode(jsonString);
      ihramSteps = stepList.map((e) => UmraSteps.fromJson(e)).toList();
      notifyListeners();
    }
    catch(e){}
  }
}

// Tawaf Steps
class TawafStepsProvider with ChangeNotifier{

  List<UmraSteps> tawafSteps = [];

  TawafStepsProvider() {
    loadIhramStems();
  }

  void loadIhramStems() async{

    try{
      var jsonString = await rootBundle.loadString('umra_json/tawaf_steps.json');
      List stepList = json.decode(jsonString);
      tawafSteps = stepList.map((e) => UmraSteps.fromJson(e)).toList();
      notifyListeners();
    }
    catch(e){}
  }
}

// Sai Steps
class SaiStepsProvider with ChangeNotifier{

  List<UmraSteps> saiSteps = [];

  SaiStepsProvider() {
    loadIhramStems();
  }

  void loadIhramStems() async{

    try{
      var jsonString = await rootBundle.loadString('umra_json/sai_steps.json');
      List stepList = json.decode(jsonString);
      saiSteps = stepList.map((e) => UmraSteps.fromJson(e)).toList();
      notifyListeners();
    }
    catch(e){}
  }
}

// class UmrahGuideProvider with ChangeNotifier{
//
//   List<UmraSteps> umraTitles = [];
//
//   UmrahGuideProvider() {
//     loadIhramStems();
//   }
//
//   void loadIhramStems() async{
//
//     try{
//       var jsonString = await rootBundle.loadString('umra_json/ihram_steps.json');
//       List umraGuideTitle = json.decode(jsonString);
//       umraGuideTitle = umraGuideTitle.map((e) => UmraSteps.fromJson(e)).toList();
//       notifyListeners();
//     }
//     catch(e){}
//   }
//
//
// }




import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


class LocationController with ChangeNotifier{

  var currentlocation;
  var currentAddress;
  var Streats;
  var country;
  var locality;
  var administrativeArea;
  var isloading = false;
  void clearAddress(){
    currentAddress = null;
  }
  var lat, long;
  var groceryLat ;
  var  groceryLong ;
  SetAddress(var address){
    currentAddress = address;
    notifyListeners();
  }
  void setlatAndlOng({var lats,longs}){
    print('changedd');
    lat = lats;
    long = longs;
    notifyListeners();
  }
  Position? _currentPosition;
  Future<void> getCurrentLocation() async {
    debugPrint('in getCurrent Location');
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
        forceAndroidLocationManager: true)
        .then((Position position) {
      _currentPosition = position;
      debugPrint(" position is of ${position.latitude}");
      lat = position.latitude;
      long = position.longitude;
      notifyListeners();
      // print(position.longitude);
      //getAddressFromLatLng(context);

    }).catchError((e) {
      // print(e);
    });
  }
  Future<Position> getUserCurrentLocation(context) async {
    debugPrint('in getUserCurrentLocaiton');
    await Geolocator.requestPermission().then((value) async {
      _currentPosition = await Geolocator.getCurrentPosition();
      debugPrint(" position is ${_currentPosition?.latitude}");
      lat = _currentPosition?.latitude;
      long = _currentPosition?.longitude;
      if(groceryLong == null){

        groceryLat = lat;
        groceryLong = long;
        debugPrint("grocery  position is ${groceryLat}");
        debugPrint("grocery  position is ${groceryLong}");
      }


      // print(position.longitude);
      getAddressFromLatLng(context);
      notifyListeners();
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });



    return await Geolocator.getCurrentPosition();
  }

  Future<dynamic> getAddressFromLatLng(context) async {
    try {
      if (currentAddress == null) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude);
        Placemark place = placemarks[0];
        Streats = place.street ?? '';
        locality = place.locality??'';
        String postalCode = place.postalCode ?? '';
        country = place.country ?? '';
        currentAddress= '$Streats $postalCode $locality $country'.trim();

        // Remove duplicate words from street
        Streats = Streats.replaceAll(RegExp(r'\b(\w+)\s+\1\b'), r'\1');
        Streats = Streats.replaceAll('،', ',');
        Streats = Streats.trim();
        print(Streats);
        // Remove duplicate words from address

        currentAddress = currentAddress.replaceAll(RegExp(r'\b(\w+)\s+\1\b'), r'\1');
        currentAddress = currentAddress.replaceAll('،', ',');
        notifyListeners();
        print('Address:$currentAddress');
        // Provider.of<CountryController>(context,listen:false).loadCountryList(country);
        return currentAddress;
      }

    }

    catch (e) {
      // print(e);
    }
  }






  // Future<dynamic> getAddressFromLatLong(var lat,long) async {
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //         33.530827, 73.096722);
  //
  //     Placemark place = placemarks[0];
  //     List<String> addressParts = [];
  //     String? name = place.name;
  //     Streats = place.street;
  //     String? subadminstrative = place.subAdministrativeArea;
  //     String? subLocality = place.subLocality;
  //     locality = place.locality;
  //     administrativeArea = place.administrativeArea;
  //     String? postalCode = place.postalCode;
  //     country = place.country;
  //     if (place.street != null) {
  //       addressParts.add(place.street!);
  //     }
  //
  //     if (place.subLocality != null && place.subLocality != place.locality) {
  //       addressParts.add(place.subLocality!);
  //     }
  //
  //     if (place.locality != null) {
  //       addressParts.add(place.locality!);
  //     }
  //
  //     if (place.administrativeArea != null) {
  //       addressParts.add(place.administrativeArea!);
  //     }
  //
  //     if (place.country != null) {
  //       addressParts.add(place.country!);
  //     }
  //
  //     currentAddress = addressParts.join(', ');
  //     // Remove duplicate street names
  //     currentAddress = currentAddress.replaceAll(RegExp(r'\b(\w+)\s+\1\b'), r'\1');
  //     // Remove special characters
  //     currentAddress = currentAddress.replaceAll(RegExp(r'[^\w\s]+'), '');
  //     print(currentAddress);
  //     return currentAddress;
  //   }
  //
  //
  //
  //   catch (e) {
  //     // print(e);
  //   }
  // }


  Future<String> getAddressFromLatLong(double lat, double long) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat,long);

      Placemark place = placemarks[0];
      Streats = place.street ?? '';
      locality = place.locality??'';
      String postalCode = place.postalCode ?? '';
      country = place.country ?? '';
      currentAddress= '$Streats $postalCode $locality $country'.trim();

      // Remove duplicate words from street
      Streats = Streats.replaceAll(RegExp(r'\b(\w+)\s+\1\b'), r'\1');
      Streats = Streats.replaceAll('،', ',');
      Streats = Streats.trim();
      print(Streats);
      // Remove duplicate words from address

      currentAddress = currentAddress.replaceAll(RegExp(r'\b(\w+)\s+\1\b'), r'\1');
      currentAddress = currentAddress.replaceAll('،', ',');
      notifyListeners();
      print('Address:$currentAddress');
      return currentAddress;
    } catch (e) {
      print(e);
      return '';
    }
  }



}

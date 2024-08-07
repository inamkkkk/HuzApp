

import 'dart:convert';
import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:huz/Model/Details.dart';
import 'package:huz/View/Booking/View/payment_verification.dart';
import 'package:huz/Widgets/snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../Loading/loading.dart';
import '../../../../utils/servecies.dart';
import '../../Model/Createbooking.dart';
import '../../Model/getbooking.dart';


class Bookingedite with ChangeNotifier{
  List<BookingsList> Blist = [];
  var startDate ;
  var endDate ;
  var combineNights;
  var bListsapi = false;
  var isedite = false;
  var isOpened = false;
  var isFav = false;
  var initialstartdate,initialenddate;
  int adults = 1 , childrens = 0, infents = 0 ;
  var price;
  var subtractprice;
  var specialreq,phonenumber,paymathod;
  var editemessage = "error" ;
  var edite= false;
  var bmessage = "";
  var selectedRoom = "Single";
  var finalRoom = "";
  var updatePrice = "";
  var roomtype;

  void updatedate({var startdate, enddate}){
    startDate = startdate;
    endDate = enddate;
    notifyListeners();

  }

  void roomChange(value){
    selectedRoom = value;
    notifyListeners();
  }

  void Updateguests ({var Infents , Adults , Childrens }){
    infents = Infents;
    adults = Adults;
    childrens = Childrens;
    notifyListeners();

  }
  DateFormat dateFormat = DateFormat('dd MMM yyyy');

  createbooking? booking;
  var isApiCalled = false;
var docapi = false;
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<bool> pickImage({required doctype, required numb,context}) async {
    var status = false;
    Loading();
    docapi = true;
    notifyListeners();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        _image = File(image.path);
      }

    await Uploaduserdocs(
     doctype: doctype,
      numb: numb,

    ).then((value){
      if(value==true){
        endLoading();
        docapi = false;
        status = value;
        notifyListeners();

      }else{
endLoading();
showSnackbar(context, uploadphotomessage);

      }

    });
      endLoading();
return status;

  }


Future<bool> submitobjection(
      {var message, sessiontoken, bookingnumber,objectionid,image}) async{
    try{
      var headers = {
        'Authorization': '${NetworkServices.token}'
      };
      var request = http.MultipartRequest('PUT', Uri.parse('${NetworkServices.bookingurl}objection_response_by_user/'));
      request.fields.addAll({
        'session_token': '${booking?.userSessionToken}',
        'booking_number': '${booking?.bookingNumber}',
        'client_remarks': '${message}',
        'objection_id': '${objectionid}'
      });
      request.files.add(await http.MultipartFile.fromPath('objection_document', image.path));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200|| response.statusCode == 201) {
        print(await response.stream.bytesToString());
        await getbookingdetail(sessiontoken, bookingnumber);
        return true;
      }
      else {
        print(response.reasonPhrase);
        return false;
      }

    }catch(e){
      return false;
    }


}

  Future<bool> createbookings ({sessiontoken,partnertoken,huztoken}) async {


    // Parse the string to DateTime
    DateFormat dateFormat = DateFormat('dd MMM yyyy');
    print("special req = $specialreq");
    print(startDate);
    DateTime dateTime1 = dateFormat.parse(startDate??initialstartdate);
    DateTime dateTime2 = dateFormat.parse(endDate??initialenddate);
    DateFormat outputFormat = DateFormat('yyyy-MM-dd\'T\'HH:mm');
    // Convert DateTime back to string
    String sdate = outputFormat.format(dateTime1);
    String edate = outputFormat.format(dateTime2);
    print(initialenddate);
    print(partnertoken);
    isApiCalled = true;
    notifyListeners();
    // try {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '${NetworkServices.token}'};
    var request = http.Request(
        'Post',
        Uri.parse(
            '${NetworkServices.bookingurl}create_booking_view/'));
    request.body = json.encode({
      "session_token": sessiontoken,
      "partner_session_token": partnertoken,
      "huz_token": huztoken,
      "adults": adults,
      "child": childrens,
      "infants":infents,
      "room_type": finalRoom,
      "start_date": sdate,
      "end_date":edate,
      "total_price":price,
      "special_request": specialreq,
      "payment_type": 'Bank'
    });
    request.headers.addAll(headers);
    http.StreamedResponse responses = await request.send();
    var response = await http.Response.fromStream(responses);
    if (response.statusCode == 200||response.statusCode == 201 ) {
      debugPrint('good to go');
      var map = jsonDecode(response.body);
      booking = createbooking.fromJson(map);
      isApiCalled = false;
      notifyListeners();
      return true;
    } else {

      isApiCalled = false;
      print(response.statusCode);
      print("error 02${response.body}");
      print("error 1 ${response.reasonPhrase}");
      notifyListeners();
      return false;
    }
    // } catch (e) {
    //   isApiCalled = false;
    //   notifyListeners();
    // }

    notifyListeners();

  }
  Future<bool> Updatebooking ({sessiontoken,partnertoken,huztoken}) async {
  // try{


    Loading();
    // Parse the string to DateTime
    DateFormat dateFormat = DateFormat('dd MMM yyyy');
    print(initialstartdate);
    print(startDate);
    DateTime dateTime1 = dateFormat.parse(startDate??initialstartdate);
    DateTime dateTime2 = dateFormat.parse(endDate??initialenddate);
    DateFormat outputFormat = DateFormat('yyyy-MM-dd\'T\'HH:mm');
    // Convert DateTime back to string
    String sdate = outputFormat.format(dateTime1);
    String edate = outputFormat.format(dateTime2);
    print(initialenddate);
    print(partnertoken);
    isApiCalled = true;
    notifyListeners();
    // try {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '${NetworkServices.token}'};
    var request = http.Request(
        'Post',
        Uri.parse(
            '${NetworkServices.bookingurl}create_booking_view/'));
    request.body = json.encode({
      "session_token": sessiontoken,
      "partner_session_token": partnertoken,
      "huz_token": huztoken,
      "adults": adults,
      "child": childrens,
      "infants":infents,
      "room_type": finalRoom,
      "start_date": sdate,
      "end_date":edate,
      "total_price":price,
      "special_request": "${specialreq??'N/A'}",
      "payment_type": 'Bank'
    });
    request.headers.addAll(headers);
    http.StreamedResponse responses = await request.send();
    var response = await http.Response.fromStream(responses);
    if (response.statusCode == 200||response.statusCode == 201 ) {

      var map = jsonDecode(response.body);
      print(map);
      booking = createbooking.fromJson(map);
      isApiCalled = false;
      notifyListeners();
      return true;
    } else {

      isApiCalled = false;
      print(response.statusCode);
      print("error 02${response.body}");
      print("error 1 ${response.reasonPhrase}");
      var data = jsonDecode(response.body);
      // editemessage = data['message'];
      // edite = true;
      notifyListeners();
      return false;
    }
    // } catch (e) {
    //
    //   isApiCalled = false;
    //   return false;
    //   notifyListeners();
    // }

    notifyListeners();

  }
  Future<void> getbookings (sessiontoken) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': '${NetworkServices.token}'};

      var request = http.Request('GET', Uri.parse('${NetworkServices
          .bookingurl}get_all_booking_short_detail_by_user/?session_token=$sessiontoken'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        bListsapi = true;
        final data = jsonDecode(await response.stream.bytesToString());
        List<BookingsList> lists = [];
        for (var m in data) {
          lists.add(BookingsList.fromJson(m));
        }
        Blist = lists;
        print(data);

        notifyListeners();
      }
      else {
        print(response.statusCode);
        bListsapi = true;
        final data = jsonDecode(await response.stream.bytesToString());

        print(data);
        notifyListeners();

        print(response.reasonPhrase);
      }
    }catch(e){
   bmessage = e.toString();

    }
  }
  Future<bool> deleteBooking (sessiontoken,bookingNumber) async {
    Loading();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '${NetworkServices.token}'};
    var request = http.Request('DELETE', Uri.parse('${NetworkServices.bookingurl}create_booking_view/'));
    request.body = json.encode({
      "session_token": "$sessiontoken",
      "booking_number": "$bookingNumber"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final data = jsonDecode(await response.stream.bytesToString());
      return true;
    }
    else {
      final data = jsonDecode(await response.stream.bytesToString());
      print(data);
      return false;
      print(response.reasonPhrase);
    }

  }
  Future<bool> getbookingdetail (sessiontoken,bookingNumber) async {
    try{
    Loading();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '${NetworkServices.token}'};
    var request = http.Request('GET', Uri.parse('${NetworkServices.bookingurl}create_booking_view/?session_token=$sessiontoken&booking_number=$bookingNumber'));
    request.body = json.encode({
      "session_token": "$sessiontoken",
      "booking_number": "$bookingNumber"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(await response.stream.bytesToString());
      booking = createbooking.fromJson(data);
      notifyListeners();
      endLoading();
      return true;
    }
    else {
      final data = jsonDecode(await response.stream.bytesToString());
      print(response.statusCode);
      print(data);
      endLoading();
      print('erroe is ');
      try{
        bmessage = data;

      } catch(e){
        print(e);
      }
      return false;
      print(response.reasonPhrase);
    }}catch(e){
      endLoading();
      print('erroe is $e');
      bmessage = e.toString();
      return false;
    }
  }








  List<dynamic> imageFileList = [];
  List<String> filePaths = [
  ];
  var uploadphotomessage ;
  void pickImages() async {
    filePaths.clear();
    final List<XFile>? selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      for (var m in selectedImages){
        imageFileList.add(m);
      }
      for(var m in imageFileList!){
        filePaths.add(m.path);
      }

      print('filepathlength = ${filePaths.length}');
      notifyListeners();
    }
  }

  Future<bool> deletedoc({required id,required bookingnumber , required sessiontoken}) async {
    try{
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': '${NetworkServices.token}'
      };
      var request = http.Request('DELETE', Uri.parse('${NetworkServices.bookingurl}delete_passport_or_photo/'));
      request.body = json.encode({
        "session_token": "${booking?.userSessionToken}",
        "user_document_id": "${id}",
        "booking_number": "${booking?.bookingNumber}"
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      await getbookingdetail(booking?.userSessionToken, booking?.bookingNumber);
        return true;
    }
    else {
    print(response.reasonPhrase);

    return false;
    }

  } catch (e){
      return false;


    }
  }
  Future<bool> Uploaduserdocs({sessiontoken,bookingnumber,amount,required doctype,required numb}) async {
    Loading();
    var headers = {
      'Authorization': '${NetworkServices.token}',
    };
    var request = http.MultipartRequest('POST', Uri.parse('${NetworkServices.bookingurl}manage_passport_and_photo/'));
    request.headers.addAll(headers);
    request.fields.addAll({
      'session_token': '${booking?.userSessionToken}',
      'booking_number': '${booking?.bookingNumber}',
      'document_type': '$doctype',
      'traveller_number': '$numb'
    });
    // List of file paths to upload


    // Add each file to the request
print('image path is ${_image!.path}');
    request.files.add(await http.MultipartFile.fromPath('user_document', _image!.path));
    request.headers.addAll(headers);
    // Send the request
    http.StreamedResponse response = await request.send();

    // Handle the response
    if (response.statusCode == 200||response.statusCode == 201) {
      final data = jsonDecode(await response.stream.bytesToString());
      booking = createbooking.fromJson(data);
      notifyListeners();
      return true;
    } else {
      final data = jsonDecode(await response.stream.bytesToString());
      print(data);
      uploadphotomessage = data["message"];
      return false;
    }
  }

}
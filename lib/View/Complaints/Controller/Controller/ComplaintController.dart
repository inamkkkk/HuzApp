import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import '../../../../Loading/loading.dart';
import '../../../../utils/servecies.dart';
import '../../Model/GetComplaints/GetComplaints.dart';
import '../../Model/Model.dart';



class Complaintscontroller with ChangeNotifier{
  var isApiCalled = false;
  var list = [];
  var length ;
  var islistapiiscalled = false;
  var isliststatusapiiscalled = false;
  complaintcounts? count;
  var cmessage = "";

  List<Results> result = [];
  var request = http.MultipartRequest('POST', Uri.parse('https://hajjumrah.org/bookings/raise_complaint_booking_wise/'));


  Future<bool> RaiseComplaint({var token,number,title,message,audio}) async {

    try{
      Loading();
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': NetworkServices.token,
      };
      var request = http.MultipartRequest('POST', Uri.parse('${NetworkServices.bookingurl}raise_complaint_booking_wise/'));

      request.fields.addAll({
        'session_token': '${token}',
        'booking_number': '${number}',
        'complaint_title': title,
        'complaint_message': message
      });
      if(audio != null)
        request.files.add(await http.MultipartFile.fromPath('audio_message', audio));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(await response.stream.bytesToString());
        return true;
      }
      else {
        var data = jsonDecode(await response.stream.bytesToString());
        print(data);
        cmessage = data['message'];
        return false;
      }
    }catch(e){
      cmessage = e.toString();
      return false;
    }

  }

  Future<void> getcomplaintscount({var token}) async {
    String apiUrl = '${NetworkServices.bookingurl}get_total_complaints_count/?'; // replace with your API URL// replace with your session token
    // create session header
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': NetworkServices.token,
    };
    // make HTTP POST request
    // String sessionToken = 'session_token=$token';
    String sessionToken = 'session_token=$token';
    final http.Response response = await http.get(
      Uri.parse('$apiUrl$sessionToken'),
      headers: headers,
    );
    debugPrint('API url: ${apiUrl + sessionToken + headers['Authorization']!}');

    // check if API hits successfully
    if (response.statusCode == 200 || response.statusCode == 201) {
      list.clear();
      var data = jsonDecode(response.body);
      count = complaintcounts.fromJson(data);
     list = [
        count?.open,count?.inProgress,count?.solved,count?.close
      ];

     isApiCalled = true;
      notifyListeners();

    } else {
      isApiCalled = true;
      notifyListeners();
      debugPrint('API hit failed with status code: ${response.body}');
    }
  }
  // Future<void> GetComplaints({var token}) async {
  //
  //   String apiUrl = '${NetworkServices.bookingurl}get_all_complaints_by_user/?'; // replace with your API URL// replace with your session token
  //   // create session header
  //   final Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': NetworkServices.token,
  //   };
  //   // make HTTP POST request
  //   // String sessionToken = 'session_token=$token';
  //   String sessionToken = 'session_token=$token&complaint_status=Open';
  //   final http.Response response = await http.get(
  //     Uri.parse('$apiUrl$sessionToken'),
  //     headers: headers,
  //   );
  //   debugPrint('API url: ${apiUrl + sessionToken + headers['Authorization']!}');
  //
  //   // check if API hits successfully
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     List<GetComplaintsModel> cmplist = [];
  //     var data = jsonDecode(response.body);
  //
  //     Complaints = GetComplaintsModel.fromJson(data);
  //     length = Complaints?.results?.length;
  //     islistapiiscalled = true;
  //     // isApiCalled = true;
  //     notifyListeners();
  //
  //   } else {
  //     islistapiiscalled = true;
  //     isApiCalled = true;
  //     notifyListeners();
  //     debugPrint('API hit failed with status code: ${response.body}');
  //   }
  // }

  var present = false;
  Future<bool> GetComplaintsbystatus({var token,status}) async {
    Loading();
    result.clear();
    String apiUrl = '${NetworkServices.bookingurl}get_all_complaints_by_user/?'; // replace with your API URL// replace with your session token
    // create session header
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': NetworkServices.token,
    };
    // make HTTP POST request
    // String sessionToken = 'session_token=$token';
    String sessionToken = 'session_token=$token';
    final http.Response response = await http.get(
      Uri.parse('$apiUrl$sessionToken'),
      headers: headers,
    );
    debugPrint('API url: ${apiUrl + sessionToken + headers['Authorization']!}');



    // check if API hits successfully
    if (response.statusCode == 200 || response.statusCode == 201) {

      var data = jsonDecode(response.body);
      print(data);
      for(var m in data){
        result.add(Results.fromJson(m!));
      }
      isliststatusapiiscalled = true;
      notifyListeners();
      return true;

    } else {

      isliststatusapiiscalled = true;
      notifyListeners();
      return false;
      debugPrint('API hit failed with status code: ${response.body}');
    }
  }
}
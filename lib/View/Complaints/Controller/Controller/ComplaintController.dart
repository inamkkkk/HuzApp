import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import '../../../../utils/servecies.dart';
import '../../Model/GetComplaints/GetComplaints.dart';
import '../../Model/Model.dart';



class Complaintscontroller with ChangeNotifier{
  var isApiCalled = false;
  var list = [];
  var length ;
  var islistapiiscalled = false;
  GetComplaintsModel? Complaintsbystatus ;
  var isliststatusapiiscalled = false;
  complaintcounts? count;
GetComplaintsModel? Complaints ;

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
  Future<void> GetComplaints({var token}) async {

    String apiUrl = '${NetworkServices.bookingurl}get_all_complaints_by_user/?'; // replace with your API URL// replace with your session token
    // create session header
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': NetworkServices.token,
    };
    // make HTTP POST request
    // String sessionToken = 'session_token=$token';
    String sessionToken = 'session_token=$token&complaint_status=Open';
    final http.Response response = await http.get(
      Uri.parse('$apiUrl$sessionToken'),
      headers: headers,
    );
    debugPrint('API url: ${apiUrl + sessionToken + headers['Authorization']!}');

    // check if API hits successfully
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<GetComplaintsModel> cmplist = [];
      var data = jsonDecode(response.body);

      Complaints = GetComplaintsModel.fromJson(data);
      length = Complaints?.results?.length;
      islistapiiscalled = true;
      // isApiCalled = true;
      notifyListeners();

    } else {
      islistapiiscalled = true;
      isApiCalled = true;
      notifyListeners();
      debugPrint('API hit failed with status code: ${response.body}');
    }
  }
  Future<void> GetComplaintsbystatus({var token,status}) async {
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
      Complaintsbystatus = GetComplaintsModel.fromJson(data);
      isliststatusapiiscalled = true;
      notifyListeners();

    } else {

      isliststatusapiiscalled = true;
      notifyListeners();
      debugPrint('API hit failed with status code: ${response.body}');
    }
  }
}
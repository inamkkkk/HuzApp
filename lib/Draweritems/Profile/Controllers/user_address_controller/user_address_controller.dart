import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/servecies.dart';
import '../../model.dart';


class UserAddressController with ChangeNotifier {

  UserAddress? userAddress;

  Future<void> getUserAddress() async {
    try {
      var headers = {
        'Authorization': '${NetworkServices.token}',
        'Content-Type': 'application/json'
      };
      var request = http.Request(
          'GET',
          Uri.parse(
              '${NetworkServices.baseUrl}manage_user_address_detail/?session_token=MTU5MTQ4MjAxMTQxMDkwODg5'));
      request.headers.addAll(headers);
      var data = jsonDecode(request.body);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        for (Map<String, dynamic> index in data) {
          userAddress = UserAddress.fromJson(index);
        }
        print("************************************************************");
        print(userAddress);

        print("************************************************************");
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {}
  }
}

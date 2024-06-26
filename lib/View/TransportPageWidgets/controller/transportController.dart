import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:huz/View/TransportPageWidgets/Model/Trasnportmodel.dart';
import 'package:http/http.dart' as http;
import 'package:huz/utils/servecies.dart';

// class transportCroller with ChangeNotifier{
//   TransportModel? transport;
//
//   Future<void> GetTransport() async {
//     var headers = {
//       'Authorization': '${NetworkServacies.token}'
//     };
//     var request = http.Request('GET', Uri.parse('${NetworkServacies.baseUrl}get_transport_package_for_web/'));
//     request.body = '''''';
//     request.headers.addAll(headers);
//
//     http.StreamedResponse Streamresponse = await request.send();
//     var response = await http.Response.fromStream(Streamresponse);
//     if (response.statusCode == 200) {
//         var map = jsonDecode(response.body);
//         transport = TransportModel.fromJson(map);
//         notifyListeners();
//
//         print('transport data = "${transport?.results?[0].plateNo}');
//
//     }
//     else {
//     print(response.reasonPhrase);
//     }
//
//
//   }
//
//
// }
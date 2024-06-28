import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:huz/Loading/loading.dart';
import 'package:huz/utils/servecies.dart';

class ratingcotroller with ChangeNotifier
{


var ratingmessage ;

Future<bool> GiveRatings({required sessiontoken, required bookingumber,
required concerge, required support, required platform , required quality , required responses,
required PStars , required pComment, required huzComent})async{
  try{
    Loading();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '${NetworkServices.token}'
    };
    var request = http.Request('POST', Uri.parse('${NetworkServices.bookingurl}rating_and_review/'));
    request.body = json.encode({
      "session_token": sessiontoken,
      "booking_number": bookingumber,
      "huz_concierge": concerge,
      "huz_support": support,
      "huz_platform": platform,
      "huz_service_quality": quality,
      "huz_response_time": responses,
      "huz_comment": huzComent,
      "partner_total_stars": PStars,
      "partner_comment": pComment,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(await response.stream.bytesToString());

      return true ;
    }
    else {
      print(response.reasonPhrase);
      var data = json.decode(await response.stream.bytesToString());
      ratingmessage = data['message'];
      notifyListeners();

      return false;

    }
  } catch(e){
    ratingmessage = e.toString();
    notifyListeners();
    endLoading();
    return false;
  }
}
}
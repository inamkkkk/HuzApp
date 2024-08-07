import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../Model/Details.dart';
import '../Model/Pakages.dart';
import '../Responsive/ResponsiveClass.dart';
import '../TextStyles/Color.dart';
import '../TextStyles/styles.dart';
import '../View/TransportPageWidgets/Model/Trasnportmodel.dart';
import '../utils/servecies.dart';
import 'package:http/http.dart' as http;

class pakagecontrollers with ChangeNotifier {
  Pakages? package;
  var isApiCalled = false;
  var length = 0;
  var fromtabs = false;
  List<Widget> availability = [];

  TransportModel? transport;

  Future<void> GetTransport() async {
    try {
      var headers = {'Authorization': '${NetworkServices.token}'};
      var request = http.Request(
          'GET',
          Uri.parse(
              '${NetworkServices.baseUrl}get_transport_package_for_web/'));
      request.body = '''''';
      request.headers.addAll(headers);

      http.StreamedResponse Streamresponse = await request.send();
      var response = await http.Response.fromStream(Streamresponse);
      if (response.statusCode == 200) {
        isApiCalled = true;
        var map = jsonDecode(response.body);

        print(
            "************************* respne body form Get Transport: ${response.body}");
        transport = TransportModel.fromJson(map);

        notifyListeners();
        print(transport!.results?.length);

        print('transport data = "${transport?.results?[0].plateNo}');
      } else {
        isApiCalled = true;
        print(
            "**************************** respone phrase : ${response.reasonPhrase}");

        notifyListeners();
      }
    } catch (e) {
      isApiCalled = true;
      notifyListeners();
    }
  }

  var include = [];
  var exclude = [];
  List<List<String>> photes = [];
  List<String> photess = [];
  Details? details;
  List<Widget> routs = [];
  List<Widget> ziarat = [];
  var allincludes = [];
  var allexclude = [];

  void getnull() {
    isApiCalled = false;
    notifyListeners();
  }

  Future<void> Getpackages(var data) async {
    photes.clear();
    allincludes.clear();

    try {
      var headers = {'Authorization': '${NetworkServices.token}'};
      var request = http.Request(
          'GET',
          Uri.parse(
              '${NetworkServices.baseUrl}get_package_short_detail_for_web/?package_type=$data'));

      request.headers.addAll(headers);
      http.StreamedResponse Streamresponse = await request.send();
      var response = await http.Response.fromStream(Streamresponse);
      if (Streamresponse.statusCode == 200) {
        print('hello');

        print("**************** Status Code: ${Streamresponse.statusCode}");

        print(
            "*************************** Pakcge respone body: ${response.body} and respone: $response");
        var map = jsonDecode(response.body);
        print('map is : $map');
        package = Pakages.fromJson(map);
        length = package!.results!.length;
        for (var m in package!.results!) {
          var include2 = [];
          var exclude2 = [];

          include2.clear();
          exclude2.clear();
          if (m.isTourGuideIncluded!) {
            include2.add('Tour guide - ');
          }
          if (m.isTourGuideIncluded!) {
            include2.add('Tour guide - ');
          }

          if (m.isVisaIncluded!) {
            print('visa includes');
            include2.add('eVisa-');
          }

          if (m.isBreakfastIncluded!) {
            include2.add('Breakfast - ');
          }
          if (m.isInsuranceIncluded!) {
            include2.add('Insurance - ');
          }
          if (m.isDinnerIncluded!) {
            include2.add('Dinner - ');
          }
          if (m.isLunchIncluded!) {
            include2.add('Lunch - ');
          }

          if (m.isAirportReceptionIncluded!) {
            include2.add('Reception');
          }
          allincludes.add(include2);

          print(allincludes);
        }

        print(photes);
        print("phoes length : ${photess.length}");
        isApiCalled = true;
        notifyListeners();
      } else
        debugPrint('${jsonDecode(response.body)}');

      isApiCalled = true;
      notifyListeners();
      var map = jsonDecode(response.body);

      notifyListeners();
    } catch (e) {
      isApiCalled = true;
      print("******************************* Print in catch");
      notifyListeners();
      debugPrint('catch error : $e');
    }
  }

  Future<void> GetDetails(token, context) async {
    routs.clear();
    include.clear();
    ziarat.clear();
    try {
      var headers = {'Authorization': '${NetworkServices.token}'};
      var request = http.Request(
          'GET',
          Uri.parse(
              '${NetworkServices.baseUrl}get_package_detail_by_package_id_for_web/?huz_token=$token'));

      request.headers.addAll(headers);
      http.StreamedResponse Streamresponse = await request.send();
      var response = await http.Response.fromStream(Streamresponse);
      if (Streamresponse.statusCode == 200 ||
          Streamresponse.statusCode == 201) {
        isApiCalled = true;
        print('hello');
        var map = jsonDecode(response.body);
        print('map is : $map');
        details = Details.fromJson(map[0]);
        length = package!.results!.length;
        String string = details?.transportDetail?[0].routes;
        print('routes are : $string');
        List<String> result = string.split(", ");
        print(result);

        for (var m in result) {
          routs.add(
            Container(
                width: responsive(150, context),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      width: responsive(15, context),
                      height: responsive(15, context),
                      'images/include.svg',
                      semanticsLabel: 'vector',
                      // fit: BoxFit.fitHeight,
                    ),
                    SizedBox(
                      width: responsive(08, context),
                    ),
                    customFonts(
                        text: '$m',
                        size: 15,
                        color: AppColors.primaryBlackColor,
                        fontWeight: FontWeight.w500,
                        context: context),
                    SizedBox(
                      width: responsive(02, context),
                    )
                  ],
                )),
          );
        }
        String string2 = details?.ziyarahDetail?[0].ziyarahList;
        List<String> result2 = string2.split(", ");
        print("ziarat is $string2");
        // if(ziarat.isNotEmpty)
        if (result2[0].isNotEmpty)
          for (var m in result2) {
            ziarat.add(
              Container(
                  child: Row(
                children: [
                  SvgPicture.asset(
                    width: responsive(12, context),
                    height: responsive(12, context),
                    'images/include.svg',
                    semanticsLabel: 'vector',
                    // fit: BoxFit.fitHeight,
                  ),
                  SizedBox(
                    width: responsive(08, context),
                  ),

                  Discriptions(
                    center: false,
                    text: '${m}',
                    context: context,
                  ),
                  // SizedBox(width: responsive(02, context),)
                ],
              )),
            );
          }

        print("ziarat is $ziarat");
        print(result);
        if (details?.isTourGuideIncluded!) {
          include.add('Tour guide - ');
        }
        if (details?.isTourGuideIncluded!) {
          include.add('Tour guide - ');
        }

        if (details?.isVisaIncluded!) {
          print('visa includes');
          include.add('eVisa-');
        }

        if (details?.isBreakfastIncluded!) {
          include.add('Breakfast - ');
        }
        if (details?.isInsuranceIncluded!) {
          include.add('Insurance - ');
        }
        if (details?.isDinnerIncluded!) {
          include.add('Dinner - ');
        }
        if (details?.isLunchIncluded!) {
          include.add('Lunch - ');
        }

        //------
        // if(details?.isVisaIncluded!){
        //   include.add('eVisa - ');
        // }
        // if(details?.isTourGuideIncluded!){
        //   include.add('Tour guide - ');
        //
        // }
        // if(details?.isBreakfastIncluded!){
        //   include.add('Breakfast - ');
        //
        // }
        // if(details?.isInsuranceIncluded!){
        //   include.add('Insurance - ');
        //
        // }
        // if(details?.isDinnerIncluded!){
        //   include.add('Dinner - ');
        //
        // }
        // if(details?.isLunchIncluded!){
        //   include.add('Lunch - ');
        //
        // }
        //-------------

        if (details?.isAirportReceptionIncluded!) {
          include.add('Reception');
        }
        print('widget length is : ${include.length}');
        // print(package?.count);
        isApiCalled = true;
        notifyListeners();
      } else
        debugPrint('error is ${jsonDecode(response.body)}');

      isApiCalled = true;
      // var map = jsonDecode(response.body);
      // message = map['message'];
      // isVisible = true;
      // print(map);
      // endLoading();
      // notifyListeners();
    } catch (e) {
      debugPrint('catch error : $e');
      // endLoading();
      // message = e.toString();
      // isVisible = true;
      // print(e);
    }
  }
}

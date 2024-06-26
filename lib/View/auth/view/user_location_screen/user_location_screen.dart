import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:huz/View/auth/controller/is_user_exist_controller.dart';

import 'package:provider/provider.dart';

import 'package:uuid/uuid.dart';


import '../../../../Loading/loading.dart';
import '../../../../Responsive/ResponsiveClass.dart';
import '../../../../TextStyles/AppFonts.dart';
import '../../../../TextStyles/Color.dart';
import '../../../../Widgets/back_button.dart';
import '../../../../Widgets/primary_button.dart';
import '../../../../widgets/BouncingMarker.dart';
import '../../../../widgets/animatedText/animatedText.dart';
import '../../../../widgets/error_message_popup/error_message.dart';
import '../../../Booking/View/payment_verification.dart';
import '../../../Booking/View/verify_payment.dart';
import '../../../Home/View/home_screen.dart';
import '../../Controller/MapsController/MapsController.dart';
import '../../Controller/SaveAddController/SaveAddController.dart';

import 'package:geocoding/geocoding.dart' as geocode;
import 'package:widget_to_marker/widget_to_marker.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../auth_widgets/auth_header_text.dart';
import '../../controller/location_controller.dart';


class UserLocationScreen extends StatefulWidget {
  var type ;
  UserLocationScreen({Key? key,required this.type}) : super(key: key);

  @override
  State<UserLocationScreen> createState() => _UserLocationScreenState();
}

class _UserLocationScreenState extends State<UserLocationScreen>  with SingleTickerProviderStateMixin {

  late AnimationController _coontroller;
  late Animation<double> _animation;
  List<Widget> lebellist = [];
  String? _mapStyle;
  var other;
  var addlocation;
  final _controller = TextEditingController();
  var area,add,unit,type;
  LocationController? DataController ;
  GoogleMapController? mapController;
  var markers;
  var _streetNumber,_street,  _city;
  var lat,long;
  var _markerLocation;
  var isdot=false;
  Future<void> getLatlng() async {
    try {
      DataController = await Provider.of<LocationController>(context,listen: false);
      print('inam2');
      if(DataController?.lat==null){
        isdot = true;
        DataController = await Provider.of<LocationController>(context,listen: false);
        // await DataController?.getCurrentLocation();
        // lat = await Provider.of<LocationController>(context, listen: false).lat;
        // long = await Provider.of<LocationController>(context, listen: false).long;
        // add = DataController?.currentAddress;
      }
      if(DataController?.lat!=null){
        isdot = false;
      }

      print('inam3');


      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _markerLocation,
            zoom: 19.0,
          ),
        ),
      );
      //);
      setState(()  {

        // _addMarker(LatLng(lat, long), "origin", BitmapDescriptor.defaultMarker);
      });
    } catch (error) {
      print('error = $error');
    }
    setState(() {});
  }


  @override
  void initState() {
    getLatlng();
    DefaultAssetBundle.of(context).loadString('MapsDesignjson/mapdesign.json').then((string) {
      addListner = widget.type == 'Company'||widget.type == "Grocery"?[false,true,false,]:[true,false,false,];
      _mapStyle = string;
      print(_mapStyle);
      setState(() {

      });
    });



    // TODO: implement initState
    super.initState();
    _coontroller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..forward();
    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 20), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 20, end: 0), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: _coontroller,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          // isdot = !isdot;
        });

      }
    });



  }
  var addListner=[true,false,false,];
  var isother = false;
  Future<void> onCameraMove(CameraPosition position) async {
    setState(() {
      isdot = true;
    });
    print('inamder');
    lat = null;
    long = null;
    DataController?.setlatAndlOng(lats:position.target.latitude,longs:position.target.longitude);
  }


  @override
  Widget build(BuildContext context) {

    var screensize = MediaQuery.of(context).size.height;
    print('screen size is $screensize');
    screensize = screensize<=800?690:600;
    var LocationControllers = Provider.of<SaveAddressController>(context,listen: false);
    return Consumer3<SaveAddressController,LocationController,IsUserExitsController>(builder: (context, value,location,user, child)  {

      if (location.lat==null)  {
        location.getCurrentLocation();

      }
      lat = location.lat;
      long = location.long;
      if(lat!=null) _markerLocation = LatLng(lat,long);
      if(add == null) add =  location.currentAddress;

      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  location.lat == null
                      ? Expanded(
                    child: Container(
                        height: responsive(300, context),
                        child: Center(child: CircularProgressIndicator())),
                  )
                      :   Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        GoogleMap(
                          onMapCreated: _onMapCreated,
                          onCameraMove: onCameraMove,
                          // markers: Set<Marker>.of([markers]),
                          initialCameraPosition: CameraPosition(
                            target: _markerLocation,
                            zoom: 19.00,
                          ),
                          onCameraIdle:() async {
                            print('inamder2');
                            add = await location.getAddressFromLatLong(location.lat,location.long);
                            _coontroller.reset();
                            _coontroller.forward();
                            setState(() {
                              isdot = false;
                            });
                          },
                          zoomControlsEnabled: false,

                          // polylines: Set<Polyline>.of(polylines.values),
                        ),

                        isdot
                            ? BouncingSvgImage(
                          imagePath: 'assets/images/locc2.svg',
                          width: 30.14,
                          height: 40.94,
                          animation: _animation,
                        )
                            : BouncingSvgImage(
                          imagePath: 'assets/images/locc.svg',
                          width: 30.14,
                          height: 40.94,
                          animation: _animation,
                        ),


                      ],
                    ),),
                  ExpandableContainer(
                    initialHeight: responsive(370, context),  // initial height of the container
                    maxHeight: responsive(screensize, context),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 40,
                            offset: Offset(3, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0),
                        ),
                      ),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        // shrinkWrap: true,
                        children: [
                          Container(
                            //height: MediaQuery.of(context).size.height,

                            child: SingleChildScrollView(

                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    // top bottom sheet handle container
                                    Center(
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        width: 35,
                                        height: 7,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF646363),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),

                                    //Container to edit location/ mark location/ and search area
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 25),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          const Align(
                                              alignment: Alignment.topLeft,
                                              child: AuthHeaderText(
                                                  headerText: 'Add new address')),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(20),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(8),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 6.0,
                                                  offset: Offset(6, 8),
                                                ),
                                                BoxShadow(
                                                  color: Color(0xFFF2F2F2),
                                                  blurRadius: 3.0,
                                                  offset: Offset(-3, -2),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: [
                                                        SvgPicture.asset(
                                                          height: responsive(25.45,context),
                                                          width: responsive(19.73,context),
                                                          'assets/images/locationIcon.svg',
                                                          semanticsLabel: 'vector',
                                                          fit: BoxFit.fitWidth,
                                                        ),
                                                        const SizedBox(
                                                          width: 14,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              width:responsive(200,context),
                                                              child: Text(
                                                                '${add??'Pickup Address'}',
                                                                maxLines: 1,
                                                                overflow: TextOverflow.clip,
                                                                style: TextStyle(
                                                                    fontFamily: AppFonts
                                                                        .poppinsBold,
                                                                    fontSize: responsive(12,context)),
                                                              ),
                                                            ),
                                                            Text(
                                                              '${_city??location.locality??''}',
                                                              style: TextStyle(
                                                                  fontFamily: AppFonts
                                                                      .poppinsRegular,
                                                                  fontSize: responsive(12,context)),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        // generate a new token here
                                                        final sessionToken = Uuid().v4();
                                                        final Suggestion? result = await showSearch(
                                                          context: context,
                                                          delegate: AddressSearch(sessionToken),
                                                        );
                                                        print(result);
                                                        // This will change the text displayed in the TextField
                                                        if (result != null) {
                                                          print('checkgoogleapi');
                                                          final placeDetails =
                                                          await PlaceApiProvider(sessionToken)
                                                              .getPlaceDetailFromId(result.placeId);
                                                          _controller.text = result.description;
                                                          _streetNumber = placeDetails.streetNumber;
                                                          _street = placeDetails.street;
                                                          _city = placeDetails.city;

                                                          // _zipCode = placeDetails.zipCode;
                                                          add = result.description;
                                                          Loading();
                                                          List<Location> locations = await locationFromAddress("$add");

                                                          lat = locations[0].latitude;
                                                          long = locations[0].longitude;
                                                          _markerLocation = LatLng(lat, long);
                                                          Provider.of<LocationController>(context,listen: false).getAddressFromLatLong(lat,long);
                                                          getLatlng();
                                                          endLoading();
                                                          setState(() {

                                                          });
                                                        }
                                                      },
                                                      child: SvgPicture.asset(
                                                        height: responsive(18,context),
                                                        width: responsive(18,context),
                                                        'assets/images/editIcon.svg',
                                                        semanticsLabel: 'vector',
                                                        fit: BoxFit.fitWidth,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "We're missing your area",
                                                  style: TextStyle(
                                                      fontFamily: AppFonts.poppinsBold,
                                                      fontSize: responsive(13,context)),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                CustomTextField(

                                                    onchange: (value){
                                                      area = value;
                                                    },

                                                    hintText: 'Area'),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          CustomTextField(
                                              onchange: (value){
                                                unit = value;
                                              },
                                              hintText: 'Floor/Unit#'),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          // Visibility(
                                          //   visible: isother?true:false,
                                          //   child: CustomTextField(
                                          //       onchange: (value){
                                          //          other = value;
                                          //
                                          //
                                          //       },
                                          //
                                          //       hintText: 'New Lable'),
                                          // ),
                                          // SizedBox(
                                          //   height: responsive(15,context),
                                          // ),
                                          // Visibility(
                                          //   visible: isother?true:false,
                                          //   child: Container(
                                          //     height: 70,
                                          //     color: Colors.white,
                                          //     width: MediaQuery.of(context).size.width,
                                          //     child:Padding(
                                          //       padding: const EdgeInsets.symmetric(horizontal: 42,vertical: 15),
                                          //       child:isdot?LoadingDots():PrimaryButton(
                                          //           btnText: 'Add',
                                          //           onPressed:(){
                                          //             lebellist[6]=CustomIconButton(
                                          //                 imgPath: 'assets/images/plusIcon.svg',
                                          //                 text: '$other',
                                          //                 ontap: () {
                                          //
                                          //                   isother = false;
                                          //                   addListner = [false, false,false, true];
                                          //                   addlocation = '$other';
                                          //
                                          //
                                          //                 },
                                          //                 color: addListner[3] == true
                                          //                     ?AppColors.GlobelColor
                                          //                     :Colors.white,
                                          //                 color2: addListner[3] == true
                                          //                     ? Colors.white
                                          //                     :AppColors.GlobelColor
                                          //
                                          //             );
                                          //
                                          //             addListner = [false, false,false, true];
                                          //             addlocation = '$other';
                                          //
                                          //             isother=false;
                                          //             debugPrint('called');
                                          //             setState(() {});
                                          //
                                          //           }
                                          //     ),
                                          //   ),
                                          // )),
                                          Visibility(
                                            visible: isother?false:true,
                                            child: Text(
                                              'Add a label',
                                              style: TextStyle(
                                                  fontFamily: AppFonts.poppinsMedium,
                                                  fontSize: responsive(14,context)),
                                            ),
                                          ),
                                          Visibility(
                                            visible: isother?false:true,
                                            child: const SizedBox(
                                              height: 15,
                                            ),
                                          ),
                                          Visibility(
                                            visible: isother?false:true,
                                            child: Row(
                                              children:  [
                                                CustomIconButton(
                                                    imgPath: 'assets/images/homeIcon.svg',
                                                    text: 'Home',
                                                    ontap: () {
                                                      addListner = [true, false,false,];
                                                      addlocation = 'Home';
                                                      setState(() {});
                                                    },
                                                    color: addListner[0] == true
                                                        ? AppColors.GlobelColor
                                                        :Colors.white,
                                                    color2: addListner[0] == true
                                                        ? Colors.white
                                                        : AppColors.GlobelColor


                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                CustomIconButton(
                                                    imgPath: 'assets/images/workIcon.svg',
                                                    text: 'Office',
                                                    ontap: () {
                                                      addListner = [false, true, false,];
                                                      addlocation = 'Office';
                                                      setState(() {});
                                                    },
                                                    color: addListner[1] == true
                                                        ? AppColors.GlobelColor
                                                        :Colors.white,
                                                    color2: addListner[1] == true
                                                        ? Colors.white
                                                        :AppColors.GlobelColor

                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),

                                                CustomIconButton(
                                                    imgPath: 'assets/images/plusIcon.svg',
                                                    text: 'Other',
                                                    ontap: () {
                                                      addListner = [false, false,true, ];
                                                      addlocation = 'Other';



                                                      setState(() {});
                                                    },
                                                    color: addListner[2] == true
                                                        ?AppColors.GlobelColor
                                                        :Colors.white,
                                                    color2: addListner[2] == true
                                                        ? Colors.white
                                                        :AppColors.GlobelColor

                                                ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],

                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: responsive(5, context),
                left: responsive(10, context),
                child: Container(
                  padding: EdgeInsets.all(responsive(8,context)),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 40,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    shape: BoxShape.circle,

                  ),
                  child: const BackIconButton(),
                ),
              ),
              Positioned(
                top: responsive(70, context),
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    child: ErrorMesssage(isVisible: value.vissible??false, message: value.message??'',onTap: (){
                      print('clicked');
                      setState(() {
                        value.closepop();
                      });},),
                  ),
                ),
              ),
              Visibility(
                visible: isother?false:true,
                child: Container(
                  height: 70,
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child:Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 42,vertical: 15),
                    child:isdot?LoadingDots(isfrombooking:false):PrimaryButton(
                        btnText: isdot?'...':'Save',
                        onPressed:
                        isdot==false?() {

                          LocationControllers.saveAdd(
                              areabyhumen: area,
                              floor: unit,
                              context: context,
                              areabygoogle: _street ?? DataController?.Streats,
                              city: _city ?? DataController?.locality,
                              state: DataController?.administrativeArea,
                              lat: lat.toStringAsFixed(6),
                              long: long.toStringAsFixed(6),
                              contry: DataController?.country,
                              type: addlocation ?? 'Home',
                              add: add ?? DataController?.currentAddress).then((value) {
                            if(value == true && user.userfrombooking){
                              // Get.until((route) => Get.currentRoute == '/Rtobook');
                              Navigator.pop(context);
                              Navigator.pop(context);

                            } else if(value == true && !user.userfrombooking){
                              Get.off(HomeScreen());
                            }


                          }

                          );
                        }:(){

                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
      );}
    );
  }
  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    mapController?.setMapStyle(_mapStyle);
  }


// _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
//   MarkerId markerId = MarkerId(id);
//   Marker marker =
//   Marker(markerId: markerId, icon: descriptor, position: position);
//   markers[markerId] = marker;
// }



}

class CustomTextField extends StatelessWidget {
  final String hintText;
  var text;
  var onchange;
  CustomTextField({
    required this.hintText,
    this.onchange,
    this.text,
    super.key,
  });



  @override
  Widget build(BuildContext context) {

    return TextFormField(
      // initialValue: text??'',
      onChanged: onchange,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: responsive(5,context), horizontal: responsive(10,context)),
        hintText: hintText,
        hintStyle: TextStyle(
            fontFamily: AppFonts.poppinsMedium,
            color: const Color(0xff646363),
            fontSize: responsive(14,context)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color(0xFFB1B1B1),
            width: 2.0,
          ),
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final String imgPath;
  final String text;
  var  ontap,color,color2;

  CustomIconButton({Key? key, required this.imgPath, required this.text,this.ontap,this.color,this.color2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Column(
        children: [
          Container(
            height: responsive(45,context),
            width: responsive(45,context),
            alignment: Alignment.center,
            decoration:  BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 3),
                    color: Colors.black26,
                    blurRadius: 3.0,
                  ),
                ]),

            child: SvgPicture.asset(
              height: responsive(25,context),
              width: responsive(22.78,context),
              imgPath,
              color: color2,
            ),
          ),
          const SizedBox(height: 5,),
          Text(
            text,
            style:
            TextStyle(fontSize: responsive(14,context), fontFamily: AppFonts.poppinsMedium),
          ),
        ],
      ),
    );
  }
}

class AddressSearch extends SearchDelegate<Suggestion> {
  final sessionToken;

  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  PlaceApiProvider? apiClient;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Get.back();
        // close(context,null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print(Localizations.localeOf(context).languageCode);
    return FutureBuilder<List<dynamic>>(
      future: query == ""
          ? null
          : apiClient!.fetchSuggestions(
          query, Localizations.localeOf(context).languageCode),
      builder: (context, snapshot) => query == ''
          ? Container(
        padding: const EdgeInsets.all(16.0),
        child: const Text('Enter your address'),
      )
          : snapshot.hasData
          ? ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title:
          Text((snapshot.data![index] as Suggestion).description),
          onTap: () async {
            close(context, await snapshot.data![index] as Suggestion);
          },
        ),
        itemCount: snapshot.data!.length,
      )
          : Container(child: const Text('Loading...')),
    );
  }
}



class LocationMarkerContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SvgPicture.asset(
          height: 40.94,
          width: 30.14,
          'assets/images/locc.svg',

        ),
        // Icon(
        //   Icons.location_on,
        //   size: 60,
        //   color: Colors.blue,
        // ),
        // Positioned(
        //   top:10,
        //   child: CircleAvatar(
        //     radius: 13,
        //     backgroundColor: Colors.white,
        //     child: CachedNetworkImage(
        //       imageUrl: "https://pixlr.com/images/index/remove-bg.webp",
        //       placeholder: (context, url) => CircularProgressIndicator(),
        //       errorWidget: (context, url, error) => Icon(Icons.error),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
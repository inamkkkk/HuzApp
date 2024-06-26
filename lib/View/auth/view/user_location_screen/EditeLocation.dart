import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:huz/Responsive/ResponsiveClass.dart';


import 'package:provider/provider.dart';

import 'package:uuid/uuid.dart';

import '../../../../Loading/loading.dart';
import '../../../../TextStyles/AppFonts.dart';
import '../../../../TextStyles/Color.dart';
import '../../../../Widgets/BouncingMarker.dart';
import '../../../../Widgets/animatedText/animatedText.dart';
import '../../../../Widgets/back_button.dart';

import '../../../../Widgets/primary_button.dart';
import '../../../../widgets/error_message_popup/error_message.dart';
import '../../Controller/MapsController/MapsController.dart';
import '../../Controller/SaveAddController/SaveAddController.dart';
import '../../auth_widgets/auth_header_text.dart';
import '../../controller/location_controller.dart';

import 'package:geocoding/geocoding.dart' as geocode;

import 'package:flutter/services.dart' show rootBundle;



class EditeUserLocationScreen extends StatefulWidget {
  var isedite,lat,long,id,index,add,area,areabygoogle,city,state,contry,type,unit;
  EditeUserLocationScreen({this.isedite,this.lat,this.long,this.id,this.index,this.area,this.areabygoogle,this.contry,this.state,this.type,this.unit,this.city,this.add}) ;

  @override
  State<EditeUserLocationScreen> createState() => _EditeUserLocationScreenState();
}

class _EditeUserLocationScreenState extends State<EditeUserLocationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _coontroller;
  late Animation<double> _animation;
  String? _mapStyle;
  double _mapHeight = 300.0;
  double _iconHeight = 300.0;
  var addlocation;
  final _controller = TextEditingController();
  var lat,long,id,index,add,area,areabygoogle,city,state,contry,type,unit;
  LocationController? DataController ;
  GoogleMapController? mapController;
  BitmapDescriptor? sourceIcon;
  BitmapDescriptor? destinationIcon;
  Set<Marker> markers = {};

  var i =null;
  var _streetNumber,_street,  _city;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  static final String androidKey = 'AIzaSyDXhTeQMQqZPVa4mwzf4_C65OPjxaSNNKQ';
  var _markerLocation;
  var isdot=false;
  List<bool> addListner = [false,false,false,false];
  Future<void> getLatlng() async {
    print(widget.lat);
    try {
      print('jar de shu ${widget.lat}');
      print('inam2');
      if(widget.lat==null){
        DataController = await Provider.of<LocationController>(context,listen: false);
        await DataController?.getCurrentLocation();
        lat = await Provider.of<LocationController>(context, listen: false).lat;
        long = await Provider.of<LocationController>(context, listen: false).long;
        add = DataController?.currentAddress;
      }else{
       // addlocation =[widget.type == 'Home'?true:false,widget.type == 'Work'?true:false,widget.type == 'Grocery'?true:false,widget.type=='Other'?true:false];
        lat = double.parse('${lat??widget.lat}');
        long = double.parse('${long??widget.long}');

        print('${addlocation}');
      }
      _markerLocation = LatLng(lat, long);
      print('inam3');
      // markers.add( Marker(
      //   markerId: MarkerId("marker_1"),
      //   position: _markerLocation,
      //   infoWindow: InfoWindow(
      //     title: 'hold to change location',
      //   ),
      //   draggable: true,
      //   icon: await LocationMarkerContainer().toBitmapDescriptor(),
      //   onDragEnd: (LatLng newPosition) async {
      //     await Provider.of<LocationController>(context,listen: false).getAddressFromLatLong(newPosition.latitude,newPosition.longitude);
      //     add = DataController?.currentAddress;
      //     setState(()  {
      //       _markerLocation = newPosition;
      //       mapController?.animateCamera(
      //         CameraUpdate.newCameraPosition(
      //           CameraPosition(
      //             target: _markerLocation,
      //             zoom: 19.0,
      //           ),
      //
      //         ),
      //       );
      //
      //     });
      //   },
      //
      // ));

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

  Future<void> onCameraMove(CameraPosition position) async {
    lat = null;
    long = null;
    DataController?.setlatAndlOng(lats:position.target.latitude,longs:position.target.longitude);
    long = position.target.longitude;
    lat = position.target.latitude;
    setState(() {
      isdot = true;
    });
    print('inamder');

  }
  @override
  Widget build(BuildContext context) {
    var LocationControllers = Provider.of<SaveAddressController>(context,listen: false);
    return Consumer2<SaveAddressController,LocationController>(builder: (context, value,location, child) {
      if (location.lat==null) {
        location.getCurrentLocation();
      lat = location.lat;
      long = location.long;
      }
      _markerLocation = LatLng(lat,long);
      // if(add == null) add =  location.currentAddress;
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
                            add = await location.getAddressFromLatLong(lat,long);
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
                        // SvgPicture.asset(
                        //   height: 40.94,
                        //   width: 30.14,
                        //   'assets/images/locc.svg',
                        //
                        // ),

                      ],
                    ),),
                  ExpandableContainer(
                    initialHeight:  responsive(370, context),  // initial height of the container
                    maxHeight:  responsive(680, context),
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
                                                  headerText: 'Update address')),
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
                                                    initialvalue: widget.area??'',
                                                    onchange: (value){
                                                      area = value;
                                                    },
                                                    hintText: 'Area',
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          CustomTextField(

                                            initialvalue: widget.unit==null?widget.unit:'',
                                              onchange: (value){
                                                unit = value;
                                              },
                                              hintText: 'Floor/Unit#'),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'Add a label',
                                            style: TextStyle(
                                                fontFamily: AppFonts.poppinsMedium,
                                                fontSize: responsive(14,context)),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children:  [
                                              CustomIconButton(
                                                  imgPath: 'assets/images/homeIcon.svg',
                                                  text: 'Home',
                                                  ontap: () {
                                                     i = 1;
                                                    addListner = [true, false,false,false];
                                                    addlocation = 'Home';
                                                    setState(() {});
                                                  },
                                                  color: i==null? widget.type == 'Home'?
                                                   AppColors.GlobelColor
                                                  :Colors.white :
                                                  addListner[0] == true
                                                      ? AppColors.GlobelColor
                                                      :Colors.white,
                                                  color2: i==null? widget.type == 'Home'?
                                                  Colors.white:
                                                  AppColors.GlobelColor

                                                      :
                                                  addListner[0] == true
                                                      ? Colors.white
                                                      : AppColors.GlobelColor


                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              CustomIconButton(
                                                  imgPath: 'assets/images/workIcon.svg',
                                                  text: 'Work',
                                                  ontap: () {
                                                    i=1;
                                                    addListner = [false, true, false,false];
                                                    addlocation = 'Work';
                                                    setState(() {});
                                                  },
                                                  color:  i==null? (widget.type == 'Work'?
                                                  AppColors.GlobelColor
                                                      :Colors.white

                                                  ) :(addListner[1] == true
                                                      ? AppColors.GlobelColor
                                                      :Colors.white
                                                  ),
                                                  color2:  i==null? (widget.type == 'Work'?
                                                  Colors.white:
                                                  AppColors.GlobelColor

                                                  )
                                                      :(addListner[1] == true
                                                      ? Colors.white
                                                      : AppColors.GlobelColor
)
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              CustomIconButton(
                                                  imgPath: 'assets/images/store.svg',
                                                  text: 'Grocery',
                                                  ontap: () {
                                                    i = 1;
                                                    addListner = [false, false, true,false];
                                                    addlocation = 'Grocery';
                                                    setState(() {});
                                                  },
                                                  color:  i==null? (widget.type == 'Grocery'?
                                                  AppColors.GlobelColor
                                                      :Colors.white

                                                  ) :(addListner[2] == true
                                                      ? AppColors.GlobelColor
                                                      :Colors.white),
                                                  color2:  i==null? widget.type == 'Grocery'?
                                                  Colors.white:
                                                  AppColors.GlobelColor

                                                      :addListner[2] == true
                                                      ? Colors.white
                                                      : AppColors.GlobelColor

                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              CustomIconButton(
                                                  imgPath: 'assets/images/plusIcon.svg',
                                                  text: 'Other',
                                                  ontap: () {
                                                    i = 1;
                                                    addListner = [false, false,false, true];
                                                    addlocation = 'Other';
                                                    setState(() {});
                                                  },
                                                  color:  i==null? widget.type == 'Other'?
                                                  AppColors.GlobelColor
                                                      :Colors.white :addListner[3] == true
                                                      ? AppColors.GlobelColor
                                                      :Colors.white,
                                                  color2: i==null? widget.type == 'Other'?
                                                           Colors.white:
                                                  AppColors.GlobelColor

                                                      : addListner[3] == true
                                                      ? Colors.white
                                                      : AppColors.GlobelColor

                                              ),
                                            ],
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
                top: 17 ,
                left: 10 ,
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
                top: 70 ,
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
              Container(
                height: 70,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child:Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 42,vertical: 15),
                  child:isdot?LoadingDots(isfrombooking: false,):PrimaryButton(
                      btnText: isdot?'...':'Save',
                      onPressed:
                      isdot==false?() {
                        LocationControllers.EditeAddress(

                          isedite:widget.isedite,
                            areabyhumen: area??widget.area,
                            floor: unit??widget.unit,
                            context: context,
                            areabygoogle: _street ?? DataController?.Streats??widget.areabygoogle,
                            city: _city ?? DataController?.locality??widget.city,
                            addressid: widget.id,
                            state: DataController?.administrativeArea??widget.state,
                            lat: lat.toStringAsFixed(6)??widget.lat.toStringAsFixed(6),
                            long: long.toStringAsFixed(6)??widget.long.toStringAsFixed(6),
                            contry: DataController?.country,
                            type: addlocation ??widget.type ?? 'Home',
                            add: add ?? DataController?.currentAddress??widget.add);
                      }:(){

                      }),
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
  var initialvalue;
  CustomTextField({
    required this.hintText,
    this.onchange,
    this.text,
    this.initialvalue,
    super.key,

  });



  @override
  Widget build(BuildContext context) {

    return TextFormField(
      initialValue: initialvalue??'',
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
            height:responsive(45,context),
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
        //                 placeholder: (context, url) =>Icon(Icons.person,size: responsive(100, context),color: Colors.grey,),
        //                 errorWidget: (context, url, error) => Icon(Icons.person,size: responsive(100, context),color: Colors.grey,),
        //                 imageUrl: '${url}', // replace with the URL of your image
        //                 fit: BoxFit.cover,
        //                 // width: 100,
        //                 // height: 100,
        //               ),
        //   ),
        // ),
      ],
    );
  }
  
}
class homemarker extends StatelessWidget
{
  var url,distance;
  homemarker({this.url,this.distance});
  @override
  Widget build(BuildContext context) {
    print('distance is : ${distance}');
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // Container(
        //   height: 60,
        //   width: 40,
        //
        //   child: Align(
        //     alignment: Alignment.bottomCenter,
        //     child: Text('${distance.toStringAsFixed(2)}',style: TextStyle(
        //       fontSize: 12,
        //       color: Colors.black,
        //
        //     ),),
        //   ),
        // ),
        SvgPicture.asset(
          height: 40.94,
          width: 30.14,
          'assets/images/locc.svg',

        ),



      ],
    );
  }
}
//     SvgPicture.asset(
//       height: 56.94,
//       width: 51.76,
//       'assets/images/hmrkrg.svg',
//     ),
//     Positioned(
//       top:4,
//       child:  Container(
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.5),
//           color: Colors.grey[100],
//
//           //   image:  CachedNetworkImage(
//           //     placeholder: (context, url) =>Icon(Icons.person,size: 30,color: Colors.grey,),
//           //     errorWidget: (context, url, error) => Icon(Icons.person,size: 30,color: Colors.grey,),
//           //     imageUrl: '${baseUrl.baseURL + url}', // replace with the URL of your image
//           //     fit: BoxFit.cover,
//           //     width: 30,
//           //     height: 30,
//           //   ) as ImageProvider,
//           // ), // set the background color of the container
// ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(10.0),
//             // Add circular border to Image
//             child: Image.network(
//               'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRV9L7AvRP4F8Gzzewp2YVujrlZNjSq91l8LJ_WXwVc&s',
//               height: 38.5,
//               width: 36.5,
//               fit: BoxFit.cover,
//               loadingBuilder: (BuildContext context, Widget child,
//                   ImageChunkEvent? loadingProgress) {
//                 if (loadingProgress != null) {
//                   return Icon(
//                           Icons.person,
//                           size: 38,
//                           color: Colors.grey,
//                         );
//                 }
//                 else{
//                   return child;
//                 }
//                 // else {
//                 //   return Icon(
//                 //     Icons.person,
//                 //     size: 38,
//                 //     color: Colors.grey,
//                 //   );
//                 // }
//               },
//               // errorBuilder: (context, error, stackTrace) {
//               //   return Icon(
//               //     Icons.person,
//               //     size: 38,
//               //     color: Colors.grey,
//               //   );
//               // },
//             ),
//           ),
//         )),
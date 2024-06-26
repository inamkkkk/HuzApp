import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:huz/Responsive/ResponsiveClass.dart';
import 'package:huz/TextStyles/AppFonts.dart';
import 'package:huz/View/Booking/View/RequestToBook.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../Controller/pakagecontroller.dart';
import '../../../TextStyles/Color.dart';
import '../../../TextStyles/styles.dart';
import '../../../utils/servecies.dart';
import '../../Booking/Controller/BookingediteController/BookingEditeController.dart';
import '../../Home/widgets/CustomTabs.dart';
import '../../Home/widgets/MainPackages.dart';
import '../../auth/view/sign_up_with_mobile_number/signup_with_mobile_num.dart';

class Details extends StatefulWidget {
  var token;
   Details({super.key,required this.token});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var selected=0;

  Widget bottombar(){
    return Consumer2<pakagecontrollers,Bookingedite>(
        builder: (context, packages,booking,child){
        return InkWell(
          onTap:(){
            booking.price = packages.details?.packageCost;
            booking.subtractprice = packages.details?.packageCost;
            booking.notifyListeners();
            // Get.to(SignUpWithMobile());
            Get.to(RequestToBook());
          },
          child: Container(
            height:responsive(55, context),
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.GlobelColor,
                  width: 2.0, // Adjust border width as needed
                ),
              ),
              color: AppColors.GlobelColor,
            ),


            // notchMargin: 20,
            // shape: const CircularNotchedRectangle(),
            // notchMargin: 20,
            child: Center(
              child: Heading44(
                text: 'Book Now',
                context: context,
                center: true,
                color: Colors.white
              ),
            )
          ),
        );
      }
    );
  }
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<pakagecontrollers>(
        builder: (context, packages, child){

          if(packages.details==null){
            packages.GetDetails(widget.token,context);

          }
          var pkg = packages.details?.hotelDetail;
        return Scaffold(

          appBar: AppBar(
            backgroundColor: Colors.white,
            // elevation: 01,
            centerTitle: true,
            leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding:  EdgeInsets.all(responsive(20, context)),
                  child: SvgPicture.asset(
                    width: responsive(10, context),
                    height: responsive(12, context),
                    'images/arrowback.svg',
                    semanticsLabel: 'vector',
                    // fit: BoxFit.fitHeight,
                  ),
                )

              ) ,
           title: Heading2(
              center: false,
              context: context,
              text: 'Package Detail',
            ),

          ),
          body:  packages.isApiCalled ==false && packages.details == null?Container(
            height: MediaQuery.sizeOf(context).height,
            child: Center(child: CircularProgressIndicator(color: AppColors.GlobelColor,),),):Stack(

            alignment: Alignment.bottomCenter,
            children: [
           SingleChildScrollView(
             // physics: BouncingScrollPhysics(),
             child:Container(
               child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [



                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Divider(
                                thickness: responsive(4.0, context),
                                color: Color(0xffF2F2F2),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical:responsive(0, context),horizontal: responsive(20, context)),
                                child: Column(


                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  // SizedBox(height: responsive(20, context),),
                                  //  MainPicture(url: packages.details?.hotelDetail,),
                                  SizedBox(height: responsive(20, context),),


                                  Headertitle(context,packages.details?.packageName,
                                     "${formatDateString(packages.details?.startDate)} to${formatDateString(packages.details?.endDate)}",packages.details?.packageCost),
                                  SizedBox(height: responsive(10, context),),

                                  // SizedBox(height: responsive(05, context),),
                                  Row(children: [
                                    BoxWidget('${packages.details?.madinahNights}','Medina Nights',context,),
                                    SizedBox(width: responsive(10, context),),
                                    BoxWidget('${packages.details?.meccaNights}','Meca Nights',context,),
                                  ],),
                                  SizedBox(height: responsive(10, context),),

                                  // Text("The economic package Includes visa, comprehensive insurance, accommodation for 5 nights in Makkah's hotel 1.5 km from Haram, and transportation. The offer is for a limited time only"),

                                  Discription(
                                    center: false,
                                    context: context,
                                    color: AppColors.grayboxcolor,
                                    text: '${packages.details?.description}',
                                  ),

                                  SizedBox(height: responsive(10, context),),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:responsive(350,context),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                          Heading4(
                                            center: false,
                                            context: context,
                                            text: 'Included',
                                          ),
                                            Wrap(
                                              spacing: 0.0,

                                              children: List.generate(
                                                packages.include.length,
                                                    (index) => index ==0 ?  customFonts(text: "Includes: ", size: 10, color: AppColors.primaryBlackColor, fontWeight: FontWeight.bold, context: context):  customFonts(
                                                    text: "${packages.include[index]}",
                                                    size: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.primaryBlackColor,
                                                    context: context),
                                              ),
                                            ),

                                            // Heading4(
                                            //   center: false,
                                            //   context: context,
                                            //   text: 'Exclude',
                                            // ),
                                            // Wrap(
                                            //   spacing: 10.0, // Adjust spacing between elements
                                            //   // runSpacing: 5.0,
                                            //
                                            //   children: packages.exclude,
                                            // ),


                                          ],),
                                      ),
                                      //

                                    ],
                                  ),

                                  SizedBox(height: responsive(10, context),),
                                  Row(
                                    children: [
                                      HotelWidget('images/kaba.png','Mecca hotel',context,clicklist[0]?Color(0xffCCE9E2):Colors.white,(){
                                        clicklist[0]=true;
                                        clicklist[1]=false;
                                        print("click list : $clicklist");
                                        setState(() {

                                        });
                                      }),
                                      SizedBox(width: responsive(10, context),),
                                      HotelWidget('images/madina.png','Madinah hotel',context,clicklist[0]?Colors.white:Color(0xffCCE9E2),(){
                                        clicklist[0]=false;
                                        clicklist[1]=true;
                                        print("click list : $clicklist");
                                        setState(() {

                                        });
                                      }),
                                    ],
                                  ),


                                  SizedBox(height: responsive(0, context),),

                                ],
                                                      ),
                              ),
                            ],
                          ),
                        ),
         clicklist[0]==true&&pkg?[0].hotelCity == 'Mecca'?

        Padding(
          padding:  EdgeInsets.only(left:responsive(20, context),right: responsive(15, context)),

          child: InkWell(
          child: MainPackagess(url: 0,title: pkg?[0].hotelName,subtitle: pkg?[0].roomSharingType,amount: pkg?[0].hotelRating,service: pkg?[0].isShuttleServicesIncluded,distance: "${pkg?[0].hotelDistance}${pkg?[0].distanceType}",city:pkg?[0].hotelCity)),
          ): clicklist[0]==true&&pkg?[1].hotelCity == 'Mecca'?

         Padding(
           padding:  EdgeInsets.only(left:responsive(20, context),right: responsive(15, context)),

           child: InkWell(

               child: MainPackagess(url: 1,title: pkg?[1].hotelName,subtitle: pkg?[1].roomSharingType,amount: pkg?[1].hotelRating,service: pkg?[1].isShuttleServicesIncluded,distance: "${pkg?[1].hotelDistance}${pkg?[1].distanceType}",city:pkg?[1].hotelCity)),
         ):


         clicklist[1]==true && pkg?[0].hotelCity == 'Madinah'?
         Padding(
           padding:  EdgeInsets.only(left:responsive(20, context),right: responsive(15, context)),

           child: InkWell(

               child: MainPackagess(url: 0,title: pkg?[0].hotelName,subtitle: pkg?[0].roomSharingType,amount: pkg?[0].hotelRating,service: pkg?[0].isShuttleServicesIncluded,distance:"${pkg?[0].hotelDistance}${pkg?[0].distanceType}",city:pkg?[0].hotelCity)),
         ):
         clicklist[1]==true&&pkg?[1].hotelCity == 'Madinah'?
         Padding(
           padding:  EdgeInsets.only(left:responsive(20, context),right: responsive(15, context)),

           child: InkWell(

               child: MainPackagess(url: 1,title: pkg?[1].hotelName,subtitle: pkg?[0].roomSharingType,amount: pkg?[1].hotelRating,service: pkg?[1].isShuttleServicesIncluded,distance: "${pkg?[1].hotelDistance}${pkg?[1].distanceType}",city:pkg?[1].hotelCity)),
         ):  Container(
           width: responsive(405, context),
           height: responsive(374, context),
           child: ClipRRect(

             borderRadius: BorderRadius.only(
               topLeft: Radius.circular(responsive(10, context)),
               topRight: Radius.circular(responsive(10, context)),
             ),
             child:CachedNetworkImage(
               imageUrl: "asdasdasdasdsa",
               placeholder: (context, url) => Image.asset('images/placeholder-image.png',
                 fit: BoxFit.cover,
               ),
               errorWidget: (context, url, error) => Image.asset('images/placeholder-image.png',
                 fit: BoxFit.cover,
               ),
               fit: BoxFit.cover,
             ),),),



                        // Container(
                        //
                        //   height: responsive(450, context),
                        //   decoration: BoxDecoration(
                        //     // color: Colors.white,
                        //     // boxShadow : [BoxShadow(
                        //     //     color: Color.fromRGBO(0, 0, 0, 0.18000000715255737),
                        //     //     offset: Offset(0,4),
                        //     //     blurRadius: 30
                        //     // )],
                        //   ),
                        //
                        //   child: ListView.builder(
                        //       physics: BouncingScrollPhysics(),
                        //       shrinkWrap: true,
                        //       primary: true,
                        //       scrollDirection:Axis.horizontal,
                        //       itemCount: packages.details?.hotelDetail?.length,
                        //       itemBuilder: (context,i){
                        //
                        //         print(pkg?.length);
                        //         if (pkg?[i].hotelCity == 'Madinah' && clicklist[0]==false) {
                        //           print('in madina');
                        //           return Padding(
                        //             padding: EdgeInsets.only(
                        //                 left: i == 0
                        //                     ? responsive(20, context)
                        //                     : 0.0,
                        //                 right: responsive(15, context)),
                        //             child: InkWell(
                        //               // onTap: (){
                        //               //   packages.details = null;
                        //               //   packages.notifyListeners();
                        //               //   Get.to(Details(token: pkg?.huzToken));
                        //               // },
                        //                 child: MainPackagess(
                        //                   url: i,
                        //                   title: pkg?[i].hotelName,
                        //                   subtitle: pkg?[i].hotelCity,
                        //                   amount: pkg?[i].hotelRating,
                        //                   service:
                        //                   pkg?[i].isShuttleServicesIncluded,
                        //                 )),
                        //           );
                        //         }else
                        //         if(clicklist[0]==true&&pkg?[i].hotelCity == 'Mecca'){
                        //           print('in makah');
                        //           return Padding(
                        //             padding:  EdgeInsets.only(left: i == 0?responsive(20, context):0.0,right: responsive(15, context)),
                        //
                        //             child: InkWell(
                        //               // onTap: (){
                        //               //   packages.details = null;
                        //               //   packages.notifyListeners();
                        //               //   Get.to(Details(token: pkg?.huzToken));
                        //               // },
                        //                 child: MainPackagess(url: i,title: pkg?[i].hotelName,subtitle: pkg?[i].hotelCity,amount: pkg?[i].hotelRating,service: pkg?[i].isShuttleServicesIncluded,)),
                        //           );
                        //
                        //
                        //         }
                        //
                        //         // else  return   Container(
                        //         //     width: responsive(400, context),
                        //         //     height: responsive(374, context),
                        //         //     color: Colors.white,
                        //         //     child: CachedNetworkImage(
                        //         //       imageUrl: "asdasdasd",
                        //         //       placeholder: (context, url) => Image.asset('images/errorimage.jpeg',
                        //         //         fit: BoxFit.cover,
                        //         //       ),
                        //         //       errorWidget: (context, url, error) => Image.asset('images/errorimage.jpeg',
                        //         //         fit: BoxFit.cover,
                        //         //       ),
                        //         //       fit: BoxFit.cover,
                        //         //     ),
                        //         //
                        //         //   );
                        //
                        //         // else{
                        //         //   return Padding(
                        //         //     padding:  EdgeInsets.only(left: i == 0?responsive(20, context):0.0,right: responsive(15, context)),
                        //         //
                        //         //     child: InkWell(
                        //         //       // onTap: (){
                        //         //       //   packages.details = null;
                        //         //       //   packages.notifyListeners();
                        //         //       //   Get.to(Details(token: pkg?.huzToken));
                        //         //       // },
                        //         //         child: MainPackagess(url: i,title: pkg?[i].hotelName,subtitle: pkg?[i].hotelCity,amount: pkg?[i].hotelRating,service: pkg?[i].isShuttleServicesIncluded,)),
                        //         //   );
                        //         // }
                        //
                        //         //
                        //         // print("pakge index${?.length}");
                        //
                        //       }),
                        // ),

                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: responsive(20, context)),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              
                              children: [
                                Row(
                                  children: [
                                    Heading4(
                                      center: false,
                                      context: context,
                                      text: '${packages.details?.airlineDetail?[0].airlineName} Airline ',
                                    ),
                                    SizedBox(width: responsive(05, context),),
                                    SvgPicture.asset(
                                      width: responsive(20, context),
                                      height: responsive(20, context),
                                     'images/air.svg',
                                      semanticsLabel: 'vector',
                                      // fit: BoxFit.fitHeight,
                                    ),

                                  ],
                                ),
                                SizedBox(height: responsive(04, context),),
                                Wrap(
                                  spacing: 04.0, // Adjust spacing between elements
                                  // runSpacing: .0,
                          
                                  children: [
                                    Container(
                                        width: responsive(160, context),
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
                                            Discription(
                                              center: false,
                                              text: '${packages.details?.airlineDetail?[0].ticketType} Ticket',
                                              context: context,
                                            ),
                                            SizedBox(width: responsive(02, context),)
                                          ],
                                        )
                                    ),
                                    Container(
                                        width: responsive(170, context),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              width: responsive(12, context),
                                              height: responsive(12, context),
                                              packages.details?.airlineDetail?[0].isReturnFlightIncluded?
                                              'images/include.svg':'images/exclude.svg',
                                              semanticsLabel: 'vector',
                                              // fit: BoxFit.fitHeight,
                                            ),
                                            SizedBox(
                                              width: responsive(08, context),
                                            ),
                                            Discription(
                                              center: false,
                                              text: '${'Return Ticket'}',
                                              context: context,
                                            ),
                                            SizedBox(width: responsive(02, context),)
                                          ],
                                        )
                                    ),



                                  ],

                                ),
//-----------------------//
                                SizedBox(height: responsive(20, context),),
                                Row(
                                  children: [
                                    Heading4(
                                      center: false,
                                      context: context,
                                      text: 'Shared Luxury Bus ',
                                    ),
                                    SizedBox(width: responsive(05, context),),
                                    SvgPicture.asset(
                                      width: responsive(16, context),
                                      height: responsive(16, context),
                                      'images/bus.svg',
                                      semanticsLabel: 'vector',
                                      // fit: BoxFit.fitHeight,
                                    ),

                                  ],
                                ),
                                SizedBox(height: responsive(04, context),),
                                Container(

                                  child: Wrap(
                                    spacing: 10.0, // Adjust spacing between elements
                                    // runSpacing: 5.0,

                                    children: packages.routs,
                                  ),
                                ),
                                SizedBox(height: responsive(20, context),),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(responsive(15, context)),
                                              topRight: Radius.circular(responsive(15, context)),
                                        ),
                                            ),
                                          // height: responsive(100, context),
                                          width: MediaQuery.sizeOf(context).width,

                                          child: Padding(
                                            padding:  EdgeInsets.symmetric(vertical: responsive(20, context),horizontal: responsive(20, context)),
                                            child: SingleChildScrollView(

                                              child: Column(
                                                children: [

                                                  Heading4(
                                                    center: false,
                                                    context: context,
                                                    text: 'Mecca & Madina Ziyarah',
                                                  ),
                                                  Container(

                                                    child: Wrap(
                                                      spacing: 10.0, // Adjust spacing between elements
                                                      // runSpacing: 5.0,

                                                      children: packages.ziarat,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: responsive(203, context),
                                    height: responsive(35, context),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: AppColors.GlobelColor,
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(responsive(05, context)),
                                    ),
                                    child: Center(
                                      child: Heading4(
                                          text: 'Mecca & Madinah Ziyarah',
                                          context: context,
                                          center: true
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),




                        SizedBox(
                          height: responsive(100, context),
                        ),


                      ],
                    ),
             ),
           ),
              bottombar(),



            ]
          ),
        );
      }
    );

  }
  Widget HotelWidget(var url,status,context,color,ontap()){
    return InkWell(
      onTap: ontap,
      child: Container(
        // height: MediaQuery.of(context).size.height * (82 / 667),
          width: MediaQuery.of(context).size.width * (145 / 375),
          decoration: BoxDecoration(
            borderRadius : const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
            color : color,
            border : Border.all(
              color:Color(0xff00936C),
              width: 2,
            ),
          ),
          child: Padding(
              padding:  EdgeInsets.symmetric(vertical: responsive(05, context),horizontal: responsive(20, context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [


                  Padding(
                    padding:  EdgeInsets.only(top: responsive(07, context)),
                    child: Text('$status', textAlign: TextAlign.center, style: TextStyle(
                        color: Color.fromRGBO(55, 55, 55, 1),
                        fontFamily: 'Poppins',
                        fontSize: responsive(14, context),
                        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.w500,
                        height: 1
                    ),),
                  ),
                  Spacer(),
                  Image.asset(
                    width: responsive(30, context),
                    height: responsive(30, context),
                    '$url',
                    // fit: BoxFit.fitHeight,
                  ),
                  // Text("$number", textAlign: TextAlign.center, style: TextStyle(
                  //     color: Color.fromRGBO(0, 147, 108, 1),
                  //     fontFamily: AppFonts.poppinsSemiBold,
                  //     fontSize: responsive(30, context),
                  //     letterSpacing: 0 /*p6ercentages not used in flutter. defaulting to zero*/,
                  //     fontWeight: FontWeight.w500,
                  //
                  //     height: 1
                  // ),),
                ],
              ))),
    );

  }
  var clicklist = [
    true,
    false,
  ];
}


Widget Circualbutton(context, url) {
  return Padding(
    padding:  EdgeInsets.only(right: responsive(10, context)),
    child: Container(
      width: responsive(40, context),
      height: responsive(40, context),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, 1),
              blurRadius: 20)
        ],
        color: Color.fromRGBO(242, 245, 250, 1),
        borderRadius: BorderRadius.all(Radius.elliptical(46.125, 45)),
      ),
      child: Padding(
        padding:  EdgeInsets.all(responsive(13, context)),
        child: SvgPicture.asset(
          width: responsive(12, context),
          height: responsive(12, context),
          '$url',
          semanticsLabel: 'vector',
          // fit: BoxFit.fitHeight,
        ),
      ),
    ),
  );
}

Widget Headertitle(context,title,subtitle ,amount){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Heading444(
            center: false,
            context: context,
            text: '${title}',

          ),
          SizedBox(height: responsive(2, context),),
          altcardsubtitle(
              context: context,
              // center: false,
              color: AppColors.black,
              text: '${subtitle}'
          ),
          Row(
            children: [
              Heading44(
                center: false,
                context: context,
                text: 'PKR ${amount.toStringAsFixed(0)}',
                color: AppColors.GlobelColor
              ),
              SizedBox(width: responsive(10, context),),
              alttcardsubtitle(
                  context: context,
                  // center: false,
                  color: AppColors.black,
                  text: 'Per person (VAT Excluded)'
              ),
            ],
          ),



        ],
      ),
      SvgPicture.asset(
        width: responsive(61, context),
        height: responsive(26, context),
        'images/share.svg',
        semanticsLabel: 'vector',
        // fit: BoxFit.fitHeight,
      ),
    ],
  );
}


Widget detailscedualbox(context,date){
  return Container(
      width: responsive(100, context),
      height: responsive(40, context),
      decoration: BoxDecoration(
        borderRadius : BorderRadius.all(
          Radius.circular(responsive(10, context)),
        ),
        color : Color.fromRGBO(255, 253, 253, 1),
        border : Border.all(
          color: AppColors.grayboxcolor,
          width: 1,
        ),
      )
  );
}



Widget BoxWidget(var number,status,context){
  return Container(
    // height: MediaQuery.of(context).size.height * (82 / 667),
    width: MediaQuery.of(context).size.width * (164 / 375),
    decoration: BoxDecoration(
      borderRadius : const BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
        bottomLeft: Radius.circular(5),
        bottomRight: Radius.circular(5),
      ),
      color : Color(0xffF2F2F3),
      border : Border.all(
        color:Color(0xffDCDCDC),
        width: 2,
      ),
    ),
    child: Padding(
      padding:  EdgeInsets.symmetric(vertical: responsive(10, context),horizontal: responsive(20, context)),
      child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                Text('$status', textAlign: TextAlign.center, style: TextStyle(
                    color: Color.fromRGBO(55, 55, 55, 1),
                    fontFamily: 'Poppins',
                    fontSize: responsive(14, context),
                    letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.w500,
                    height: 1
                ),),
            Spacer(),
                Text("$number", textAlign: TextAlign.center, style: TextStyle(
                    color: Color.fromRGBO(0, 147, 108, 1),
                    fontFamily: AppFonts.poppinsSemiBold,
                    fontSize: responsive(30, context),
                    letterSpacing: 0 /*p6ercentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.w500,

                    height: 1
                ),),
              ],
            )));

}

Widget HotelWidget(var url,status,context){
  return Container(
    // height: MediaQuery.of(context).size.height * (82 / 667),
      width: MediaQuery.of(context).size.width * (145 / 375),
      decoration: BoxDecoration(
        borderRadius : const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
        color : Color(0xffF2F2F3),
        border : Border.all(
          color:Color(0xff00936C),
          width: 2,
        ),
      ),
      child: Padding(
          padding:  EdgeInsets.symmetric(vertical: responsive(10, context),horizontal: responsive(20, context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [


              Padding(
                padding:  EdgeInsets.only(top: responsive(07, context)),
                child: Text('$status', textAlign: TextAlign.center, style: TextStyle(
                    color: Color.fromRGBO(55, 55, 55, 1),
                    fontFamily: 'Poppins',
                    fontSize: responsive(14, context),
                    letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.w500,
                    height: 1
                ),),
              ),
              Spacer(),
              Image.asset(
                width: responsive(30, context),
                height: responsive(30, context),
                '$url',
                // fit: BoxFit.fitHeight,
              ),
              // Text("$number", textAlign: TextAlign.center, style: TextStyle(
              //     color: Color.fromRGBO(0, 147, 108, 1),
              //     fontFamily: AppFonts.poppinsSemiBold,
              //     fontSize: responsive(30, context),
              //     letterSpacing: 0 /*p6ercentages not used in flutter. defaulting to zero*/,
              //     fontWeight: FontWeight.w500,
              //
              //     height: 1
              // ),),
            ],
          )));

}

class MainPackagess extends StatefulWidget {
  var url, title, subtitle, amount,service,distance,city;
  MainPackagess({super.key, this.url, this.title, this.subtitle, this.amount,required this.service,required this.distance,required this.city });

  @override
  State<MainPackagess> createState() => _MainPackagessState();
}

class _MainPackagessState extends State<MainPackagess> {
  var currentImageUrl ="";
  var randomIndex;

  final PageController pageController = PageController();
  int currentIndex = 0;
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<pakagecontrollers>(
        builder: (context, packages, child){
          var data = packages.details?.hotelDetail?[widget.url].hotelPhotos;
        return Padding(
          padding:  EdgeInsets.symmetric(vertical: responsive(20, context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Stack(
                alignment: Alignment.center,
                children: [


                  Container(
                      width: responsive(405, context),
                      height: responsive(374, context),
                      child: ClipRRect(

                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(responsive(10, context)),
                            topRight: Radius.circular(responsive(10, context)),
                        ),
                        child: PageView(
                          controller: pageController,

                          scrollDirection: Axis.horizontal,
                          children: data!.map((item) => Container(
                            width: double.infinity,
                            // color: currentIndex == context.watch<int>() ? Colors.blue : Colors.white,
                            child: CachedNetworkImage(
                              imageUrl: "${NetworkServices.ibaseUrl}${item.hotelPhotos}",
                              placeholder: (context, url) => Image.asset('images/placeholder-image.png',
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Image.asset('images/placeholder-image.png',
                                fit: BoxFit.cover,
                              ),
                              fit: BoxFit.cover,
                            ),
                          )).toList(),
                          onPageChanged: (int index) => setState(() => currentIndex = index),
                        ),

                      )

                  ),





                  Positioned(


                    bottom: responsive(10, context),
                    child: Row(
                      children:  List.generate(data.length, (index) => round(context, index != currentIndex)),
                    ),
                  )

                ],
              ),
              SizedBox(height: responsive(15, context),),
              Row(
                children: [
                  Heading4(
                    text: '${widget.title}',
                    context: context,
                    center: false,
                  ),
                  SizedBox(
                    width: responsive(10, context),
                  ),
                  SvgPicture.asset(
                    width: responsive(12, context),
                    height: responsive(12, context),
                    'images/${widget.amount}.svg',
                    semanticsLabel: 'vector',
                    // fit: BoxFit.fitHeight,
                  ),
                ],
              ),
              SizedBox(height: responsive(03, context),),



              // Padding(
              //   padding:  EdgeInsets.symmetric(horizontal: responsive(5, context)),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Dcardtrailing(
              //         text: '${widget.title}',
              //         center: false,
              //         context: context,
              //       ),
              //
              //       Padding(
              //         padding:  EdgeInsets.symmetric(vertical: 02),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             altcardsubtitle(
              //                 context: context,
              //                 // center: false,
              //                 color: AppColors.black,
              //                 text: '${formatDateString(widget.start)} to ${formatDateString(widget.end)}'
              //             ),
              //
              //             Tcardtrailing(
              //               text: 'Stay 20 days',
              //               center: false,
              //               context: context,
              //             ),
              //           ],
              //         ),
              //       ),
              //       Row(
              //         children: [
              //           Dcardtrailing(
              //             text: 'PKR ',
              //             center: false,
              //             context: context,
              //           ),
              //
              //           cardtrailing(
              //             text: '${widget.amount.toStringAsFixed(0)}',
              //             center: false,
              //             context: context,
              //           ),
              //         ],
              //       ),
              //
              //     ],
              //   ),
              // )
              Padding(
                padding:  EdgeInsets.only(right:responsive(02, context)),
                child: Wrap(
                  spacing: 04.0,
                  children: [
                
                    widgts(
                        '${widget.subtitle}',context,80
                    ),
                    widgts(
                        '${widget.distance??0} from ${widget.city}',context,
                      210,
                    ),
                    Visibility(
                      visible: packages.details?.hotelDetail?[widget.url].isAirCondition?true:false,
                
                      child: widgts(

                      'Air Condition',context,140,
                    ),
                    ),
                
                    Visibility(
                      visible: packages.details?.hotelDetail?[widget.url].isAttachBathroom?true:false,
                      child: widgts(
                          'Attached Bathroom',context,
                        150
                      ),
                    ),
                    Visibility(
                      visible: packages.details?.hotelDetail?[widget.url].isElevator?true:false,
                      child: widgts(
                        'Elevator',context,80
                
                      ),
                    ),
                    Visibility(
                      visible: packages.details?.hotelDetail?[widget.url].isLaundry?true:false,
                      child: widgts(
                        'Laundry',context,80
                      ),
                    ),
                
                    Visibility(
                      visible: packages.details?.hotelDetail?[widget.url].isTelevision?true:false,
                      child: widgts(
                        'Television',context,100
                      ),
                    ),
                
                    Visibility(
                      visible: packages.details?.hotelDetail?[widget.url].isEnglishToilet?true:false,
                      child: widgts(
                        'English toilet',context,140
                      ),
                    ),
                
                    Visibility(
                      visible: packages.details?.hotelDetail?[widget.url].isIndianToilet?true:false,
                      child: widgts(
                        'Indian toilet',context,105
                      ),
                    ),
                    Visibility(
                      visible: packages.details?.hotelDetail?[widget.url].isShuttleServicesIncluded?true:false,
                      child:widgts(
                        'Shuttel service',context,150
                      ),
                    ),
                    Visibility(
                      visible: packages.details?.hotelDetail?[widget.url].isWashroomAmenities?true:false,
                      child: widgts(
                        'Amentities',context,100
                      ),
                    ),
                    Visibility(
                      visible: packages.details?.hotelDetail?[widget.url].isWifi?true:false,
                      child: widgts(
                          'wifi',context,80
                      ),
                    ),
                
                
                  ],
                ),
              )




            ],
          ),
        );
      }
    );
  }
}


Widget widgts(name,context,size){
  return Container(
    width: responsive(size, context),
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
          width:
          responsive(06, context),

        ),

        Discription(
          center: false,
          text: '$name',
          context: context,
        ),
        SizedBox(
          width: responsive(04, context),
        )

      ],
    ),
  );
}

// class customClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.moveTo(0, size.height * 0.2); // Start from top left corner with a slight offset
//     path.lineTo(0, 0);
//     path.arcToPoint(size as Offset, radius: Radius.circular(responsive(15, context))); // Top left corner arc
//     path.lineTo(size.width, 0);
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }









String formatDateString(String inputString) {
  // Parse the input string into a DateTime object
  DateTime dateTime = DateTime.parse(inputString);

  // Format the DateTime object into the desired format
  String formattedDate = DateFormat('dd MMM yyyy').format(dateTime).toLowerCase();

  return formattedDate;
}
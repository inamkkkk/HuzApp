
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:huz/Loading/loading.dart';
import 'package:huz/View/Booking/Controller/BookingediteController/UploadTransectionsController/transectioncontroller.dart';
import 'package:huz/View/Booking/View/payment_verification.dart';
import 'package:huz/View/Home/View/trips/view/booking_detail.dart';
import 'package:huz/View/Home/View/trips/view/user_documents.dart';
import 'package:huz/Widgets/custom_app_bar.dart';
import 'package:huz/Widgets/snackbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../../../Constatns/Constants.dart';
import '../../../../../Controller/pakagecontroller.dart';
import '../../../../../Responsive/ResponsiveClass.dart';
import '../../../../../TextStyles/Color.dart';
import '../../../../../TextStyles/styles.dart';
import '../../../../Booking/Controller/BookingediteController/BookingEditeController.dart';
import '../../../../Booking/View/verify_payment.dart';
import '../../../../Booking/Widgets/progress_widget.dart';
import '../../../../Details/View/Details.dart';
import '../../../../Details/View/detail_screen.dart';
import '../../../../auth/controller/is_user_exist_controller.dart';
import '../../../../auth/controller/otp_message_controller.dart';

class Trips extends StatefulWidget {
  const Trips({super.key});

  @override
  State<Trips> createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  int selectedIndex = 2;

  final List<String> iconPaths = [
    'images/home_icon.svg',
    'images/wishlist_icon.svg',
    'images/trips_icon.svg',
    'images/inbox_icon.svg',
    'images/profile_icon.svg',
  ];
  final List<String> iconTitles = [
    "Explore",
    "Wishlist",
    "Trips",
    "Inbox",
    "Profile",
  ];
  var imagess = [
    'images/muharram.svg',
    'images/kaaba.svg',
    'images/muharram.svg',
  ];
  var selected = 1;
  var lengt = 0;

  bool isBookingEmpty = false;


  @override
  Widget build(BuildContext context) {
    return Consumer4<IsUserExitsController,
        transectioncontroller, Bookingedite, pakagecontrollers>(
        builder: (context, user, transection, booking, pkg, child) {







          if(booking.Blist.isEmpty){
            booking.getbookings(user.isUser?.sessionToken);
          }
          return Scaffold(

          backgroundColor: Colors.white,
          body: booking.Blist.isEmpty && booking.bListsapi == true ? SizedBox(
              height: double.infinity,
              width: double.infinity,

              child:
              Padding(
                padding: EdgeInsets.all(responsive(140, context)),
                child: Image.asset(
                  "images/no_booking_icon.png",
                ),
              )
          ): booking.bListsapi == false? Container(child: Center(child: CircularProgressIndicator(color: AppColors.GlobelColor,))): Padding(


            padding:  EdgeInsets.symmetric(horizontal:responsive(20, context)),
            child: Column(
              children: [

                Expanded(
                  child: ListView.builder(
                    itemCount: booking.Blist.length,
                    itemBuilder: (context, index){

                      var bookingList = [
                        booking.booking?.bookingDocumentsStatus?[0].isAirlineCompleted,
                        booking.booking?.bookingDocumentsStatus?[0].isVisaCompleted,
                        booking.booking?.bookingDocumentsStatus?[0].isHotelCompleted,
                        booking.booking?.bookingDocumentsStatus?[0].isUserPassportCompleted,
                        booking.booking?.bookingDocumentsStatus?[0].isTransportCompleted,
                      ];

                      print("$bookingList");

                      double? calculateCompletionPercentage(var bookingList) {
                        // Count the number of true values in the list
                        int completedCount = bookingList.where((status) => status == true).length;

                        // Calculate the percentage
                        double? percentage = (completedCount / bookingList.length * 100).toDouble();

                        return percentage;
                      }

                      return Padding(
                        padding:  EdgeInsets.only(bottom: responsive(20, context)),
                        child: bookingContainer(
                          percent: calculateCompletionPercentage(bookingList),
                          package: booking.Blist[index].packageName,
                          companyName: 'N/A',
                          status:booking.Blist[index].bookingStatus == "Initialize"?'Not Paid':booking.Blist[index].bookingStatus,
                          cost: formatCurrency(double.parse("${booking.Blist[index].totalPrice}").toInt()) ,
                          startDate: formatDateString(booking.Blist[index].startDate),
                          endDate: formatDateString(booking.Blist[index].endDate),
                          bookingNumber: booking.Blist[index].bookingNumber,
                          adults: booking.Blist[index].adults,
                          childs: booking.Blist[index].child,
                          infents: 0,
                          onTap: (){
                            if(booking.Blist[index].bookingStatus == "Initialize" ){
                              booking.booking = null;
                              booking.getbookingdetail(user.isUser?.sessionToken, booking.Blist[index].bookingNumber).then((value){
                                endLoading();

                               if(value = true){

                                 Get.to(VerifyPaymentScreen());
                               }else {

                                 showSnackbar(context, booking.bmessage);
                               }
                              }
                              );

                            } else {
                              booking.booking = null;
                              booking.getbookingdetail(user.isUser?.sessionToken, booking.Blist[index].bookingNumber).then((value){
                                endLoading();
                                if(value = true){



                                  Get.to(()=> BookingDetail());

                                }
                                else {

                                  endLoading();
                                  showSnackbar(context, 'Error while retriving');

                                }
                              }
                              );

                            }

                          },
                        ),
                      );
                    },
                  ),
                ),
              ],

            ),
          ),
          // body: ListView.builder(
          //     padding: EdgeInsets.all(responsive(20, context)),
          //     itemCount: 1,
          //     itemBuilder: (context, index) => bookingContainer(
          //         package: "Economy Package",
          //         status: "Pending",
          //         date: "25 Jun to 01 Aug",
          //         message: "You can cancel your booking till 6:00 pm 25th of Jun.",
          //         members: "Total 3 members")),
        );
      }
    );
  }

  Widget bookingContainer(
      {
        required var percent,
        required var package,
        required var companyName,
      required var status,
      required var startDate,
      required var endDate,
      required var bookingNumber,
      required var adults,
      required var childs,
      required var infents,
      required var cost,

        bool isPaid = false,
        bool isNotPaid = false,
        bool isUnderReview = false,
        bool isPending = false,
        bool isActive = false,
        bool isRejected = false,
        bool isCompleted = false,
        bool isClose = false,

      required VoidCallback onTap
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(

        decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFEAEAEA), width: 2),
          color: Colors.white,
          borderRadius: BorderRadius.circular(responsive(06, context))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            statusContainer(title: status, bookingNumber: bookingNumber,),
            verticalSpace(5, context),
           Padding(
             padding: EdgeInsets.all(responsive(10, context)),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [

                         customFonts(
                             text: package,
                             size: 16,
                             color: AppColors.primaryBlackColor.withOpacity(0.9),
                             fontWeight: FontWeight.w600,
                             context: context),
                         verticalSpace(5, context),
                         Row(

                           children: [
                             customFonts(
                                 text: startDate,
                                 size: 14,
                                 fontWeight: FontWeight.w500,
                                 color: AppColors.primaryBlackColor.withOpacity(0.9),
                                 context: context),
                             customFonts(
                                 text: " to ",
                                 size: 14,
                                 fontWeight: FontWeight.w500,
                                 color: AppColors.GlobelColor,
                                 context: context),
                             customFonts(
                                 text: endDate,
                                 size: 14,
                                 fontWeight: FontWeight.w500,
                                 color: AppColors.primaryBlackColor.withOpacity(0.9),
                                 context: context),
                           ],
                         ),
                         // verticalSpace(2, context),
                         // customFonts(
                         //     text: companyName,
                         //     size: 12,
                         //     color: AppColors.primaryBlackColor.withOpacity(0.9),
                         //     context: context),
                       ],
                     ),

                     // Stack(
                     //   alignment: Alignment.center,
                     //   children: [
                     //     CircularProgressIndicator(
                     //       value: percent/100, // Convert percentage to a value between 0 and 1
                     //       backgroundColor: Color(0xFFDAE8E5),
                     //       color: AppColors.GlobelColor,
                     //       strokeWidth: responsive(5, context),
                     //     ),
                     //
                     //     customFonts(context: context, text: '${percent == 0.0?0:percent.toInt()}%', color: AppColors.GlobelColor,size: 15, fontWeight: FontWeight.w500,)
                     //
                     //
                     //   ],
                     // ),

                     // Container(
                     //     decoration: BoxDecoration(
                     //       color: AppColors.GlobelColor.withOpacity(0.08),
                     //       borderRadius: BorderRadius.circular(responsive(5, context)),
                     //     ),
                     //     padding: EdgeInsets.symmetric(
                     //         horizontal: responsive(10, context),
                     //         vertical: responsive(5, context)),
                     //     child: customFonts(
                     //         text: status,
                     //         size: 14,
                     //         fontWeight: FontWeight.w500,
                     //         context: context)),
                   ],
                 ),
                 verticalSpace(15, context),
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.end,
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     customFonts(
                         text: "PKR $cost",
                         size: 16,
                         fontWeight: FontWeight.bold,
                         color: AppColors.GlobelColor,
                         context: context),
                     GestureDetector(
                       // onTap: (){},
                       child: Container(
                         alignment: Alignment.center,
                         height: responsive(25, context),
                         width: responsive(50, context),
                         padding: EdgeInsets.symmetric(horizontal: responsive(6, context)),
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(responsive(6, context)),
                             border: Border.all(

                               color: Color(0xFFBBBBBB),
                             )
                         ),
                         child: customFonts(text: "View", size: 14, fontWeight: FontWeight.w500, color: AppColors.GlobelColor, context: context),
                       ),
                     )
                   ],
                 ),
               ],
             ),
           ),

          ],
        ),
      ),
    );
  }



}

class statusContainer extends StatelessWidget {
  final String title;
  var bookingNumber;


  statusContainer({required this.title, required this.bookingNumber});

  // Define your status colors
  final Map<String, Map<String, Color>> statuses = {
    'Pending': {
      'containerColor': Color(0xFFFF9F43).withOpacity(0.16),
      'textColor': Color(0xFFFF9F43),
    },
    'Active': {
      'containerColor': Color(0xFF00936C),
      'textColor': Color(0xFFFFFFFF),
    },
    'Rejected': {
      'containerColor': Color(0xFFF3DBDC),
      'textColor': Color(0xFFEA5455),
    },
    'Completed': {
      'containerColor': Color(0xFF0000FF).withOpacity(0.16),
      'textColor': Color(0xFF6666DF),
    },
    'Close': {
      'containerColor': Color(0xFF808080),
      'textColor': Color(0xFF6A6363),
    },
    'Paid': {
      'containerColor': Color(0xFF00936C).withOpacity(0.10),
      'textColor': Color(0xFF00936C),
    },
    'Not Paid': {
      'containerColor': Color(0xFFFFD390),
      'textColor': Color(0xFF6C5416),
    },
    'Under Review': {
      'containerColor': Color(0xFFFFA500),
      'textColor': Color(0xFFFFFFFF),
    },
    'Confirm': {
      'containerColor': Color(0xFFFFA500),
      'textColor': Color(0xFFFFFFFF),
    },
  };

  // Function to get colors based on status
  Map<String, Color> getStatusColors(String title) {
    return statuses[title] ?? {
      'containerColor': Colors.grey,
      'textColor': Colors.white,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = getStatusColors(title);

    return Container(
        decoration: BoxDecoration(
          color: colors['containerColor']!,
          // border: title == "Paid" ? Border.all(color: Color(0xFF00936C)) : null,
          borderRadius: BorderRadius.vertical(top: Radius.circular(responsive(5, context))),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: responsive(10, context),
            vertical: responsive(10, context)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customFonts(text: "Status", size: 13, color: colors['textColor']!, context: context),

                customFonts(
                    text: title,
                    size: 15,

                    color: colors['textColor']!,
                    fontWeight: FontWeight.bold,
                    context: context),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                customFonts(text: "Booking number", size: 13, color: colors['textColor']!, context: context),

                customFonts(
                    text: bookingNumber,
                    size: 15,

                    color: colors['textColor']!,
                    fontWeight: FontWeight.bold,
                    context: context),
              ],
            ),
          ],
        ));
  }
}

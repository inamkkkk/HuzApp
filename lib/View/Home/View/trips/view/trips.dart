
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
                      return Padding(
                        padding:  EdgeInsets.only(bottom: responsive(20, context)),
                        child: bookingContainer(
                          package: booking.Blist[index].packageName,
                          companyName: 'N/A',
                          status:booking.Blist[index].bookingStatus == "Initialize"?'Not Paid':booking.Blist[index].bookingStatus,
                          cost: formatCurrency(double.parse(booking.Blist[index].packageCost).toInt()) ,
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
           Padding(
             padding: EdgeInsets.all(responsive(20, context)),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [

                         customFonts(
                             text: package,
                             size: 15,
                             color: AppColors.primaryBlackColor.withOpacity(0.9),
                             fontWeight: FontWeight.w600,
                             context: context),
                         // verticalSpace(2, context),
                         // customFonts(
                         //     text: companyName,
                         //     size: 12,
                         //     color: AppColors.primaryBlackColor.withOpacity(0.9),
                         //     context: context),
                       ],
                     ),
                     statusContainer(title: status)
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
                 verticalSpace(5, context),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [

                       customFonts(
                           text: "Start date & End date",
                           size: 10,
                           color: AppColors.primaryBlackColor.withOpacity(0.5),

                           context: context),
                       Row(
                         children: [
                           customFonts(
                               text: startDate,
                               size: 13,
                               fontWeight: FontWeight.w500,
                               color: AppColors.primaryBlackColor.withOpacity(0.9),
                               context: context),
                           customFonts(
                               text: " to ",
                               size: 13,
                               fontWeight: FontWeight.w500,
                               color: AppColors.GlobelColor,
                               context: context),
                           customFonts(
                               text: endDate,
                               size: 13,
                               fontWeight: FontWeight.w500,
                               color: AppColors.primaryBlackColor.withOpacity(0.9),
                               context: context),
                         ],
                       )
                     ],
                   ),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.end,
                     children: [

                       customFonts(
                           text: "Adults & child",
                           size: 10,
                           color: AppColors.primaryBlackColor.withOpacity(0.5),

                           context: context),
                       Row(
                         children: [
                           customFonts(
                               text: "$adults - ",
                               size: 13,
                               fontWeight: FontWeight.w500,
                               color: AppColors.primaryBlackColor.withOpacity(0.9),
                               context: context),
                           customFonts(
                               text: "$childs",
                               size: 13,
                               fontWeight: FontWeight.w500,
                               color: AppColors.primaryBlackColor.withOpacity(0.9),
                               context: context),
                         ],
                       )
                     ],
                   ),
                 ],),
                 verticalSpace(5, context),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                     customFonts(
                         text: "Cost",
                         size: 10,
                         color: AppColors.primaryBlackColor.withOpacity(0.5),

                         context: context),
                     customFonts(
                         text: "PKR $cost",
                         size: 15,
                         fontWeight: FontWeight.bold,
                         color: AppColors.GlobelColor,
                         context: context),
                   ],
                 ),
               ],
             ),
           ),
            Container(
              padding:  EdgeInsets.symmetric(horizontal: responsive(20, context)),
              height: responsive(40, context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(responsive(5, context))
                ),
                color: AppColors.GlobelColor.withOpacity(0.15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  customFonts(
                      text: "Booking number", size: 12, color: Color(0xFF0F654E).withOpacity(0.8), context: context),
                  GestureDetector(
                    onTap: onTap,
                    child: customFonts(
                        text: "$bookingNumber",
                        size: 16,
                        color: Color(0xFF0F654E).withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                        context: context),
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


  statusContainer({required this.title});

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
          border: title == "Paid" ? Border.all(color: Color(0xFF00936C)) : null,
          borderRadius: BorderRadius.circular(responsive(5, context)),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: responsive(10, context),
            vertical: responsive(5, context)),
        child: customFonts(
            text: title,
            size: 14,
            color: colors['textColor']!,
            fontWeight: FontWeight.w500,
            context: context));
  }
}

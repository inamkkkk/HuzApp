
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:huz/View/Booking/Widgets/progress_widget.dart';
import 'package:huz/View/Details/View/detail_screen.dart';
import 'package:huz/Widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../../../Responsive/ResponsiveClass.dart';
import '../../../../../TextStyles/Color.dart';
import '../../../../../TextStyles/styles.dart';
import '../../../../Booking/Controller/BookingediteController/BookingEditeController.dart';
import '../../../../Booking/Widgets/docswwidget.dart';
import '../../../../Complaints/View/RaiseComplaints/RaiseComplaints.dart';
import '../../../../auth/controller/is_user_exist_controller.dart';
import 'UploadUserDocs.dart';



class BookingDetail extends StatefulWidget {

  const BookingDetail({super.key});

  @override
  State<BookingDetail> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  bool isPaymentConfirm = true;
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: isPaymentConfirm || isActive ? bottomWidget(
        onTapReview: (){
          Get.to(raisComplaint());
        },
        onTapComplaint: (){

        }
      ) : const SizedBox(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(
          title: "Booking Detail",

        ),
      ),
      body: Consumer2<IsUserExitsController,Bookingedite>(
          builder: (context, user,booking, child){


            return  SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  color: const Color(0xFFF2F2F2),
                  height: responsive(62, context),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive(20, context),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      verticalSpace(29, context),

                      // Progress Widget
                      ProgressWidget(percentage: 0, companyName: booking.booking?.companyDetail?.companyName, packageName: booking.booking?.packageName),

                      verticalSpace(10, context),


                      // status card
                      statusCard(
                          status: booking.booking?.bookingStatus,
                          bookingNumber: booking.booking?.bookingNumber,
                          context: context),

                      verticalSpace(20, context),

                      // Booking detail container
                      bookingDetailContainer(startDate: formatDateString(booking?.booking?.startDate), endDate:formatDateString(booking?.booking?.endDate) , specialRequest: booking.booking?.specialRequest, adults: booking.booking?.adults, childs: booking.booking?.child, infents: 0),

                      verticalSpace(20, context),

                      // uploadDocuments

                      booking.booking?.bookingStatus == "Paid" || booking.booking?.bookingStatus != "Pending"?
                      Container(
                        alignment: Alignment.center,
                        height: responsive(45, context),
                        decoration: BoxDecoration(
                          color: AppColors.GlobelColor,
                          borderRadius: BorderRadius.circular(responsive(5, context))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("images/id_icon.svg", height: responsive(20, context),),
                            horizontalSpace(6, context),
                            InkWell(
                                onTap: (){
                                  Get.to(UploadRequiredDocs());
                                },
                                child: customFonts(text: booking.booking?.bookingStatus == "Paid" ? "Upload Required Documents" : "Shared Documents" , size: 15, color: Colors.white,context: context))
                          ],
                        ),
                      ):SizedBox() ,

                      verticalSpace(20, context),

                      // Documents containers
                    booking.booking?.bookingStatus == 'Paid'||booking.booking?.bookingStatus == 'Pending'?  SizedBox(): Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              booking.booking!.bookingDocumentsStatus?[0].isVisaCompleted ? Expanded(child: documentContainer(icon: "images/evisa_icon.svg", title: "eVisa", onTap: (){
                                print('inam');
                                showModalBottomSheet(
                                  context: context,
                                    shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                )),
                                  builder: (BuildContext context) {
                                    return Docviewer(
                                      name:'eVisa',
                                      list: booking.booking?.bookingRequiredDocuments,
                                      onSelectCountry: (String country) {
                                        setState(() {
                                          // _countryCodeController.text = country;
                                        });
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                );

                              })) : SizedBox(),
                              booking.booking!.bookingDocumentsStatus?[0].isVisaCompleted ? horizontalSpace(10, context) : SizedBox(),
                              booking.booking!.bookingDocumentsStatus?[0].isAirlineCompleted ? Expanded(child: documentContainer(icon: "images/airline_ticket.svg", title: "Airline Tickets", onTap: (){
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Docviewer(
                                      name:'airline',
                                      list: booking.booking?.bookingRequiredDocuments,
                                      onSelectCountry: (String country) {
                                        setState(() {
                                          // _countryCodeController.text = country;
                                        });
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                );
                              })) : SizedBox(),
                            ],
                          ),
                          // verticalSpace(10, context),
                          // Row(
                          //   children: [
                          //     Expanded(child: documentContainer(icon: "images/hotel_icon_global.svg", title: "Hotel", onTap: (){
                          //       showModalBottomSheet(
                          //         context: context,
                          //         builder: (BuildContext context) {
                          //           return Docviewer(
                          //             name:'Hotel',
                          //             list: booking.booking?.bookingRequiredDocuments,
                          //             onSelectCountry: (String country) {
                          //               setState(() {
                          //                 // _countryCodeController.text = country;
                          //               });
                          //               Navigator.pop(context);
                          //             },
                          //           );
                          //         },
                          //       );
                          //     })),
                          //     horizontalSpace(10, context),
                          //
                          //     Expanded(child: documentContainer(icon: "images/transport_global.svg", title: "Transport", onTap: (){
                          //       showModalBottomSheet(
                          //         context: context,
                          //         builder: (BuildContext context) {
                          //           return Docviewer(
                          //             name:'Transport',
                          //             list: booking.booking?.bookingRequiredDocuments,
                          //             onSelectCountry: (String country) {
                          //               setState(() {
                          //                 // _countryCodeController.text = country;
                          //               });
                          //               Navigator.pop(context);
                          //             },
                          //           );
                          //         },
                          //       );
                          //     })),
                          //   ],
                          // )
                        ],
                      )

                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget documentContainer({required var icon, required var title, required var onTap }){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: responsive(20, context)),
        height: responsive(42, context),
        width: responsive(183, context),
        decoration: BoxDecoration(

            border: Border.all( color: AppColors.GlobelColor,),
            borderRadius: BorderRadius.circular(responsive(5, context))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(icon, height: responsive(20, context),),
            horizontalSpace(6, context),
            customFonts(text: title, size: 13, color: Colors.black,context: context)
          ],
        ),
      ),
    );
  }

  Widget bottomWidget({required var onTapReview, required var onTapComplaint}){
    return Row(
      children: [
        GestureDetector(
          onTap: onTapReview,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width/2,
            height: responsive(51, context),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.GlobelColor),
              )
            ),
            child: customFonts(text: "Review and Feedback", size: 15, fontWeight: FontWeight.w500, color: AppColors.GlobelColor, context: context),
          ),
        ),
        GestureDetector(
          onTap: onTapComplaint,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width/2,
            height: responsive(51, context),
            decoration: const BoxDecoration(
                color: AppColors.GlobelColor
            ),
            child: customFonts(text: "Raise Complaint", size: 15, fontWeight: FontWeight.w500, color: Colors.white, context: context),
          ),
        )
      ],
    );
  }
  Widget statusCard(
      {required var status,
        required var bookingNumber,
        required BuildContext context}) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: responsive(51, context),
      padding: EdgeInsets.symmetric(horizontal: responsive(20, context)),
      alignment: Alignment.centerLeft,
      decoration:  BoxDecoration(
        color: AppColors.GlobelColor.withOpacity(0.15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customFonts(
                  text: "Status",
                  size: 10,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryBlackColor.withOpacity(0.8),
                  context: context),
              customFonts(
                  text: status,
                  size: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlackColor.withOpacity(0.8),
                  context: context)
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customFonts(
                  text: "Booking number",
                  size: 10,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryBlackColor.withOpacity(0.8),
                  context: context),
              customFonts(
                  text: "$bookingNumber",
                  size: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlackColor.withOpacity(0.8),
                  context: context)
            ],
          ),
        ],
      ),
    );
  }
  Widget bookingDetailContainer(
  {

    required var startDate,
    required var endDate,
    required var specialRequest,
    required var adults,
    required var childs,
    required var infents,
}
      ){
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(

          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFEAEAEA), width: 2),
              color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(responsive(20, context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


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
                verticalSpace(10, context),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    customFonts(
                        text: "Special Request",
                        size: 10,
                        color: AppColors.primaryBlackColor.withOpacity(0.5),

                        context: context),
                    customFonts(
                        text: "$specialRequest",
                        size: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryBlackColor.withOpacity(0.9),
                        context: context)
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: responsive(20, context),
          top: responsive(-10, context),
          child: Container(
            color: Colors.white,
            child: customFonts(
                text: "Booking details",
                size: 14,
                color: AppColors.primaryBlackColor.withOpacity(0.9),
                fontWeight: FontWeight.w600,
                context: context),
          ),
        ),
      ],
    );
  }
}

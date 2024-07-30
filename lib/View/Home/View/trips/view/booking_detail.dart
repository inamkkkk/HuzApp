import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:huz/Loading/loading.dart';
import 'package:huz/View/Booking/Widgets/progress_widget.dart';
import 'package:huz/View/Complaints/Controller/Controller/ComplaintController.dart';
import 'package:huz/View/Complaints/View/view/Complaints/Complaints.dart';
import 'package:huz/View/Details/View/detail_screen.dart';
import 'package:huz/Widgets/custom_app_bar.dart';
import 'package:huz/Widgets/snackbar.dart';
import 'package:huz/widgets/primary_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../Rating/rating.dart';
import '../../../../../Responsive/ResponsiveClass.dart';
import '../../../../../TextStyles/AppFonts.dart';
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
  var count = 0;
  var count2 = 0;
 var isapi =false;

  final TextEditingController titleController = TextEditingController();

  final TextEditingController yourSituationController = TextEditingController();


  final FocusNode titleFocusNode = FocusNode();

  final FocusNode yourSituationFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar:bottomWidget(
        onTapReview: (){
         Get.to(RatingAndReviewScreen());
        },
        onTapComplaint: (){
         Get.to(raisComplaint());
        }
      ),

      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: appBarTitle(context: context, text: "Booking Detail"),
        centerTitle: true,
        leading: Consumer3<IsUserExitsController, Bookingedite, Complaintscontroller>(
            builder: (context, user, booking, complaint, child) {
            return GestureDetector(
              onTap:  (){
                Get.back();
              },
              child: Padding(
                padding:  EdgeInsets.all(responsive(20, context)),
                child: SvgPicture.asset(  "images/arrow_back.svg", height: responsive(18, context), width: responsive(27.22, context),),
              ),
            );
          }
        ) ,
      ),
      body: Consumer3<IsUserExitsController, Bookingedite,Complaintscontroller>(
          builder: (context, user, booking, complaints,child) {


        var bookingList = [
          booking.booking!.bookingDocumentsStatus?[0].isAirlineCompleted,
            booking.booking!.bookingDocumentsStatus?[0].isVisaCompleted,
            booking.booking!.bookingDocumentsStatus?[0].isHotelCompleted,
            booking.booking!.bookingDocumentsStatus?[0].isUserPassportCompleted,
            booking.booking!.bookingDocumentsStatus?[0].isTransportCompleted,
        ];

        print("$bookingList");

        double? calculateCompletionPercentage(var bookingList) {
          // Count the number of true values in the list
          int completedCount = bookingList.where((status) => status == true).length;

          // Calculate the percentage
          double? percentage = (completedCount / bookingList.length * 100).toDouble();

          return percentage;
        }






        return SingleChildScrollView(
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
                    ProgressWidget(
                        percentage: calculateCompletionPercentage(bookingList),
                        companyName:
                            booking.booking?.companyDetail?.companyName,
                        packageName: booking.booking?.packageName),

                    verticalSpace(10, context),

                    // status card
                    statusCard(
                        status: booking.booking?.bookingStatus,
                        bookingNumber: booking.booking?.bookingNumber,
                        context: context),

                    verticalSpace(20, context),

                    // Booking detail container
                    bookingDetailContainer(
                        startDate:
                            formatDateString(booking?.booking?.startDate),
                        endDate: formatDateString(booking?.booking?.endDate),
                        specialRequest: booking.booking?.specialRequest,
                        adults: booking.booking?.adults,
                        childs: booking.booking?.child,
                        infents: 0),

                    verticalSpace(20, context),

                    // uploadDocuments

                    // booking.booking?.bookingStatus == "Paid" ||
                    //         booking.booking?.bookingStatus != "Pending"
                    //     ?

                    Container(
                            alignment: Alignment.center,
                            height: responsive(45, context),
                            decoration: BoxDecoration(
                                color: AppColors.GlobelColor,
                                borderRadius: BorderRadius.circular(
                                    responsive(5, context))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "images/id_icon.svg",
                                  height: responsive(20, context),
                                ),
                                horizontalSpace(6, context),
                                InkWell(
                                    onTap: () {
                                      // if (booking.booking?.bookingStatus ==
                                      //         "Paid" ||
                                      //     booking.booking?.bookingStatus ==
                                      //         "Confirm")
                                        Get.to(UploadRequiredDocs());
                                    },
                                    child: customFonts(
                                        text: booking.booking?.bookingStatus ==
                                                    "Paid" ||
                                                booking.booking
                                                        ?.bookingStatus ==
                                                    "Confirm"
                                            ? "Upload Required Documents"
                                            : "User Shared Documents",
                                        size: 15,
                                        color: Colors.white,
                                        context: context))
                              ],
                            ),
                          ),
                        // : SizedBox(),

                    verticalSpace(20, context),

                    // Documents containers
                    booking.booking?.bookingStatus == 'Paid' ||
                            booking.booking?.bookingStatus == 'Pending'
                        ? SizedBox()
                        : Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  booking.booking!.bookingDocumentsStatus?[0]
                                          .isVisaCompleted
                                      ? Expanded(
                                          child: documentContainer(
                                              icon: "images/evisa_icon.svg",
                                              title: "eVisa",
                                              onTap: () {
                                                print('inam');
                                                showModalBottomSheet(
                                                  context: context,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                    top: Radius.circular(20),
                                                  )),
                                                  builder:
                                                      (BuildContext context) {
                                                    return Docviewer(
                                                      name: 'eVisa',
                                                      list: booking.booking
                                                          ?.bookingDocuments,
                                                      onSelectCountry:
                                                          (String country) {
                                                        setState(() {
                                                          // _countryCodeController.text = country;
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                  },
                                                );
                                              }))
                                      : SizedBox(),
                                  booking.booking!.bookingDocumentsStatus?[0]
                                          .isVisaCompleted
                                      ? horizontalSpace(10, context)
                                      : SizedBox(),
                                  booking.booking!.bookingDocumentsStatus?[0]
                                          .isAirlineCompleted
                                      ? Expanded(
                                          child: documentContainer(
                                              icon: "images/airline_ticket.svg",
                                              title: "Airline Tickets",
                                              onTap: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Docviewer(
                                                      name: 'airline',
                                                      list: booking.booking
                                                          ?.bookingDocuments,
                                                      onSelectCountry:
                                                          (String country) {
                                                        setState(() {
                                                          // _countryCodeController.text = country;
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                  },
                                                );
                                              }))
                                      : SizedBox(),

                                ],
                              ),
                              booking.booking?.bookingStatus=="Objection"?

                                  ListView.builder(
                                      primary: true,
                                      shrinkWrap: true,
                                      itemCount: booking?.booking?.bookingObjections?.length,
                                      physics: NeverScrollableScrollPhysics(),

                                      itemBuilder: (context,index){
                                    return  Objectionmodule(yourSituationFocusNode: yourSituationFocusNode, yourSituationController: yourSituationController,index: index,);
                                  })
                             :Container(),
                              SizedBox(height: responsive(40, context),)
                            ],
                          ),
                    // documentContainer(
                    //     icon: "images/evisa_icon.svg",
                    //     title: "Your Complaints",
                    //     onTap: () {
                    //       print('inam');
                    //       showModalBottomSheet(
                    //         context: context,
                    //         shape: RoundedRectangleBorder(
                    //             borderRadius:
                    //             BorderRadius.vertical(
                    //               top: Radius.circular(20),
                    //             )),
                    //         builder:
                    //             (BuildContext context) {
                    //           return Docviewer(
                    //             name: 'eVisa',
                    //             list: booking.booking
                    //                 ?.bookingRequiredDocuments,
                    //             onSelectCountry:
                    //                 (String country) {
                    //               setState(() {
                    //                 // _countryCodeController.text = country;
                    //               });
                    //               Navigator.pop(context);
                    //             },
                    //           );
                    //         },
                    //       );
                    //     })
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget documentContainer(
      {required var icon, required var title, required var onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: responsive(20, context)),
        height: responsive(42, context),
        width: responsive(183, context),
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.GlobelColor,
            ),
            borderRadius: BorderRadius.circular(responsive(5, context))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              icon,
              height: responsive(20, context),
            ),
            horizontalSpace(6, context),
            customFonts(
                text: title, size: 13, color: Colors.black, context: context)
          ],
        ),
      ),
    );
  }

  Widget bottomWidget({required var onTapReview, required var onTapComplaint}) {
    return Consumer2<IsUserExitsController, Bookingedite>(
        builder: (context, user, booking, child) {
          print(booking.booking?.bookingStatus);
        return Visibility(
          visible: booking.booking?.bookingStatus == "Paid"?false:true,
          child: Row(

            children: [
              Visibility(
                visible: booking.booking?.bookingStatus=="Completed"||booking.booking?.bookingStatus == 'Closed'?true:false,
                child: InkWell(
                  onTap: onTapReview,
                  child: Container(
                    alignment: Alignment.center,
                     width: MediaQuery.of(context).size.width/2,
                    height: responsive(51, context),
                    decoration: const BoxDecoration(
                        border: Border(
                      top: BorderSide(color: AppColors.GlobelColor),
                    )),
                    child: customFonts(
                        text: "Review and Feedback",
                        size: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.GlobelColor,
                        context: context),
                  ),
                ),
              ),
              InkWell(
                onTap: onTapComplaint,
                child: Container(
                  alignment: Alignment.center,
                  width:  booking.booking?.bookingStatus=="Completed"||booking.booking?.bookingStatus == 'Closed'?MediaQuery.of(context).size.width/2:MediaQuery.of(context).size.width,
                  height: responsive(51, context),
                  decoration: const BoxDecoration(color: AppColors.GlobelColor),
                  child: customFonts(
                      text: "Raise Complaint",
                      size: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      context: context),
                ),
              )
            ],
          ),
        );
      }
    );
  }

  Widget statusCard(
      {required var status,
      required var bookingNumber,
      required BuildContext context}) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      
      padding: EdgeInsets.symmetric(horizontal: responsive(20, context), vertical: responsive(8, context)),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
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
                  size: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryBlackColor.withOpacity(0.8),
                  context: context),
              verticalSpace(3, context),
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
                  size: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryBlackColor.withOpacity(0.8),
                  context: context),
              verticalSpace(3, context),
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

  Widget bookingDetailContainer({
    required var startDate,
    required var endDate,
    required var specialRequest,
    required var adults,
    required var childs,
    required var infents,
  }) {
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
                            size: 13,
                            color: AppColors.primaryBlackColor.withOpacity(0.8),
                            context: context),
                        Row(
                          children: [
                            customFonts(
                                text: startDate,
                                size: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryBlackColor
                                    .withOpacity(0.9),
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
                                color: AppColors.primaryBlackColor
                                    .withOpacity(0.9),
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
                            size: 13,
                            color: AppColors.primaryBlackColor.withOpacity(0.8),
                            context: context),
                        Row(
                          children: [
                            customFonts(
                                text: "$adults - ",
                                size: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryBlackColor
                                    .withOpacity(0.9),
                                context: context),
                            customFonts(
                                text: "$childs",
                                size: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryBlackColor
                                    .withOpacity(0.9),
                                context: context),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                verticalSpace(10, context),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customFonts(
                        text: "Special Request",
                        size: 13,
                        color: AppColors.primaryBlackColor.withOpacity(0.8),
                        context: context),
                    customFonts(
                        text: "${specialRequest??'N/A'}",
                        size: 14,
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
                size: 16,
                color: AppColors.primaryBlackColor.withOpacity(0.9),
                fontWeight: FontWeight.w600,
                context: context),
          ),
        ),
      ],
    );
  }
}

class Objectionmodule extends StatefulWidget {
   Objectionmodule({
    super.key,
    required this.index,
    required this.yourSituationFocusNode,
    required this.yourSituationController,
  });

  final FocusNode yourSituationFocusNode;
  final TextEditingController yourSituationController;
  var index;

  @override
  State<Objectionmodule> createState() => _ObjectionmoduleState();
}

class _ObjectionmoduleState extends State<Objectionmodule> {
  var images;
  final ImagePicker _picker = ImagePicker();

  Future<bool> pickImageobjection() async {
    var status = false;
    // Loading();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      images = File(image.path);
    }
setState(() {

});



    return status;

  }
  final TextEditingController titleController = TextEditingController();

  final TextEditingController yourSituationController = TextEditingController();


  final FocusNode titleFocusNode = FocusNode();

  final FocusNode yourSituationFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {

    return Consumer2<IsUserExitsController, Bookingedite>(
        builder: (context, user, booking, child) {
        return Padding(
          padding:  EdgeInsets.only(bottom: responsive(06, context)),
          child: Container(
            decoration: BoxDecoration(
              // Background color of the container
              border: Border.all(
                color: Color(0xFFEAEAEA), // Border color
                width: 1, // Border width
              ),
              borderRadius: BorderRadius.circular(03.0),
            ),
            child: Padding(
              padding:  EdgeInsets.all(responsive(10, context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customFonts(text: 'Objection', size: 16, context: context,fontWeight: FontWeight.bold,color: Colors.red),
                  SizedBox(height: responsive(05, context),),
                  customFonts(text: 'Remarks or reason: ${booking?.booking?.bookingObjections![widget.index].remarksOrReason}', size: 14, context: context,fontWeight: FontWeight.bold,color: AppColors.grayboxcolor),
                  SizedBox(height: responsive(10, context),),
                  Visibility(
                      visible: booking.booking?.bookingObjections?[widget.index].clientRemarks==null?false:true,
                      child: customFonts(text: 'Client Remarks: ${booking.booking?.bookingObjections?[widget.index].clientRemarks}', size: 14, context: context,fontWeight: FontWeight.bold,color: AppColors.grayboxcolor)),
              Visibility(
                  visible: booking.booking?.bookingObjections?[widget.index].clientRemarks==null?false:true,
                  child: SizedBox(height: responsive(10, context),)),
                  booking.booking?.bookingObjections?[widget.index].clientRemarks!=null?Container():Container(
                    height: responsive(70, context),
                    alignment: Alignment.topLeft,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.lightBrownColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(responsive(5, context)),
                        topLeft: Radius.circular(responsive(5, context)),
                      ),
                    ),
                    child: TextFormField(
                      focusNode: yourSituationFocusNode,
                      controller:yourSituationController,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.start,
                      maxLines: 15,

                      onFieldSubmitted: (value) {},
                      validator: (value) {
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          fontFamily: AppFonts.poppinsMedium,
                          fontSize: responsive(
                              15, context)),
                      cursorColor: AppColors.GlobelColor,
                      decoration: InputDecoration(

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: responsive(15, context),
                          vertical: responsive(10, context),
                        ),
                        hintText: 'Enter your remarks here  ',
                        hintStyle: TextStyle(
                          fontFamily: AppFonts.poppinsMedium,
                          fontSize: responsive(15, context),
                          color: const Color(0xffB1B1B1),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  booking.booking?.bookingObjections?[widget.index].clientRemarks!=null?Container(): SizedBox(height: responsive(10, context),),
                  booking.booking?.bookingObjections?[widget.index].clientRemarks!=null?Container(): InkWell(
                      onTap: (){
                       if(images==null)pickImageobjection();

                      },
                      child: customFonts(text: images==null?'Choose file':"You have selected your file ", size: 14, context: context,fontWeight: FontWeight.bold,color: AppColors.primaryColor)),
                  booking.booking?.bookingObjections?[widget.index].clientRemarks!=null?Container():SizedBox(height: responsive(10, context),),

                  booking.booking?.bookingObjections?[widget.index].clientRemarks!=null? InkWell(
                      onTap: (){
                        url2 = booking?.booking?.bookingObjections?[widget.index].requiredDocumentForObjection;
                        Get.to(showdocs());
                      },
                      child: customFonts(text: "View Document", size: 14, context: context,fontWeight: FontWeight.bold,color: AppColors.primaryColor)): GestureDetector(
                onTap: (){
                  Loading();
                  booking.submitobjection(sessiontoken: booking?.booking?.userSessionToken,bookingnumber: booking?.booking?.bookingNumber,message: yourSituationController.text,objectionid: booking?.booking?.bookingObjections?[widget.index].objectionId,image: images).then((value){
                    if(value == true){
                      endLoading();
                      showSnackbar(context, 'Successfully updated');
                    } else {
                      endLoading();
                      showSnackbar(context, 'Error while updating ');
                    }
                  });
                },
                child: Container(

                  height: responsive(35,context),
                  width: responsive(120, context),

                  decoration: BoxDecoration(
                    color: AppColors.GlobelColor,
                    borderRadius: BorderRadius.circular(responsive(5,context)),),
                  child: Center(
                      child: customFonts(text: 'Submit', size: 13, color: Colors.white, fontWeight: FontWeight.bold, context: context)
                  ),
                ),
              ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

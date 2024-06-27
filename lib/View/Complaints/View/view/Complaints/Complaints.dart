import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:provider/provider.dart';

import '../../../../../Responsive/ResponsiveClass.dart';
import '../../../../../TextStyles/Color.dart';
import '../../../../../TextStyles/styles.dart';
import '../../../../auth/controller/is_user_exist_controller.dart';
import '../../../Controller/Controller/ComplaintController.dart';
import '../../Widgets/complaint_card.dart';
import '../../Widgets/customtabs.dart';
import '../detail_complaint/detail_complaint.dart';

class Complaints extends StatefulWidget {
  const Complaints({super.key});

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  var imageslist = [
    'assets/images/Open.svg',
    'assets/images/progress.svg',
    'assets/images/solved.svg',
    'assets/images/complete.svg',
  ];
  var tabnames = [
    'Open',
    'InProgress',
    'Solved',
    'Close',
  ];

  var cardData = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_pXUxixftq0D8fay2eohJTuKqMPJjsJ0Nsg&s",
    "Ali Khan",
    "Islamabad, Pakistan",
    "Sep 7, 2024",
    "11:00 PM",
    "Hotel Problem",
  ];

  var listed = ['0','0','0','15'];
  var selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffF2F2F2),
      appBar: AppBar(
        centerTitle: true,
        title: appBarTitle(context: context, text: 'Complaints'),
      ),
      body: SingleChildScrollView(
        child: Consumer2<IsUserExitsController,Complaintscontroller>(builder: (context, user,complaints, child) {

          return Container(
              child: Padding(
                padding: EdgeInsets.only(top: responsive(4, context)),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // complaints.isliststatusapiiscalled == false? Padding(
                    //   padding:  EdgeInsets.only(top: responsive(400, context)),
                    //   child: Container(
                    //     height: responsive(30, context),
                    //     width: responsive(30, context),
                    //     child: CircularProgressIndicator(color: AppColors.GlobelColor,),
                    //   ),
                    complaints.result.isEmpty ?Padding(
                      padding:  EdgeInsets.only(top: responsive(400, context)),
                      child: Container(
                        child: textPoppins(text: 'No Complaints',  size: 15, context: context),
                      ),
                    ):

                    Padding(
                      padding: EdgeInsets.only(top: responsive(0, context)),
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height,
                        child: Padding(
                            padding: EdgeInsets.only(top: responsive(20, context)),
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: complaints.result?.length,
                                itemBuilder: (context, index) {
                                  var data = complaints.result?[index];
                                  return GestureDetector(
                                      onTap: () {
                                        Get.to(() => DetailComplaint(
                                            packageName: data?.packageName,
                                            companyName: data?.partnerContactDetail?.companyName,
                                            complaintStatus: data?.complaintStatus,
                                            customerName: data?.userFullName,
                                            location: 'Islamabad, pakistan ',
                                            date: DateFormat('MMM-dd-yyyy').format(DateTime.parse(data?.complaintTime)),
                                            customerPhone: data?.partnerContactDetail?.contactNumber,
                                            time: timeago.format(
                                              DateTime.parse('${data?.complaintTime}'),
                                            ),
                                            audio: data?.audioMessage,
                                            complaintType: data?.complaintTitle,
                                            customerPicture: data?.userPhoto,
                                            complaint: data?.complaintMessage)
                                        );


                                      },
                                      child: ComplaintCard(
                                          index: index,
                                          image: data?.userPhoto,
                                          name:  data?.userFullName,
                                          location: 'islamabad,pakistan',
                                          date: DateFormat('MMM-dd-yyyy').format(DateTime.parse(data?.complaintTime)),
                                          time: timeago.format(
                                            DateTime.parse('${data?.complaintTime}'),
                                          ),
                                          complaintType: cardData[5]));
                                })),
                      ),
                    ),

                    // Top scroll tap bar
                    // SingleChildScrollView(
                    //   physics: const BouncingScrollPhysics(),
                    //   scrollDirection: Axis.horizontal,
                    //   child: Padding(
                    //     padding:
                    //         EdgeInsets.only(top: responsiveHeight(15, context)),
                    //     child: Row(
                    //       children: [
                    //         for (int i = 0; i < imageslist.length; i++)
                    //           InkWell(
                    //             onTap: () async {
                    //               selected = i;
                    //               complaints.result =[];
                    //               complaints.isliststatusapiiscalled = false;
                    //               complaints.notifyListeners();
                    //               setState(() {});
                    //             },
                    //             child: Padding(
                    //               padding: EdgeInsets.only(
                    //                   left: responsive(15, context),
                    //                   right: i == imageslist.length - 1
                    //                       ? responsive(20, context)
                    //                       : 0.0),
                    //               child: CustomTab(
                    //                 count: complaints.list.isNotEmpty?"${complaints.list[i]}":listed[i],
                    //                 url: imageslist[i],
                    //                 text: tabnames[i],
                    //                 isSelected: i == selected, // Set isSelected to true for the initially selected tab
                    //               ),
                    //             ),
                    //           ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}

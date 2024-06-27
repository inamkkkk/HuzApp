import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Responsive/ResponsiveClass.dart';
import '../../TextStyles/AppFonts.dart';
import '../../TextStyles/Color.dart';
import '../../TextStyles/styles.dart';




class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double getWidth(double width) {
      return responsive(width, context);
    }

    return Scaffold(
      backgroundColor: AppColors.lightBrownColor,
      appBar: AppBar(
        title: appBarTitle(context: context, text: "How it is Work"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: getWidth(30), left: getWidth(20), right: getWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How Huz works.',
                style: TextStyle(
                    fontSize: getWidth(18),
                    fontFamily: AppFonts.poppinsMedium),
              ),
              SizedBox(
                height: getWidth(3),
              ),
              Text(
                'Users can create a Booking request by following these steps.',
                style: TextStyle(
                  fontFamily: AppFonts.poppinsRegular,
                  fontSize: getWidth(12),
                ),
              ),
              SizedBox(
                height: getWidth(30),
              ),
              const HowItWorksCard(
                path: '1.svg',
                headText: 'Create a Booking Request',
                bodyText: 'Users can initiate a request to book their hajj or umrah package ',
              ),
              const HowItWorksCard(
                path: '2.svg',
                headText: 'Transerfer payment  ',
                bodyText: 'Once you have booked your package successfully you have to transfer package payment to company account',
              ),
              const HowItWorksCard(
                path: '3.svg',
                headText: 'Submite Documents ',
                bodyText: 'Once you have wired payment you have to sumbmit your documents e.g Passport and Cnic ',
              ),
              const HowItWorksCard(
                path: '4.svg',
                headText: 'Request Approval and collect your document',
                bodyText: "After carefull review by huz team we well approve your request once your request is approved you will recive you traveling document eg eVisa , Airline Tickets etc ",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HowItWorksCard extends StatelessWidget {
  final String path;
  final String headText;
  final String bodyText;
  const HowItWorksCard({
    super.key,
    required this.path,
    required this.headText,
    required this.bodyText,
  });

  @override
  Widget build(BuildContext context) {
    double getWidth(double width) {
      return responsive(width, context);
    }
    return Container(
      padding: EdgeInsets.only(top: getWidth(15), bottom: getWidth(15), left: getWidth(15) , right: 10),
      margin: EdgeInsets.only(bottom: getWidth(15)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(

        children: [
          Align(
            alignment: Alignment.centerRight,
            child: SvgPicture.asset(
              'assets/images/$path',
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                headText,
                style: TextStyle(
                    fontSize: getWidth(14),
                    fontFamily: AppFonts.poppinsSemiBold,
                  color: AppColors.GlobelColor,
                ),
              ),
              SizedBox(
                height: getWidth(3),
              ),
              Text(
                bodyText,
                style: TextStyle(
                  fontFamily: AppFonts.poppinsRegular,
                  fontSize: getWidth(12),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

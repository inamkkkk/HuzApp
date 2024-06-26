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
        title: appBarTitle(context: context, text: "Privacy Policy"),
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
                'How MyCause works.',
                style: TextStyle(
                    fontSize: getWidth(18),
                    fontFamily: AppFonts.poppinsMedium),
              ),
              SizedBox(
                height: getWidth(3),
              ),
              Text(
                'Users can create a campaign request by following these steps.',
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
                headText: 'Generate Request',
                bodyText: 'Users can initiate a request to cover the grocery expenses required to feed their families.',
              ),
              const HowItWorksCard(
                path: '2.svg',
                headText: 'Request Approval',
                bodyText: 'After the request is submitted on MyCause, the request will be thoroughly reviewed.',
              ),
              const HowItWorksCard(
                path: '3.svg',
                headText: 'Receive Donations',
                bodyText: 'Approved requests will be displayed on the application/site so that campaign can be started.',
              ),
              const HowItWorksCard(
                path: '4.svg',
                headText: 'Collect Ration',
                bodyText: "Once the campaign has been successfully completed, rations will be delivered to the respective address.",
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

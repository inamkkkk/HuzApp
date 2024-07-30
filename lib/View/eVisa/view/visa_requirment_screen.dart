import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:huz/Responsive/ResponsiveClass.dart';
import 'package:huz/TextStyles/Color.dart';
import 'package:huz/TextStyles/styles.dart';
import 'package:huz/Widgets/custom_app_bar.dart';

class VisaRequirementScreen extends StatefulWidget {
  const VisaRequirementScreen({super.key});

  @override
  State<VisaRequirementScreen> createState() => _VisaRequirementScreenState();
}

class _VisaRequirementScreenState extends State<VisaRequirementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomBar(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: responsive(20, context),
            right: responsive(20, context), top: responsive(10, context)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header tile
              headerTile(country: "Pakistan", visa: "Umrah Visa", onTap: () {}),
          
              verticalSpace(20, context),
          
              // Visa Requirement Container
              requirementContainer(umraType: "Umrah"),
              verticalSpace(40, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerTile({required country, required visa, required onTap}) {
    return Row(
      children: [
        customFonts(text: "$country  -  ", size: 16, context: context),
        customFonts(text: visa, size: 16, context: context),
        Spacer(),
        GestureDetector(
            onTap: onTap,
            child: customFonts(
                text: "Change",
                size: 16,
                color: AppColors.GlobelColor,
                fontWeight: FontWeight.bold,
                context: context)),
      ],
    );
  }

  Widget requirementContainer({required umraType}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customFonts(
              text: "$umraType Visa Requirements",
              size: 18,
              fontWeight: FontWeight.bold,
              context: context),
          customFonts(
              text:
                  "In order to process your Visa, you will need the following documents. Process time will be 8 days.",
              size: 16,
              context: context),
          verticalSpace(20, context),
          tileContainer(
              icon: Icons.padding,
              title: "Passport 1st and 2nd Page",
              subTitle:
                  "A passport should be valid for more than 6 months for visa processing"),
          verticalSpace(20, context),
          tileContainer(
              icon: Icons.padding,
              title: "NIC / Smart NIC",
              subTitle: "Adult / Child / Infant"),
          verticalSpace(20, context),
          tileContainer(
              icon: Icons.padding,
              title: "Pictures",
              subTitle: "01 passport size picture with white background"),
          verticalSpace(20, context),
          tileContainer(
              icon: Icons.padding,
              title: "Contact Information",
              subTitle: "Emergency contact number"),
          verticalSpace(20, context),
          tileContainer(
              icon: Icons.padding,
              title: "Reservations",
              subTitle: "Tentative flight and hotel reservation provided by HUZ"),
          verticalSpace(20, context),
          tileContainer(
              icon: Icons.padding,
              title: "Family Details",
              subTitle: "Applicants Father and Mother names"),
        ],
      ),
    );
  }

  Widget tileContainer({required icon, required title, required subTitle}) {
    return Row(
      children: [
        Container(
          height: responsive(70, context),
          width: responsive(70, context),
          decoration: BoxDecoration(
              color: AppColors.textColorBlack.withOpacity(0.05),
              shape: BoxShape.circle),
          child: Icon(
            icon,
            color: AppColors.GlobelColor,
            size: responsive(32, context),
          ),
        ),
        horizontalSpace(10, context),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customFonts(
                  text: title,
                  size: 16,
                  fontWeight: FontWeight.bold,
                  context: context),
              customFonts(
                  text: subTitle, size: 16, context: context, maxLines: 2),
            ],
          ),
        )
      ],
    );
  }

  Widget bottomBar(){
    return Container(
      height: responsive(130, context),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(responsive(20, context)),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0,-1),
            blurRadius: 5,

          )
        ]
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customFonts(text: "E-Visa", size: 16, context: context),
          verticalSpace(10, context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customFonts(text: "Starting from", size: 14, context: context),
                  customFonts(text: "PKR 45,000",fontWeight: FontWeight.bold, size: 24, context: context),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.GlobelColor,
                  borderRadius: BorderRadius.circular(responsive(5, context))
                ),
                padding: EdgeInsets.symmetric(horizontal: responsive(70, context), vertical: responsive(15, context)),
                child: customFonts(text: "Apply Now",color: Colors.white,  size: 16, context: context),
              )

            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huz/Responsive/ResponsiveClass.dart';
import 'package:huz/TextStyles/Color.dart';
import 'package:huz/TextStyles/styles.dart';
import 'package:huz/View/eVisa/view/visa_requirment_screen.dart';
import 'package:huz/Widgets/primary_button.dart';

class EVisaScreen extends StatefulWidget {
  const EVisaScreen({super.key});

  @override
  State<EVisaScreen> createState() => _EVisaScreenState();
}

class _EVisaScreenState extends State<EVisaScreen> {
  TextEditingController countryController = TextEditingController();
  TextEditingController visaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsive(20, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(20, context),
          customFonts(
              text: "Get your Visa WIth Ease",
              size: 18,
              fontWeight: FontWeight.bold,
              context: context),
          verticalSpace(20, context),
          textField(
            icon: Icons.location_on_rounded,
              focusNode: null,
              controller: countryController,
              hintText: "Select your nationality"),
          verticalSpace(20, context),
          textField(
            icon: Icons.document_scanner_rounded,
              focusNode: null,
              controller: visaController,
              hintText: "Select Visa type"),
          verticalSpace(40, context),
          PrimaryButton(btnText: "Check Requirment", onPressed: (){
            Get.to(()=> VisaRequirementScreen());
          }),
        ],
      ),
    );
  }

  Widget textField(
      {required focusNode, required controller, required hintText, required icon}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: responsive(10, context)),
      alignment: Alignment.topLeft,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightBrownColor,
        borderRadius: BorderRadius.circular(responsive(5, context))
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.GlobelColor.withOpacity(0.50),),
          Expanded(
            child: TextFormField(
              focusNode: focusNode,
              controller: controller,
              textAlign: TextAlign.start,
            
              onFieldSubmitted: (value) {},
              validator: (value) {
                return null;
              },
              keyboardType: TextInputType.text,
              style: TextStyle(
                  fontFamily: GoogleFonts.cairo().fontFamily,
                  fontSize: responsive(15, context)),
              cursorColor: AppColors.GlobelColor,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: responsive(15, context),
                  vertical: responsive(10, context),
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                  fontFamily: GoogleFonts.cairo().fontFamily,
                  fontSize: responsive(15, context),
                  color: const Color(0xffB1B1B1),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

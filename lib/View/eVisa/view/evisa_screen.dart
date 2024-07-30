import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huz/Responsive/ResponsiveClass.dart';
import 'package:huz/TextStyles/Color.dart';
import 'package:huz/TextStyles/styles.dart';
import 'package:huz/View/eVisa/view/visa_requirment_screen.dart';
import 'package:huz/Widgets/custom_app_bar.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(title: "eVisa",),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: responsive(20, context)),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            SvgPicture.asset("assets/images/tick.svg"),
            horizontalSpace(10, context),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customFonts(
                    text: "Visa Application Received!",
                    size: 24,
                    fontWeight: FontWeight.bold,
                    context: context),
                customFonts(
                    text: "Thank you!",
                    size: 18,
                    fontWeight: FontWeight.bold,
                    context: context),
              ],
            ),
          ],),
          verticalSpace(20, context),

          customFonts(
              text: "You've initiated your Umrah journey. Our Visa team will be in touch with you shortly to collect the necessary details.",
              size: 18,

              context: context),

          verticalSpace(20, context),
         Container(
           padding: EdgeInsets.all(responsive(20, context)),
           decoration: BoxDecoration(
             color: AppColors.GlobelColor.withOpacity(0.05),
             borderRadius: BorderRadius.circular(responsive(10, context)),
             

           ),
           child: Column(
             children: [
               textRow(title: "Terms and Conditions", description: "Please ensure you read the entire Terms & Conditions"),
               verticalSpace(10, context),textRow(title: "Send Us a Message", description: "Instantly connect with us for all your queries via WhatsApp or chat."),
               verticalSpace(10, context),textRow(title: "Processing Time", description: "Upon submission of your documents, please anticipate a processing time of 48 hours for your visa."),
               verticalSpace(10, context),textRow(title: "Need Help?", description: "Call +92 300 5295917 or WhatsApp +92 300 5295917."),
             ],
           ),
         ),
          verticalSpace(20, context),
          Container(
            padding: EdgeInsets.all(responsive(20, context)),
            decoration: BoxDecoration(
              color: AppColors.GlobelColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(responsive(10, context)),


            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/images/passportConfirm.svg", height: responsive(52, context),),
                    horizontalSpace(20, context),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customFonts(
                              text: "Share with your loved ones!",
                              size: 18,
                              fontWeight: FontWeight.bold,
                              context: context),
                          customFonts(
                              text: "Encourage your loved ones to apply for visas through sastaticket!",
                              size: 16,
                      
                              context: context),
                        ],
                      ),
                    ),
                  ],
                ),
                verticalSpace(20, context),
                Container(
                  padding: EdgeInsets.symmetric(vertical:  responsive(5, context), horizontal: responsive(20, context)),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.GlobelColor,),
                    borderRadius: BorderRadius.circular(responsive(5, context)),
                  ),
                  child: customFonts(
                      text: "Share now",
                      size: 16,

                      context: context),
                ),
              ],
            ),
          ),
          verticalSpace(20, context),
          Container(
            padding: EdgeInsets.all(responsive(20, context)),
            decoration: BoxDecoration(
              color: AppColors.GlobelColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(responsive(10, context)),


            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/images/whatsapp.svg", height: responsive(52, context),),
                    horizontalSpace(20, context),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customFonts(
                              text: "Want to know more?",
                              size: 18,
                              fontWeight: FontWeight.bold,
                              context: context),
                          customFonts(
                              text: "Contact us on our WhatsApp for more assistance.",
                              size: 16,

                              context: context),
                        ],
                      ),
                    ),
                  ],
                ),
                verticalSpace(20, context),
                Container(
                  padding: EdgeInsets.symmetric(vertical:  responsive(5, context), horizontal: responsive(20, context)),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.GlobelColor,),
                    borderRadius: BorderRadius.circular(responsive(5, context)),
                  ),
                  child: customFonts(
                      text: "+92 300 5295917",
                      size: 16,

                      context: context),
                ),
              ],
            ),
          ),
          verticalSpace(20, context),
        ],
      ),
    );
  }

  Column textRow({title, description}) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         Row(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Container(
               height: responsive(6, context),
               width: responsive(6, context),
               decoration: BoxDecoration(
                   shape: BoxShape.circle,
                   color: Colors.black
               ),
             ),
             horizontalSpace(10, context),
             customFonts(
                 text: title,
                 size: 18,
                 fontWeight: FontWeight.bold,
                 context: context),
           ],
         ),
          customFonts(
              text: description,
              textAlign: TextAlign.justify,
              size: 16,
              maxLines: 3,
              context: context),
        ],);
  }

}

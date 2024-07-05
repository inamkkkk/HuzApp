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
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: responsive(20, context), vertical: responsive(10, context)),
        child: Column(
          children: [
            headerTile(country: "Pakistan", visa: "Umrah Visa", onTap: (){}),
          ],
        ),
      ),
    );
  }

  Widget headerTile({required country, required visa, required onTap}){
    return Row(
      children: [
        customFonts(text: "$country  -  ", size: 16, context: context),
        customFonts(text: visa, size: 16, context: context),
        Spacer(),
        GestureDetector(
            onTap: onTap,
            child: customFonts(text: "Change", size: 16, color: AppColors.GlobelColor, fontWeight: FontWeight.bold, context: context)),
      ],
    );
  }

}

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:huz/TextStyles/styles.dart';
import 'package:huz/Widgets/custom_app_bar.dart';

import '../Responsive/ResponsiveClass.dart';
import '../TextStyles/AppFonts.dart';
import '../TextStyles/Color.dart';
import '../View/Complaints/Widgets/textcontroller.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Get.to(()=> RatingAndReviewScreen());
            },
            child: Text("Rating")),
      ),
    );
  }
}

class RatingAndReviewScreen extends StatefulWidget {
  const RatingAndReviewScreen({super.key});

  @override
  State<RatingAndReviewScreen> createState() => _RatingAndReviewScreenState();
}

class _RatingAndReviewScreenState extends State<RatingAndReviewScreen> {

  TextEditingController  huzCommentController = TextEditingController();

  final FocusNode huzFocusNode = FocusNode();
  TextEditingController  partnerCommentController = TextEditingController();

  final FocusNode partnerFocusNode = FocusNode();


  bool isTitleValidated = true;
  bool isYourSituationValidated = true;

  String message = '';
  bool isValidated = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar
        (
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(
          title: "Huz Rating & Reviews",
        ),
      ),
      body: ListView(

        children: [
          Container(
            color: AppColors.lightBrownColor,
            height: responsive(47, context),
            padding: EdgeInsets.symmetric(
                horizontal: responsive(20, context)),
            alignment: Alignment.centerLeft,
            child: customFonts(text: "Rating", size: 16, fontWeight: FontWeight.bold, color: Colors.black, context: context),
          ),
          verticalSpace(20, context),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: responsive(20, context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                // ********* Huz concierge
                ratingBar(title: "Huz Concierge",
                    rating: 3.5,
                    onChanged: (value) {},
                    context: context),
                verticalSpace(10, context),

                // ********* Huz support
                ratingBar(title: "Huz Support",
                    rating: 3.5,
                    onChanged: (value) {},
                    context: context),
                verticalSpace(10, context),

                // ********* Huz platform
                ratingBar(title: "Huz Platform",
                    rating: 3.5,
                    onChanged: (value) {},
                    context: context),
                verticalSpace(10, context),

                // ********* Huz service quality
                ratingBar(title: "Huz Service Quality",
                    rating: 3.5,
                    onChanged: (value) {},
                    context: context),
                verticalSpace(10, context),

                // ********* Huz response
                ratingBar(title: "Huz Response",
                    rating: 3.5,
                    onChanged: (value) {},
                    context: context),
                verticalSpace(10, context),

                // ********* Partner total
                ratingBar(title: "Partner Total Stars",
                    rating: 3.5,
                    onChanged: (value) {},
                    context: context),

              ],
            ),
          ),
          verticalSpace(20, context),
          Container(
            color: AppColors.lightBrownColor,
            height: responsive(47, context),
            padding: EdgeInsets.symmetric(
              horizontal: responsive(20, context)),
            alignment: Alignment.centerLeft,
            child: customFonts(text: "Reviews", size: 16, fontWeight: FontWeight.bold, color: Colors.black, context: context),
          ),
          verticalSpace(10, context),
          // commentBox(context),

          addComment(),
        ],
      ),
    );
  }

  Widget commentBox(BuildContext context) {
    return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: responsive(20, context), vertical: responsive(10, context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(responsive(5, context)),
                  color: AppColors.GlobelColor.withOpacity(0.2),
                ),
                  padding: EdgeInsets.symmetric(horizontal: responsive(10, context), vertical: responsive(5, context)),
                  child: customFonts(text: "Huz Comment", size: 14, fontWeight: FontWeight.bold,color: Colors.black, context: context)),
              verticalSpace(5, context),
              customFonts(text:huzComment , size: 15, color: Colors.black, textAlign: TextAlign.justify,context: context),
            ],
          ),
        );
  }
  Row ratingBar({required String title,
    required var rating,
    required var onChanged,
    required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        customFonts(
            text: title, size: 16, color: Colors.black, context: context),
        RatingBar(
          isHalfAllowed: true,
          filledColor: AppColors.GlobelColor,
          halfFilledColor: AppColors.GlobelColor,
          emptyColor: AppColors.GlobelColor.withOpacity(0.50),
          size: responsive(24, context),
          filledIcon: Icons.star_rate_rounded,
          halfFilledIcon: Icons.star_half_rounded,
          emptyIcon: Icons.star_border_rounded,
          onRatingChanged: onChanged,
          initialRating: rating,
          maxRating: 5,
        )
      ],
    );
  }



  Widget addComment() {
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: responsive(20, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customFonts(text: "Huz Comment", size: 14, fontWeight: FontWeight.bold,color: Colors.black, context: context),
          verticalSpace(10, context),
          Container(
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
              focusNode: huzFocusNode,
              controller: huzCommentController,
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.start,
              maxLines: 5,
              onFieldSubmitted: (value) {},
              validator: (value) {
                return null;
              },
              keyboardType: TextInputType.text,
              style: TextStyle(
                  fontFamily: GoogleFonts.cairo().fontFamily,
                  fontSize: responsive(
                      15, context)),
              cursorColor: AppColors.GlobelColor,
              decoration: InputDecoration(

                contentPadding: EdgeInsets.symmetric(
                  horizontal: responsive(15, context),
                  vertical: responsive(10, context),
                ),
                hintText: 'Describe Huz Service',
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


String huzComment = "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.";
String partnerComment = "In publishing and graphic design";
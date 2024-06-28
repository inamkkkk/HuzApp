import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huz/Loading/loading.dart';

import 'package:huz/TextStyles/styles.dart';
import 'package:huz/Widgets/custom_app_bar.dart';
import 'package:huz/Widgets/primary_button.dart';
import 'package:huz/Widgets/snackbar.dart';
import 'package:provider/provider.dart';

import '../Responsive/ResponsiveClass.dart';
import '../TextStyles/AppFonts.dart';
import '../TextStyles/Color.dart';
import '../View/Booking/Controller/BookingediteController/BookingEditeController.dart';
import '../View/Complaints/Widgets/textcontroller.dart';
import '../View/auth/controller/is_user_exist_controller.dart';
import 'Controller/RatingController.dart';

class RatingAndReviewScreen extends StatefulWidget {
  const RatingAndReviewScreen({super.key});

  @override
  State<RatingAndReviewScreen> createState() => _RatingAndReviewScreenState();
}

class _RatingAndReviewScreenState extends State<RatingAndReviewScreen> {
  TextEditingController huzCommentController = TextEditingController();

  final FocusNode huzFocusNode = FocusNode();
  TextEditingController partnerCommentController = TextEditingController();

  final FocusNode partnerFocusNode = FocusNode();

  bool isTitleValidated = true;
  bool isYourSituationValidated = true;

  String message = '';
  bool isValidated = true;
  var conierge = 0,platform = 0, support = 0, huzplatform = 0, quality = 0, response =0,pStars =0 ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(
          title: "Huz Rating & Reviews",
        ),
      ),
      body: Consumer3<IsUserExitsController, Bookingedite,ratingcotroller>(
          builder: (context, user, booking,ratings, child) {
          return ListView(
            children: [
              Container(
                color: AppColors.lightBrownColor,
                height: responsive(47, context),
                padding: EdgeInsets.symmetric(horizontal: responsive(20, context)),
                alignment: Alignment.centerLeft,
                child: customFonts(
                    text: "Rating",
                    size: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    context: context),
              ),
              verticalSpace(20, context),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: responsive(20, context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ********* Huz concierge
                    ratingBar(
                        title: "Huz Concierge",
                        rating: 0.0,
                        onChanged: (value) {
                          conierge = value;

                        },
                        context: context),
                    verticalSpace(10, context),

                    // ********* Huz support
                    ratingBar(
                        title: "Huz Support",
                        rating: 0.0,
                        onChanged: (value) {
                          support = value;
                        },
                        context: context),
                    verticalSpace(10, context),

                    // ********* Huz platform
                    ratingBar(
                        title: "Huz Platform",
                        rating: 0.0,
                        onChanged: (value) {
                          platform = value;
                        },
                        context: context),
                    verticalSpace(10, context),

                    // ********* Huz service quality
                    ratingBar(
                        title: "Huz Service Quality",
                        rating: 0.0,
                        onChanged: (value) {
                          quality = value;
                        },
                        context: context),
                    verticalSpace(10, context),

                    // ********* Huz response
                    ratingBar(
                        title: "Huz Response",
                        rating: 0.0,
                        onChanged: (value) {
                          response = value;
                        },
                        context: context),
                    verticalSpace(10, context),

                    // ********* Partner total
                    ratingBar(
                        title: "Partner Total Stars",
                        rating: 0.0,
                        onChanged: (value) {
                          pStars = value;
                        },
                        context: context),
                  ],
                ),
              ),
              verticalSpace(20, context),
              Container(
                color: AppColors.lightBrownColor,
                height: responsive(47, context),
                padding: EdgeInsets.symmetric(horizontal: responsive(20, context)),
                alignment: Alignment.centerLeft,
                child: customFonts(
                    text: "Reviews",
                    size: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    context: context),
              ),
              verticalSpace(10, context),
              // commentBox(context),

              addComment(),
              verticalSpace(10, context),
              // commentBox(context),

              addComment2(),

              verticalSpace(20, context),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: responsive(20, context)),
                child: PrimaryButton(btnText: 'Submit Ratings ',onPressed: (){
                  ratings.GiveRatings(sessiontoken: user.isUser?.sessionToken, bookingumber: booking.booking?.bookingNumber, concerge: conierge, support: support, platform: platform, quality: quality, responses: response, PStars: pStars, pComment: partnerCommentController.text, huzComent: huzCommentController.text).then((value){
                    endLoading();
                    if(value == true){
                Get.back();
                    }
                    else {
                      showSnackbar(context, ratings.ratingmessage);
                    }
                  });

                },
                ),
              )

            ],
          );
        }
      ),
    );
  }

  Widget commentBox(BuildContext context,) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
          horizontal: responsive(20, context),
          vertical: responsive(10, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(responsive(5, context)),
                color: AppColors.GlobelColor.withOpacity(0.2),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: responsive(10, context),
                  vertical: responsive(5, context)),
              child: customFonts(
                  text: "Huz Comment",
                  size: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  context: context)),
          verticalSpace(5, context),
          customFonts(
              text: huzComment,
              size: 15,
              color: Colors.black,
              textAlign: TextAlign.justify,
              context: context),

        ],
      ),
    );
  }
  Widget huzcomentbox(BuildContext context,) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
          horizontal: responsive(20, context),
          vertical: responsive(10, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(responsive(5, context)),
                color: AppColors.GlobelColor.withOpacity(0.2),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: responsive(10, context),
                  vertical: responsive(5, context)),
              child: customFonts(
                  text: "Partner Comment",
                  size: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  context: context)),
          verticalSpace(5, context),
          customFonts(
              text: huzComment,
              size: 15,
              color: Colors.black,
              textAlign: TextAlign.justify,
              context: context),

        ],
      ),
    );
  }

  Row ratingBar(
      {required String title,
      required var rating,
      required var onChanged,
      required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        customFonts(
            text: title, size: 16, color: Colors.black, context: context),
        Container(
          width: responsive(100, context),
          child: RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              itemSize: responsive(20, context),
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
              itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: AppColors.primaryColor,
                    size: responsive(10, context),
                  ),
              onRatingUpdate: onChanged),
        )
      ],
    );
  }

  Widget addComment() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsive(20, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customFonts(
              text: "Huz Comment",
              size: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              context: context),
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
                  fontSize: responsive(15, context)),
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
  Widget addComment2() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsive(20, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customFonts(
              text: "Partner Comment",
              size: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              context: context),
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
              focusNode: partnerFocusNode,
              controller: partnerCommentController,
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
                  fontSize: responsive(15, context)),
              cursorColor: AppColors.GlobelColor,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: responsive(15, context),
                  vertical: responsive(10, context),
                ),
                hintText: 'Describe Partner Service',
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

String huzComment =
    "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.";
String partnerComment = "In publishing and graphic design";

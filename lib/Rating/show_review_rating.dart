import 'package:custom_rating_bar/custom_rating_bar.dart';
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

class ShowReviewRating extends StatelessWidget {
  final double conierge;
  final double platform;
  var huzComment;
  var partnerComment;
  final double support;
  final double huzplatform;
  final double quality;
  final double response, pStars;

  ShowReviewRating(
      {super.key,
      required this.response,
      required,
      required this.quality,
      required this.platform,
      required this.conierge,
      required this.support,
      required this.huzComment,
      required this.partnerComment,
      required this.huzplatform,
      required this.pStars});

  TextEditingController huzCommentController = TextEditingController();

  final FocusNode huzFocusNode = FocusNode();
  TextEditingController partnerCommentController = TextEditingController();

  final FocusNode partnerFocusNode = FocusNode();

  bool isTitleValidated = true;
  bool isYourSituationValidated = true;

  bool isValidated = true;

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
      body: ListView(
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
                    title: "Huz Concierge", rating: conierge, context: context),
                verticalSpace(10, context),

                // ********* Huz support
                ratingBar(
                    title: "Huz Support", rating: support, context: context),
                verticalSpace(10, context),

                // ********* Huz platform
                ratingBar(
                    title: "Huz Platform", rating: platform, context: context),
                verticalSpace(10, context),

                // ********* Huz service quality
                ratingBar(
                    title: "Huz Service Quality",
                    rating: quality,
                    context: context),
                verticalSpace(10, context),

                // ********* Huz response
                ratingBar(
                    title: "Huz Response", rating: response, context: context),
                verticalSpace(10, context),

                // ********* Partner total
                ratingBar(
                    title: "Partner Total Stars",
                    rating: 5.0,
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
          commentBox(huzComment, context),

          verticalSpace(10, context),
          huzcomentbox(partnerComment, context),
        ],
      ),
    );
  }

  Widget commentBox(
    huzComment,
    BuildContext context,
  ) {
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

  Widget huzcomentbox(
    partnerComment,
    BuildContext context,
  ) {
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
              text: partnerComment,
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
      required double rating,
      required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        customFonts(
            text: title, size: 16, color: Colors.black, context: context),
        RatingBar.readOnly(
          isHalfAllowed: true,
          halfFilledColor: AppColors.GlobelColor,
          halfFilledIcon: Icons.star_half_outlined,
          size: responsive(20, context),
          filledColor: AppColors.primaryColor,
          filledIcon: Icons.star,
          emptyIcon: Icons.star_border,
          initialRating: rating,
          maxRating: 5,
        )
      ],
    );
  }
}

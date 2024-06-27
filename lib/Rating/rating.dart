import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:huz/TextStyles/styles.dart';

import '../Responsive/ResponsiveClass.dart';

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
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(responsive(15, context)),
                        topRight: Radius.circular(responsive(15, context)),
                      ),
                    ),
                    // height: responsive(100, context),
                    width: MediaQuery.sizeOf(context).width,

                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.symmetric(vertical: responsive(10, context)),
                            child: customFonts(
                                text: "Huz Rating",
                                size: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                context: context),
                          ),
                          Divider(color: Colors.black.withOpacity(0.10),height: 0,),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: responsive(20, context),
                                horizontal: responsive(30, context)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  customFonts(
                                      text: "Huz Concierge",
                                      size: 16,
                                      color: Colors.black,
                                      context: context),
                                  RatingBar(
                                    size: responsive(24, context),
                                    filledIcon: Icons.star,
                                    emptyIcon: Icons.star_border,
                                    onRatingChanged: (value) => debugPrint('$value'),
                                    initialRating: 4,
                                    maxRating: 5,
                                  )
                                ],),
                                verticalSpace(20, context),



                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Text("Rating")),
      ),
    );
  }
}

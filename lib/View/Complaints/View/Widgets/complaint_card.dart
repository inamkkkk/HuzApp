import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Responsive/ResponsiveClass.dart';
import '../../../../TextStyles/AppFonts.dart';
import '../../../../TextStyles/Color.dart';
import '../../../../TextStyles/styles.dart';
import '../../../../utils/servecies.dart';


class ComplaintCard extends StatelessWidget {
  final String image;
  final String name;
  final String location;
  final String date;
  final String time;
  final String complaintType;
  final int index;

   ComplaintCard({
    super.key, required this.index,required this.image, required this.name, required this.location, required this.date, required this.time, required this.complaintType,
  });
var baseurl;
  @override
  Widget build(BuildContext context) {
    if(image.contains('/media/')){

      baseurl = '${NetworkServices.ibaseUrl}';

    }else {
      baseurl = '${NetworkServices.ibaseUrl}/media/';
    }
    return Container(
      width: MediaQuery.sizeOf(context).width,
      color: index % 2 == 0 ? const Color(0xffF6F6F6  ) : Colors.white,
      padding: EdgeInsets.only(
        left: responsive(23, context),
        top: responsive(15, context),
        bottom: responsive(15, context),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  placeholder: (context, url) => Image.asset(
                    "assets/images/user_icon.png",
                    height: responsive(45, context),
                  ),

                  errorWidget: (context, url, error) => Image.asset(
                    "assets/images/user_icon.png",
                    height: responsive(45, context),
                  ),
                  imageUrl:
                  '${baseurl}${image}',
                  // replace with the URL of your image
                  fit: BoxFit.cover,
                  width: responsive(45, context),
                  height: responsive(45, context),
                ),
              ),
              horizontalSpace(15,context,),
              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  textPoppins(
                      text: name,
                      size: 16,
                      fontFamily:
                      AppFonts.poppinsSemiBold,
                      color: AppColors.textSecondary.withOpacity(0.8),
                      context: context),
                  textPoppins(
                      text: location,
                      size: 14,
                      fontWeight: FontWeight.w300,
                      color: AppColors.textSecondary.withOpacity(0.8),
                      context: context),
                ],
              ),

            ],
          ),
          verticalSpace(10, context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  textPoppins(
                      text: "Raised date & time",
                      size: 14,
                      fontWeight: FontWeight.w300,
                      color: AppColors.textSecondary.withOpacity(0.8),
                      context: context),

                  Row(
                    children: [
                      textPoppins(
                          text: date,
                          size: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary.withOpacity(0.8),
                          context: context),
                      horizontalSpace( 10, context),
                      textPoppins(
                          text: time,
                          size: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor.withOpacity(0.8),
                          context: context),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: responsive(20, context),
                  vertical: responsive(6, context),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(responsive(5, context))),
                  color: const Color(0xFFC11A1A).withOpacity(0.10),
                ),
                child: textPoppins(text: complaintType, fontWeight: FontWeight.w500 ,size: 14, color: AppColors.textSecondary.withOpacity(0.95) ,context: context),
              )
            ],
          )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../Responsive/ResponsiveClass.dart';
import '../TextStyles/styles.dart';

class CustomAppBar extends StatelessWidget {
  var title;
  var isHome;
  var onPress;
  var ontap;
  CustomAppBar({
    this.title = "",
    this.isHome = false,
    this.onPress,
    this.ontap,

    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: appBarTitle(context: context, text: title),
      centerTitle: true,
      leading: GestureDetector(
        onTap: isHome ? onPress : (){
          Get.back();
        },
        child: InkWell(
          onTap: ontap,
          child: Padding(
            padding:  EdgeInsets.all(responsive(20, context)),
            child: SvgPicture.asset( isHome ?  "images/menu_icon.svg" : "images/arrow_back.svg", height: responsive(18, context), width: responsive(27.22, context),),
          ),
        ),
      ) ,
      actions: [
        isHome ? Padding(
          padding:  EdgeInsets.only(right: responsive(20, context)),
          child: SvgPicture.asset("images/inbox_icon.svg", height: responsive(24, context),),
        ) : SizedBox(),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:huz/Widgets/snackbar.dart';
import 'package:provider/provider.dart';

import '../Loading/loading.dart';
import '../Responsive/ResponsiveClass.dart';
import '../TextStyles/Color.dart';
import '../TextStyles/styles.dart';
import '../View/Booking/Controller/BookingediteController/BookingEditeController.dart';
import '../View/Complaints/Controller/Controller/ComplaintController.dart';
import '../View/Complaints/View/view/Complaints/Complaints.dart';
import '../View/auth/controller/is_user_exist_controller.dart';

class CustomAppBar extends StatelessWidget {
  var title;
  var isHome;
  var isComplaint;
  var onPress;
  var ontap;
  CustomAppBar({
    this.title = "",
    this.isHome = false,
    this.onPress,
    this.ontap,
    this.isComplaint = false,

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
            child: SvgPicture.asset( isHome  || isComplaint?  "images/menu_icon.svg" : "images/arrow_back.svg", height: responsive(18, context), width: responsive(27.22, context),),
          ),
        ),
      ) ,
      actions: [
        isHome ? Padding(
          padding:  EdgeInsets.only(right: responsive(20, context)),
          child: SvgPicture.asset("images/inbox_icon.svg", height: responsive(24, context),),
        ) : SizedBox(),
        isComplaint ?    Consumer3<IsUserExitsController, Bookingedite, Complaintscontroller>(
            builder: (context, user, booking, complaint, child) {
              return Padding(
                padding:  EdgeInsets.only(right: responsive(20, context), top: responsive(2, context)),
                child: GestureDetector(
                    onTap: (){
                      complaint.GetComplaintsbystatus(token: user.isUser?.sessionToken).then((value) {
                        endLoading();
                        if(value == true){
                          Get.to(()=> Complaints());
                        }else{
                          showSnackbar(context, "No complaints yet");
                        }
                      });
                    },
                    child: customFonts(text: "Complaints", size: 16, color: AppColors.GlobelColor, fontWeight: FontWeight.bold, context: context)),
              );
            }
        ) : SizedBox()
      ],
    );
  }
}
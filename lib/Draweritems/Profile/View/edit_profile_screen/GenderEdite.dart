import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../../../Responsive/ResponsiveClass.dart';
import '../../../../TextStyles/AppFonts.dart';
import '../../../../TextStyles/Color.dart';
import '../../../../View/auth/controller/is_user_exist_controller.dart';
import '../../Controllers/EditeProfileController/EditeProfileController.dart';
import '../accountinfo.dart';



class GenderEdite extends StatefulWidget {
  var type;

  GenderEdite({Key? key, this.type}) : super(key: key);

  @override
  State<GenderEdite> createState() => _GenderEditeState();
}

class _GenderEditeState extends State<GenderEdite> {
  var gender;
  var addlocation = [false, false, false];

  @override
  void initState() {
    print(widget.type);
    addlocation = [
      widget.type == 'Male' ? true : false,
      widget.type == 'Female' ? true : false,
      widget.type == 'Other' ? true : false
    ];
    setState(() {});
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IsUserExitsController>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.off(AccountInfo());
            },
            icon: SvgPicture.asset(
              'assets/images/Arrow.svg',
              semanticsLabel: 'vector',
              width: responsive(27, context),
            ),
          ),
          backgroundColor: Colors.white70.withOpacity(0.007),
          title: Text(
            'Set Gender',
            style: const TextStyle(
                fontFamily: AppFonts.poppinsMedium,
                fontSize: 16,
                color: Colors.black),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Provider.of<EditeProfile>(context, listen: false)
                    .Editegender(context, value.isUser?.sessionToken, gender);

                // Get.off(AccountInfo());
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: responsive(60, context),
                  width: responsive(70, context),
                  padding:
                  const EdgeInsets.symmetric( horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: gender != null
                        ? AppColors.GlobelColor
                        : Colors.grey.shade300,
                  ),
                  child: Center(
                    child: Text(
                      'Done',
                      style: TextStyle(
                          color: gender != null
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GenderContainer('Male', () {
                addlocation = [true, false, false];
                gender = 'Male';
                setState(() {});
              }, addlocation[0]),
              SizedBox(
                height: 5,
              ),
              GenderContainer('Female', () {
                gender = 'Female';
                addlocation = [false, true, false];
                setState(() {});
              }, addlocation[1]),
              SizedBox(
                height: 5,
              ),
              GenderContainer('Other', () {
                gender = 'Other';
                addlocation = [false, false, true];
                setState(() {});
              }, addlocation[2]),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Please select your gender.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: AppFonts.poppinsRegular,
                    fontSize: responsive(12, context),
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget GenderContainer(var gender, ontap, visibilty) {
    return InkWell(
      onTap: ontap,
      child: Container(
        color: Colors.white,
        height: responsive(45, context),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$gender',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize:  responsive(14, context),
                    letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.w500,
                    height: 1
                ),
              ),
              Visibility(
                  visible: visibilty,
                  child: Icon(
                    Icons.check,
                    color: AppColors.GlobelColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

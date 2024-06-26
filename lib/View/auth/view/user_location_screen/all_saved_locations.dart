import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:huz/View/auth/view/user_location_screen/user_location_screen.dart';


import 'package:provider/provider.dart';

import '../../../../Responsive/ResponsiveClass.dart';
import '../../../../TextStyles/AppFonts.dart';
import '../../../../TextStyles/Color.dart';
import '../../../../TextStyles/styles.dart';
import '../../../../Widgets/primary_button.dart';
import '../../Controller/LocationListController/Locations.dart';
import 'EditeLocation.dart';


class AllSavedLocations extends StatelessWidget {
  const AllSavedLocations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddList>(builder: (context, value, child) {
      // if(value.Adresses.isEmpty){
      //   value.saveAdd(token)
      // }
      return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.lightBrownColor,
          appBar: AppBar(
            elevation: 2,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: AppBarText(
              text: 'Addresses',
              context: context,
              center: false,
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder: (context) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.Adresses.length,
                    itemBuilder: (context, i) {
                      return AddressContainer(
                        city: value.Adresses[i]?.city,
                        add: value.Adresses[i]?.addressLine2,
                        index: i,
                        id: value.Adresses[i]?.addressId,
                        area: value.Adresses[i]?.streetAddress,
                        contry: value.Adresses[i]?.country,
                        state: value.Adresses[i]?.state,
                        unit: '',
                        areabygoogle: value.Adresses[i]?.streetAddress,
                        lat: value.Adresses[i]?.lat,
                        long: value.Adresses[i]?.long,
                        type: 'Company',
                      );
                    },
                  );
                }
              ),
              BottomAppBar(
                child: InkWell(
                  onTap: () {
                    Get.off(UserLocationScreen(type: 'Home',));
                  },
                  child: PrimaryButton(
                    btnText: 'Add New Address',
                    onPressed: () {
                      Get.to(UserLocationScreen(type: 'Home',));
                    },
                    width: double.infinity,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

class AddressContainer extends StatelessWidget {
  var lat,
      long,
      id,
      index,
      add,
      area,
      areabygoogle,
      city,
      state,
      contry,
      type,
      unit;

  AddressContainer(
      {this.lat,
      this.long,
      this.id,
      this.index,
      this.area,
      this.areabygoogle,
      this.contry,
      this.state,
      this.type,
      this.unit,
      this.city,
      this.add});

  @override
  Widget build(BuildContext context) {
    print(lat);
    print('area by google : $areabygoogle');
    return InkWell(
      onTap: () {
    Get.to(EditeUserLocationScreen(isedite:false,lat: lat,long: long,id: id,add: add,areabygoogle: areabygoogle,area: area,contry: contry,state: state,type: type,city: city,unit: unit,));
      },
      child: Container(

        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal:  responsive(10, context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: SvgPicture.asset(
                          height:  responsive(20.45, context),
                          width:  responsive(19.73, context),
                          'assets/images/locationIcon.svg',
                          semanticsLabel: 'vector',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(
                        width:12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width:  responsive(140, context),
                            child: Text(
                              '$areabygoogle',overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: AppFonts.poppinsBold,
                                  fontSize:
                                       responsive(12, context)),
                            ),
                          ),
                          Text(
                            '$type',
                            style: TextStyle(
                                fontFamily: AppFonts.poppinsRegular,
                                fontSize:
                                     responsive(12, context)),
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 200,
                            ),
                            child: Container(
                              width:  responsive(300, context),
                              child: Text(
                                '$add',
                                maxLines: 4,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: AppFonts.poppinsRegular,
                                    fontSize:  responsive(12, context)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top:  responsive(3, context)),
                        child: SvgPicture.asset(
                          height:  responsive(18,context),
                          width:  responsive(18,context),
                          'assets/images/editIcon.svg',
                          semanticsLabel: 'vector',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      // SizedBox(width:  responsive(13, context),),
                      // SvgPicture.asset(
                      //   height:  responsive(21, context),
                      //   width:  responsive(21, context),
                      //   'assets/images/delete.svg',
                      //   semanticsLabel: 'vector',
                      //   fit: BoxFit.fitWidth,
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 2.5,
            ),

            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey.shade400,
              height: 1,
              width: double.maxFinite,
            ),
          ],
        ),
      ),
    );
  }
}

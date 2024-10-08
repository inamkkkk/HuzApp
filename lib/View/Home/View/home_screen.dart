import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:huz/Controller/HotelJsonLoader.dart';
import 'package:huz/Draweritems/how_it_works_screen/how_it_works_screen.dart';
import 'package:huz/Draweritems/privay_policy_terms_conditions/privacy_policy_screen.dart';
import 'package:huz/Draweritems/privay_policy_terms_conditions/terms_and_conditions.dart';
import 'package:huz/TextStyles/Color.dart';
import 'package:huz/TextStyles/styles.dart';
import 'package:huz/View/Booking/View/payment_verification.dart';
import 'package:huz/View/Details/View/detail_screen.dart';
import 'package:huz/View/Home/View/inbox/inbox.dart';
import 'package:huz/View/Home/View/trips/view/trips.dart';
import 'package:huz/View/auth/controller/is_user_exist_controller.dart';
import 'package:huz/View/eVisa/view/evisa_screen.dart';
import 'package:huz/View/eVisa/view/visa_requirment_screen.dart';
import 'package:huz/View/hajj_umrah_guide/hajj_guide.dart';
import 'package:huz/View/hajj_umrah_guide/model/umrah_guide.dart';
import 'package:huz/View/hajj_umrah_guide/umra_guide_detal_screen.dart';
import 'package:huz/View/search_br/search_bar.dart';
import 'package:huz/View/wishlist/controller/wishlist_controller.dart';
import 'package:huz/View/wishlist/model/wishlist_model.dart';
import 'package:huz/Widgets/snackbar.dart';
import 'package:provider/provider.dart';

import '../../../Constatns/Constants.dart';
import '../../../Controller/pakagecontroller.dart';
import '../../../Draweritems/Profile/View/accountinfo.dart';
import '../../../Responsive/ResponsiveClass.dart';
import '../../../Widgets/custom_app_bar.dart';
import '../../../main.dart';
import '../../../utils/servecies.dart';
import '../../TransportPageWidgets/View/Transport.dart';
import '../../auth/view/sign_up_with_mobile_number/signup_with_number.dart';
import '../../wishlist/view/wishlist.dart';
import '../widgets/Home_banners/HomeBanners.dart';
import '../widgets/Searchwidget.dart';

class HomeScreen extends StatefulWidget {
  int selectedIndex;

  HomeScreen({super.key, this.selectedIndex = 0});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // for shared preference






  final List<String> iconPaths = [
    'images/home_icon.svg',
    'images/wishlist_icon.svg',
    'images/trips_icon.svg',
    'images/inbox_icon.svg',
    'images/profile_icon.svg',
  ];
  final List<String> iconTitles = [
    "Explore",
    "Wishlist",
    "Trips",
    "Inbox",
    "Profile",
  ];
  var imagess = [
    'images/muharram.svg',
    'images/kaaba.svg',
    'images/muharram.svg',
  ];

  var lengt = 0;


  Widget bottombar(user) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xffE8E8E8),
            width: 2.0, // Adjust border width as needed
          ),
        ),
        color: Colors.white,
      ),
      height: responsive(75, context),

      // notchMargin: 20,
      // shape: const CircularNotchedRectangle(),
      // notchMargin: 20,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: responsive(10, context),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(height: responsive(1.8, context), width: double.infinity, color: const Color(0xFFB2B2B2),),
            Padding(
              padding: EdgeInsets.only(
                  bottom: responsive(02, context),
                  left: responsive(20, context),
                  right: responsive(20, context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < iconPaths.length; i++)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (i == 4) {
                            if (user.isUser != null)
                              Get.to(AccountInfo());
                            else
                              Get.to(SignUpWithNumber());
                          } else
                            widget.selectedIndex = i;
                        });
                        if (widget.selectedIndex == 0) {
                          // _loadTasks();
                        }
                      },
                      child: Container(
                        // width: responsive(50, context),
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (i == 3)
                              Badge(
                                label: const Text(
                                  "1",
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: AppColors.GlobelColor,
                                isLabelVisible: true,
                                child: SvgPicture.asset(
                                  iconPaths[i],
                                  height: responsive(28, context),
                                  width: responsive(28, context),
                                  color: widget.selectedIndex == i
                                      ? AppColors.GlobelColor
                                      : Colors.grey[600],
                                ),
                              ),
                            if (i != 3)
                              SvgPicture.asset(
                                iconPaths[i],
                                height: responsive(28, context),
                                width: responsive(28, context),
                                color: widget.selectedIndex == i
                                    ? AppColors.GlobelColor
                                    : AppColors.black,
                              ),
                            SizedBox(
                              height: responsive(6, context),
                            ),
                            Text(
                              iconTitles[i],
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: responsive(13, context),
                                color: widget.selectedIndex == i
                                    ? AppColors.GlobelColor
                                    : AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawertile({var ontap, text, context}) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          '$text',
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Color.fromRGBO(18, 18, 18, 1),
              fontFamily: 'Poppins',
              fontSize: responsive(15, context),
              letterSpacing: 0,
              fontWeight: FontWeight.w500,
              height: 1),
        ),
      ),
    );
  }





  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Consumer2<pakagecontrollers, IsUserExitsController>(
        builder: (context, packagecontroller, user, child) {
      if (packagecontroller.package == null &&
          packagecontroller.fromtabs == false) {
        packagecontroller.Getpackages('Umrah');
      }

      return Scaffold(
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: <Widget>[
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: responsive(40, context),
                          // specify the radius of the circular container
                          backgroundColor: Colors.grey[100],
                          // set the background color of the container
                          child: ClipOval(
                            child: CachedNetworkImage(
                              placeholder: (context, url) => Image.asset(
                                "assets/images/guest_icon.png",
                              ),
                              errorWidget: (context, url, error) =>
                                  Image.asset("assets/images/guest_icon.png"),
                              imageUrl:
                                  '${NetworkServices.ibaseUrl}${user.isUser?.userPhoto}',
                              // replace with the URL of your image
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: user.isUser == null
                              ? responsive(20, context)
                              : responsive(20, context),
                        ),
                        Text(
                          user.isUser?.name ?? 'Guest Account',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: responsive(15, context),
                              letterSpacing: 0,
                              //percentages not used in flutter. defaulting to zero/,
                              fontWeight: FontWeight.bold,
                              height: 1),
                        ),
                        SizedBox(
                          height: responsive(5, context),
                        ),
                        user.isUser != null
                            ? InkWell(
                                onTap: () async {
                                  await prefs.remove('phone');
                                  user.isUser = null;
                                  user.notifyListeners();
                                  Get.offAll(HomeScreen());
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: responsive(05, context)),
                                  child: Text(
                                    'Log out',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: AppColors.GlobelColor,
                                        fontFamily: 'Poppins',
                                        fontSize: responsive(14, context),
                                        letterSpacing: 0,
                                        //percentages not used in flutter. defaulting to zero/,
                                        fontWeight: FontWeight.bold,
                                        height: 1),
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                  drawertile(
                      text: 'Profile',
                      ontap: () {
                        user.isUser == null
                            ? Get.to(SignUpWithNumber())
                            : Get.to(AccountInfo());
                      },
                      context: context),
                  drawertile(
                      text: 'Umrah Guide',
                      ontap: () {
                        Get.to(UmrahGuide());
                      },
                      context: context),
                  drawertile(
                      text: 'How It Works',
                      ontap: () {
                        Get.to(HowItWorksScreen());
                      },
                      context: context),
                  drawertile(
                      text: 'Terms And Conditions',
                      ontap: () {
                        Get.to(TermsAndConditions());
                      },
                      context: context),
                  drawertile(
                      text: 'Privacy Polices',
                      ontap: () {
                        Get.to(PrivacyPolicy());
                      },
                      context: context),
                ],
              ),

              // Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     const SizedBox(height: 20,),
              //     Align(
              //       alignment: AlignmentDirectional.bottomStart,
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.symmetric(
              //                 horizontal: 20, vertical: 10),
              //             child: SvgPicture.asset(
              //               'assets/images/logo.svg',
              //               semanticsLabel: 'vector',
              //               height: responsive(40, context),
              //               width: responsive(50, context),
              //             ),
              //           ),
              //           textPoppins(
              //               context: context,
              //               text: "Powerd by Huz",
              //               size: 16,
              //               fontFamily: AppFonts.poppinsMedium)
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: CustomAppBar(
            isHome: widget.selectedIndex == 2 ? false : true,
            isComplaint: widget.selectedIndex == 2 ? true : false,
            onPress: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            title: widget.selectedIndex == 1
                ? "Wishlist"
                : widget.selectedIndex == 2
                    ? "My Bookings"
                    : widget.selectedIndex == 3
                        ? "Notification"
                        : "",
          ),
        ),
        bottomNavigationBar: bottombar(user),
        backgroundColor: Colors.white,
        body: Consumer2<pakagecontrollers, hotelcontroller>(
            builder: (context, packagecontroller, hotel, child) {
          // if (packagecontroller.package == null) {
          //   packagecontroller.Getpackages('Umrah');
          // }

          return widget.selectedIndex == 0
              ? HomeButton(packagecontroller: packagecontroller, hotel: hotel)
              : widget.selectedIndex == 1
                  ? WishListScreen()
                  : widget.selectedIndex == 2
                      ? Trips()
                      : widget.selectedIndex == 3
                          ? InboxScreen()
                          : SizedBox();
        }),
      );
    });
  }

  // var startDate = "24-oct-2024", endDate =  ;

  // List list = ["package 1", "Package 2", "Package 3"];

  // Widget homeButton(BuildContext context, pakagecontrollers packagecontroller,
  //     hotelcontroller hotel) {
  //   return SafeArea(
  //       child: SingleChildScrollView(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         verticalSpace(10, context),
  //
  //         // Search bar
  //         InkWell(
  //           onTap: () {
  //             Get.to(() => SearchBarScreen());
  //           },
  //           child: Padding(
  //             padding:
  //                 EdgeInsets.symmetric(horizontal: responsive(20, context)),
  //             child: Search(context: context, onchange: (value) {}),
  //           ),
  //         ),
  //
  //         // TabBar
  //
  //         Padding(
  //           padding: EdgeInsets.only(
  //               left: responsive(20, context), top: responsive(29, context)),
  //           child: Row(
  //             children: List.generate(
  //                 tabList.length,
  //                 (index) => Padding(
  //                       padding:
  //                           EdgeInsets.only(right: responsive(10, context)),
  //                       child: tabBarContainer(
  //                           context: context,
  //                           index: index,
  //                           onTap: () {
  //                             setState(() {
  //                               isSelect = index;
  //                               print(isSelect);
  //                             });
  //
  //                             packagecontroller.isApiCalled = false;
  //                             // packagecontroller.package =null;
  //                             packagecontroller.fromtabs = true;
  //                             packagecontroller.notifyListeners();
  //                             if (index == 3) {
  //                               packagecontroller.GetTransport();
  //                             } else {
  //                               // await Future.delayed(Duration(milliseconds: 500));
  //                               packagecontroller.Getpackages(tabList[index]);
  //                             }
  //                           },
  //                           text: tabList[index],
  //                           isSelect: isSelect),
  //                     )),
  //           ),
  //         ),
  //
  //         packagecontroller.isApiCalled == false
  //             ? Padding(
  //                 padding: EdgeInsets.only(top: responsive(300, context)),
  //                 child: Container(
  //                   child: Center(
  //                     child: CircularProgressIndicator(
  //                       color: AppColors.GlobelColor,
  //                     ),
  //                   ),
  //                 ),
  //               ) : isSelect == 2 ? VisaRequirementScreen()
  //             : isSelect == 3
  //                 ? ListView.builder(
  //                     padding: EdgeInsets.symmetric(
  //                         horizontal: responsive(20, context),
  //                         vertical: responsive(10, context)),
  //                     physics: NeverScrollableScrollPhysics(),
  //                     shrinkWrap: true,
  //                     primary: true,
  //                     scrollDirection: Axis.vertical,
  //                     itemCount: packagecontroller.transport?.results!.length,
  //                     itemBuilder: (context, i) {
  //                       int lengt =
  //                           packagecontroller.transport!.results!.length;
  //
  //                       // if(i >= packagecontroller.length){
  //                       //   return Container(
  //                       //     height: responsive(100, context),
  //                       //   );
  //                       // } else{
  //
  //                       return Padding(
  //                         padding: EdgeInsets.only(
  //                             bottom: i == lengt - 1
  //                                 ? responsive(120, context)
  //                                 : responsive(0, context)),
  //                         child: Transportpackage(
  //                           index: i,
  //                         ),
  //                       );
  //                       // }
  //                     })
  //                 : packagecontroller.package!.results!.isEmpty
  //                     ? Center(
  //                         child: Padding(
  //                           padding:
  //                               EdgeInsets.only(top: responsive(140, context)),
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               SvgPicture.asset(
  //                                 "assets/images/empty_box.svg",
  //                                 height: responsive(160, context),
  //                                 width: responsive(154, context),
  //                               ),
  //                               verticalSpace(20, context),
  //                               customFonts(
  //                                   text: "${tabList[isSelect]} is Empty",
  //                                   size: 14,
  //                                   color: Colors.black,
  //                                   context: context)
  //                             ],
  //                           ),
  //                         ),
  //                       )
  //                     :
  //
  //                     // Padding(
  //                     //   padding: EdgeInsets.only(
  //                     //       left: responsive(20, context), top: responsive(29, context)),
  //                     //   child: Row(
  //                     //     children: List.generate(
  //                     //         tabList.length,
  //                     //         (index) => Padding(
  //                     //               padding:
  //                     //                   EdgeInsets.only(right: responsive(10, context)),
  //                     //               child: tabBarContainer(
  //                     //                   index: index,
  //                     //                   onTap: () {
  //                     //                     setState(() {
  //                     //                       isSelect = index;
  //                     //                     });
  //                     //                   },
  //                     //                   text: tabList[index],
  //                     //                   isSelect: isSelect),
  //                     //             )),
  //                     //   ),
  //                     // ),
  //
  //                     // vertical space
  //                     Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           verticalSpace(20, context),
  //                           Padding(
  //                             padding: EdgeInsets.only(
  //                                 left: responsive(19.5, context)),
  //                             child: customFonts(
  //                                 text: "Recommended Packages",
  //                                 size: 19,
  //                                 fontWeight: FontWeight.w600,
  //                                 context: context),
  //                           ),
  //                           verticalSpace(20, context),
  //                           PageBuilder(
  //                               hotel: hotel,
  //                               total:
  //                                   packagecontroller.package!.results!.length,
  //                               package: packagecontroller,
  //                               pageController: pageController,
  //                               tabList: tabList,
  //                               isSelect: isSelect),
  //                           verticalSpace(20, context),
  //                           verticalSpace(20, context),
  //                           Padding(
  //                             padding: EdgeInsets.symmetric(
  //                                 horizontal: responsive(20, context)),
  //                             child: Row(
  //                               crossAxisAlignment: CrossAxisAlignment.end,
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 customFonts(
  //                                     text: "${tabList[isSelect]} Packages",
  //                                     size: 19,
  //                                     fontWeight: FontWeight.w600,
  //                                     context: context),
  //                                 customFonts(
  //                                     text: "See all",
  //                                     size: 19,
  //                                     color: AppColors.GlobelColor,
  //                                     fontWeight: FontWeight.w700,
  //                                     context: context),
  //                               ],
  //                             ),
  //                           ),
  //                           verticalSpace(20, context),
  //                           SizedBox(
  //                             // height: responsive(300, context),
  //                             child: ListView.builder(
  //                                 shrinkWrap: true,
  //                                 primary: true,
  //                                 physics: NeverScrollableScrollPhysics(),
  //                                 padding: EdgeInsets.symmetric(
  //                                     horizontal: responsive(20, context)),
  //                                 // itemCount: list.length,
  //                                 itemCount: packagecontroller
  //                                     .package?.results!.length,
  //                                 itemBuilder: (context, index) {
  //                                   int lengt = packagecontroller
  //                                       .package!.results!.length;
  //
  //                                   var pkg = packagecontroller
  //                                       .package?.results?[index];
  //                                   var hotel1, hotel2;
  //
  //                                   // getImages(hotel, packagecontroller, index);
  //
  //                                   bool isFav = toggle(wishController.list,
  //                                       pkg?.huzToken, false);
  //
  //                                   return Padding(
  //                                     padding: EdgeInsets.only(
  //                                         bottom: responsive(16, context)),
  //                                     child: GestureDetector(
  //                                       onTap: () {
  //                                         packagecontroller.details = null;
  //                                         packagecontroller.isApiCalled = false;
  //                                         packagecontroller.notifyListeners();
  //
  //                                         Get.to(() => DetailScreen(
  //                                               token: pkg?.huzToken,
  //                                             ));
  //                                       },
  //                                       child: PackageContainer(
  //                                         onTapFav: () {
  //                                           isFav = toggle(wishController.list,
  //                                               pkg?.huzToken, true);
  //                                           if (isFav) {
  //                                           } else {
  //                                             _addTask(
  //                                               packageImage: getImages(hotel,
  //                                                   packagecontroller, index),
  //                                               hotel2: hotel1,
  //                                               id: pkg?.huzToken,
  //                                               rating: pkg
  //                                                   ?.ratingCount?.averageStars,
  //                                               packageName: pkg?.packageName,
  //                                               include: packagecontroller
  //                                                   ?.allincludes[index],
  //                                               startDate: pkg?.startDate,
  //                                               endDate: pkg?.endDate,
  //                                               cost: pkg?.packageBaseCost,
  //                                             );
  //                                           }
  //                                         },
  //                                         isFav: isFav,
  //                                         image: getImages(
  //                                             hotel, packagecontroller, index),
  //                                         id: pkg?.huzToken,
  //                                         packageName: pkg?.packageName,
  //                                         rating:
  //                                             pkg?.ratingCount?.averageStars,
  //                                         startDate: pkg?.startDate,
  //                                         endDate: pkg?.endDate,
  //                                         amount: formatCurrency(
  //                                             pkg?.packageBaseCost.toInt()),
  //                                         inlcudes: packagecontroller
  //                                             ?.allincludes[index],
  //                                       ),
  //                                     ),
  //                                   );
  //                                 }),
  //                           ),
  //                           SizedBox(
  //                             height: responsive(30, context),
  //                           )
  //                         ],
  //                       )
  //       ],
  //     ),
  //   ));
  // }

  // bool toggle(List wishlist, String packageId, isDelete) {
  //   for (var m in wishlist) {
  //     if (m.id == packageId) {
  //       if (isDelete) {
  //         _removeTask(m);
  //         showSnackbar(context, 'Removed from wishlist successfully');
  //       }
  //       return true;
  //     }
  //   }
  //   if (isDelete) showSnackbar(context, 'Added to wishlist successfully');
  //   return false;
  // }

  // Container packagesContainer({
  //   required var id,
  //   required var isFav,
  //   required var onTapFav,
  //   required var image,
  //   required var packageName,
  //   required var startDate,
  //   required var endDate,
  //   var includeList,
  //   var excludeList,
  //   required var amount,
  //   var rating,
  //   var inlcudes,
  // }) {
  //   print('images are ${image}');
  //   return Container(
  //
  //     padding: EdgeInsets.all(responsive(5, context)),
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(responsive(6, context)),
  //         border: Border.all(color: const Color(0xFFDEDEDE))),
  //     // height: responsive(150, context),
  //     // width: responsive(382, context),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Stack(
  //
  //           children: [
  //             Container(
  //
  //               // height: responsive(150, context),
  //               width: responsive(139, context),
  //               child: ClipRRect(
  //                 borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(responsive(10, context)),
  //                   topRight: Radius.circular(responsive(10, context)),
  //                   bottomRight: Radius.circular(responsive(10, context)),
  //                   bottomLeft: Radius.circular(responsive(10, context)),
  //                 ),
  //                 child: CachedNetworkImage(
  //                   imageUrl: "${image}",
  //                   placeholder: (context, url) => Image.asset(
  //                     'images/placeholder-image.png',
  //                     fit: BoxFit.cover,
  //                   ),
  //                   errorWidget: (context, url, error) => Image.asset(
  //                     'images/placeholder-image.png',
  //                     fit: BoxFit.fitHeight,
  //                   ),
  //                   fit: BoxFit.fitHeight,
  //                 ),
  //               ),
  //             ),
  //             Positioned(
  //               top: responsive(0, context),
  //               right: responsive(0, context),
  //               child: GestureDetector(
  //                 onTap: onTapFav,
  //                 child: Padding(
  //                   padding: EdgeInsets.only(
  //                       top: responsive(08, context),
  //                       right: responsive(08, context),
  //                       left: responsive(50, context),
  //                       bottom: responsive(50, context)),
  //                   child: Container(
  //
  //                     alignment: Alignment.center,
  //                     height: responsive(25, context),
  //                     width: responsive(25, context),
  //                     decoration: const BoxDecoration(
  //                       color: Colors.white,
  //                       shape: BoxShape.circle,
  //                     ),
  //                     child: isFav
  //                         ? SvgPicture.asset(
  //                             "images/heart_icon_fill.svg",
  //                             height: responsive(15, context),
  //                           )
  //                         : SvgPicture.asset(
  //                             "images/Shape.svg",
  //                             height: responsive(15, context),
  //                           ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         Expanded(
  //           flex: 2,
  //           child: Padding(
  //             padding: EdgeInsets.symmetric(
  //                 horizontal: responsive(10, context),
  //             ),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 customFonts(
  //                     text: packageName,
  //                     size: 14,
  //                     fontWeight: FontWeight.bold,
  //                     color: AppColors.primaryBlackColor.withOpacity(0.90),
  //                     context: context),
  //                 customFonts(
  //                     text:
  //                         "${formatDateString(startDate)} to ${formatDateString(endDate)}",
  //                     size: 13,
  //                     fontWeight: FontWeight.w500,
  //                     color: AppColors.primaryBlackColor,
  //                     context: context),
  //                 verticalSpace(5, context),
  //                 Wrap(
  //                   spacing: 0.0,
  //                   children: List.generate(
  //                     inlcudes.length,
  //                         (index) => index == 0
  //                         ? customFonts(
  //                         text: "Includes: ",
  //                         size: 13,
  //                         color: AppColors.primaryBlackColor,
  //                         fontWeight: FontWeight.bold,
  //                         context: context)
  //                         : customFonts(
  //                         text: "${inlcudes[index]}",
  //                         size: 13,
  //                         fontWeight: FontWeight.w500,
  //                         color: AppColors.primaryBlackColor,
  //                         context: context),
  //                   ),
  //                 ),
  //                 verticalSpace(5, context),
  //                 // Spacer(),
  //                 // Wrap(
  //                 //   spacing: 10,
  //                 //   children: List.generate(
  //                 //     7,
  //                 //         (index) =>  customFonts(
  //                 //         text: "Dinner",
  //                 //         size: 10,
  //                 //         fontWeight: FontWeight.w500,
  //                 //         color: AppColors.primaryBlackColor,
  //                 //         context: context),
  //                 //   ),
  //                 // ),
  //
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     customFonts(
  //                         text: 'PKR $amount',
  //                         size: 16,
  //                         fontWeight: FontWeight.bold,
  //                         color: const Color(0xFF484848),
  //                         context: context),
  //                     Row(
  //                       children: [
  //                         SvgPicture.asset(
  //                           "images/star.svg",
  //                         ),
  //                         horizontalSpace(5, context),
  //                         customFonts(
  //                             text: "$rating",
  //                             size: 16,
  //                             fontWeight: FontWeight.w500,
  //                             color: AppColors.primaryBlackColor
  //                                 .withOpacity(0.9),
  //                             context: context),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

}


class PackageContainer extends StatefulWidget {

   var id;
        var isFav,
        onTapFav,
        image,
        packageName,
        startDate,
        endDate,
   includeList,
   excludeList,
        amount,
   rating,
   inlcudes;

   PackageContainer({super.key,   required  this.id,
     this.isFav = false,
    required  this.onTapFav,
    required this.image,
    required this.packageName,
    required this.startDate,
    required this.endDate,
    this.includeList,
    this.excludeList,
    required this.amount,
    this.rating,
   this.inlcudes,});

  @override
  State<PackageContainer> createState() => _PackageContainerState();
}

class _PackageContainerState extends State<PackageContainer> {

  final GlobalKey _containerKey = GlobalKey();

  double _containerHeight = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getContainerHeight());
  }

  void _getContainerHeight() {
    final RenderBox? renderBox = _containerKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        _containerHeight = renderBox.size.height;
        print(" ************** COntainer height : $_containerHeight");
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      key: _containerKey,
      padding: EdgeInsets.all(responsive(5, context)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(responsive(6, context)),
          border: Border.all(color: const Color(0xFFDEDEDE))),
      // height: responsive(150, context),
      // width: responsive(382, context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(

            children: [
              Container(

                height: responsive(_containerHeight, context),
                width: responsive(139, context),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(responsive(10, context)),
                    topRight: Radius.circular(responsive(10, context)),
                    bottomRight: Radius.circular(responsive(10, context)),
                    bottomLeft: Radius.circular(responsive(10, context)),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: "${widget.image}",
                    placeholder: (context, url) => Image.asset(
                      'images/placeholder-image.png',
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'images/placeholder-image.png',
                      fit: BoxFit.fitHeight,
                    ),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Positioned(
                top: responsive(0, context),
                right: responsive(0, context),
                child: GestureDetector(
                  onTap: widget.onTapFav,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: responsive(08, context),
                        right: responsive(08, context),
                        left: responsive(50, context),
                        bottom: responsive(50, context)),
                    child: Container(

                      alignment: Alignment.center,
                      height: responsive(25, context),
                      width: responsive(25, context),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: widget.isFav
                          ? SvgPicture.asset(
                        "images/heart_icon_fill.svg",
                        height: responsive(15, context),
                      )
                          : SvgPicture.asset(
                        "images/Shape.svg",
                        height: responsive(15, context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsive(10, context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customFonts(
                      text: widget.packageName,
                      size: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlackColor.withOpacity(0.90),
                      context: context),
                  customFonts(
                      text:
                      "${formatDateString(widget.startDate)} to ${formatDateString(widget.endDate)}",
                      size: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryBlackColor,
                      context: context),
                  verticalSpace(5, context),
                  Wrap(
                    spacing: 0.0,
                    children: List.generate(
                      widget.inlcudes.length,
                          (index) => index == 0
                          ? customFonts(
                          text: "Includes: ",
                          size: 13,
                          color: AppColors.primaryBlackColor,
                          fontWeight: FontWeight.bold,
                          context: context)
                          : customFonts(
                          text: "${widget.inlcudes[index]}",
                          size: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryBlackColor,
                          context: context),
                    ),
                  ),
                  verticalSpace(5, context),
                  // Spacer(),
                  // Wrap(
                  //   spacing: 10,
                  //   children: List.generate(
                  //     7,
                  //         (index) =>  customFonts(
                  //         text: "Dinner",
                  //         size: 10,
                  //         fontWeight: FontWeight.w500,
                  //         color: AppColors.primaryBlackColor,
                  //         context: context),
                  //   ),
                  // ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customFonts(
                          text: 'PKR ${widget.amount}',
                          size: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF484848),
                          context: context),

                      Row(
                        children: [
                          SvgPicture.asset(
                            "images/star.svg",
                          ),
                          horizontalSpace(5, context),
                          customFonts(
                            textOverflow: TextOverflow.ellipsis,
                              text: "${widget.rating.toStringAsFixed(1)}",
                              size: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryBlackColor
                                  .withOpacity(0.9),
                              context: context),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeButton extends StatefulWidget {
  final pakagecontrollers packagecontroller;
   final   hotelcontroller hotel;
  const HomeButton({super.key, required this.packagecontroller, required this.hotel});

  @override
  State<HomeButton> createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  int isSelect = 1;
  final WishListController wishController = WishListController();
  void _loadTasks() async {
    final loadedTasks = await wishController.getTasks();
    setState(() {
      wishController.list = loadedTasks;
    });
  }

  final ScrollController _scrollController = ScrollController();
  var _currentIndex = 0;

  @override
  void initState() {
    _scrollController.addListener(() {
      int newIndex =
      (_scrollController.offset / MediaQuery.of(context).size.width)
          .round();
      if (newIndex != _currentIndex) {
        setState(() {
          _currentIndex = newIndex;
        });

        print(_currentIndex);
      }
    });
    super.initState();

    setState(() {
      _loadTasks();
    });

    pageController.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    currentPage = pageController.page!.round();
  }
  PageController pageController =
  PageController(viewportFraction: 0.7, initialPage: 0);
  int currentPage = 0;

  bool toggle(List wishlist, String packageId, isDelete) {
    for (var m in wishlist) {
      if (m.id == packageId) {
        if (isDelete) {
          _removeTask(m);
          showSnackbar(context, 'Removed from wishlist successfully');
        }
        return true;
      }
    }
    if (isDelete) showSnackbar(context, 'Added to wishlist successfully');
    return false;
  }
  void _addTask(
      {required var packageImage,
        required var id,
        required var rating,
        required var hotel2,
        required var packageName,
        required var startDate,
        required var endDate,
        required var include,
        required var cost}) async {
    final wish = WishList(
        packageImage: packageImage,
        hotel2: hotel2,
        rating: rating,
        id: id,
        packageName: packageName,
        startDate: startDate,
        endDate: endDate,
        incldues: include,
        cost: cost);
    await wishController.addTask(wish);
    wishController.notifyListeners();

    print("************");
    print("$packageName $startDate $endDate $cost)");

    _loadTasks();
  }

  void _removeTask(WishList wish) async {
    // wishController.isFav = false;
    await wishController.removeTask(wish);
    wishController.notifyListeners();
    _loadTasks();
  }
  List tabList = [
    "Hajj",
    "Umrah",
    "eVisa",
    "Tour & Transport",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(10, context),
      
                  // Search bar
                  InkWell(
                    onTap: () {
                      Get.to(() => SearchBarScreen());
                    },
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: responsive(20, context)),
                      child: Search(context: context, onchange: (value) {}),
                    ),
                  ),
      
                  // TabBar
      
                  Padding(
                    padding: EdgeInsets.only(
                        left: responsive(20, context), top: responsive(29, context)),
                    child: Row(
                      children: List.generate(
                          tabList.length,
                              (index) => Padding(
                            padding:
                            EdgeInsets.only(right: responsive(10, context)),
                            child: tabBarContainer(
                                context: context,
                                index: index,
                                onTap: () async {
                                  setState(() {
                                    isSelect = index;
                                    print(isSelect);
                                  });
      

                                  if (index == 3) {
                                    widget.packagecontroller.isApiCalled = false;
                                    // widget.packagecontroller.package =null;
                                    widget.packagecontroller.fromtabs = true;
                                    widget.packagecontroller.notifyListeners();
                                    widget.packagecontroller.GetTransport();
                                  }
      
                                  else if(index ==2){

                                    // setState(() {
                                    //
                                    // });
                                    widget.packagecontroller.isApiCalled = false;
                                    // widget.packagecontroller.package =null;
                                    widget.packagecontroller.fromtabs = true;
                                    widget.packagecontroller.notifyListeners();
                                    widget.packagecontroller.Getpackages(tabList[1]);


                                   await  Get.to(VisaRequirementScreen());
                                    isSelect = 1;


                                  }
      
                                  else {
                                    // await Future.delayed(Duration(milliseconds: 500));
                                    widget.packagecontroller.isApiCalled = false;
                                    // widget.packagecontroller.package =null;
                                    widget.packagecontroller.fromtabs = true;
                                    widget.packagecontroller.notifyListeners();
                                    widget.packagecontroller.Getpackages(tabList[isSelect]);
                                  }
                                },
                                text: tabList[index],
                                isSelect: isSelect),
                          )),
                    ),
                  ),
      
                  widget.packagecontroller.isApiCalled == false
                      ? Padding(
                    padding: EdgeInsets.only(top: responsive(300, context)),
                    child: Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.GlobelColor,
                        ),
                      ),
                    ),
                  ) : isSelect == 3
                      ? widget.packagecontroller.transport==null?Center(
                    child: Padding(
                      padding:
                      EdgeInsets.only(top: responsive(140, context)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/empty_box.svg",
                            height: responsive(160, context),
                            width: responsive(154, context),
                          ),
                          verticalSpace(20, context),
                          customFonts(
                              text: "${tabList[isSelect]} is Empty",
                              size: 14,
                              color: Colors.black,
                              context: context)
                        ],
                      ),
                    ),
                  ):ListView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: responsive(20, context),
                          vertical: responsive(10, context)),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      primary: true,
                      scrollDirection: Axis.vertical,
                      itemCount: widget.packagecontroller.transport?.results!.length,
                      itemBuilder: (context, i) {
                        var lengt;
                        if(widget.packagecontroller.transport!=null)

                           lengt = widget.packagecontroller.transport?.results?.length;
      
                        // if(i >= packagecontroller.length){
                        //   return Container(
                        //     height: responsive(100, context),
                        //   );
                        // } else{
      
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: lengt==null?0:i == lengt - 1
                                  ? responsive(120, context)
                                  : responsive(0, context)),
                          child: Transportpackage(
                            index: i,
                          ),
                        );
                        // }
                      })
                      : widget.packagecontroller.package!.results!.isEmpty
                      ? Center(
                    child: Padding(
                      padding:
                      EdgeInsets.only(top: responsive(140, context)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/empty_box.svg",
                            height: responsive(160, context),
                            width: responsive(154, context),
                          ),
                          verticalSpace(20, context),
                          customFonts(
                              text: "${tabList[isSelect]} is Empty",
                              size: 14,
                              color: Colors.black,
                              context: context)
                        ],
                      ),
                    ),
                  )
                      :
      
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //       left: responsive(20, context), top: responsive(29, context)),
                  //   child: Row(
                  //     children: List.generate(
                  //         tabList.length,
                  //         (index) => Padding(
                  //               padding:
                  //                   EdgeInsets.only(right: responsive(10, context)),
                  //               child: tabBarContainer(
                  //                   index: index,
                  //                   onTap: () {
                  //                     setState(() {
                  //                       isSelect = index;
                  //                     });
                  //                   },
                  //                   text: tabList[index],
                  //                   isSelect: isSelect),
                  //             )),
                  //   ),
                  // ),
      
                  // vertical space
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(20, context),
                      Padding(
                        padding: EdgeInsets.only(
                            left: responsive(19.5, context)),
                        child: customFonts(
                            text: "Recommended Packages",
                            size: 19,
                            fontWeight: FontWeight.w600,
                            context: context),
                      ),
                      verticalSpace(20, context),
                      PageBuilder(
                          hotel: widget.hotel,
                          total:
                          widget.packagecontroller.package!.results!.length,
                          package: widget.packagecontroller,
                          pageController: pageController,
                          tabList: tabList,
                          isSelect: isSelect),
                      verticalSpace(20, context),
                      verticalSpace(20, context),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: responsive(20, context)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            customFonts(
                                text: "${tabList[isSelect]} Packages",
                                size: 19,
                                fontWeight: FontWeight.w600,
                                context: context),
                            customFonts(
                                text: "See all",
                                size: 19,
                                color: AppColors.GlobelColor,
                                fontWeight: FontWeight.w700,
                                context: context),
                          ],
                        ),
                      ),
                      verticalSpace(20, context),
                      SizedBox(
                        // height: responsive(300, context),
                        child: ListView.builder(
                            shrinkWrap: true,
                            primary: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                                horizontal: responsive(20, context)),
                            // itemCount: list.length,
                            itemCount: widget.packagecontroller
                                .package?.results!.length,
                            itemBuilder: (context, index) {
                              int lengt = widget.packagecontroller
                                  .package!.results!.length;
      
                              var pkg = widget.packagecontroller
                                  .package?.results?[index];
                              var hotel1, hotel2;
      
                              // getImages(hotel, packagecontroller, index);
      
                              bool isFav = toggle(wishController.list,
                                  pkg?.huzToken, false);
      
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: responsive(16, context)),
                                child: GestureDetector(
                                  onTap: () {
                                    widget.packagecontroller.details = null;
                                    widget.packagecontroller.isApiCalled = false;
                                    widget.packagecontroller.notifyListeners();
      
                                    Get.to(() => DetailScreen(
                                      token: pkg?.huzToken,
                                    ));
                                  },
                                  child: PackageContainer(
                                    onTapFav: () {
                                      isFav = toggle(wishController.list,
                                          pkg?.huzToken, true);
                                      if (isFav) {
                                      } else {
                                        print("***************** Added to fav: ${getImages(widget.hotel,
                                            widget.packagecontroller, index)}");
                                        _addTask(
                                          packageImage: getImages(widget.hotel,
                                              widget.packagecontroller, index),
                                          hotel2: hotel1,
                                          id: pkg?.huzToken,
                                          rating: pkg
                                              ?.ratingCount?.averageStars,
                                          packageName: pkg?.packageName,
                                          include: widget.packagecontroller
                                              ?.allincludes[index],
                                          startDate: pkg?.startDate,
                                          endDate: pkg?.endDate,
                                          cost: pkg?.packageBaseCost,
                                        );
                                      }
                                    },
                                    isFav: isFav,
                                    image: getImages(
                                        widget.hotel, widget.packagecontroller, index),
                                    id: pkg?.huzToken,
                                    packageName: pkg?.packageName,
                                    rating:
                                    pkg?.ratingCount?.averageStars,
                                    startDate: pkg?.startDate,
                                    endDate: pkg?.endDate,
                                    amount: formatCurrency(
                                        pkg?.packageBaseCost.toInt()),
                                    inlcudes: widget.packagecontroller
                                        ?.allincludes[index],
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: responsive(30, context),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
    );
  }



  Widget tabBarContainer(
      {required String text,
        required int index,
        required int isSelect,
        required var context,
        required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: responsive(38, context),
        padding: EdgeInsets.symmetric(horizontal: responsive(15, context)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(responsive(5, context)),
          border: isSelect == index
              ? null
              : Border.all(color: const Color(0xFFE4E2E2)),
          color: isSelect == index ? AppColors.GlobelColor : Colors.transparent,
        ),
        child: customFonts(
            text: text,
            size: 15,
            context: context,
            color:
            isSelect == index ? Colors.white : AppColors.primaryBlackColor),
      ),
    );
  }
}



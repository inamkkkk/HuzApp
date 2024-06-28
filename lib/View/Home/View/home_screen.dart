import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
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
import 'package:huz/View/hajj_umrah_guide/hajj_guide.dart';
import 'package:huz/View/hajj_umrah_guide/model/umrah_guide.dart';
import 'package:huz/View/hajj_umrah_guide/umra_guide_detal_screen.dart';
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

  final WishListController wishController = WishListController();
  final ScrollController _scrollController = ScrollController();
  var _currentIndex = 0;

  @override
  void initState() {
    _scrollController.addListener(() {
      int newIndex =
      (_scrollController.offset / MediaQuery
          .of(context)
          .size
          .width)
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

  void _loadTasks() async {
    final loadedTasks = await wishController.getTasks();
    setState(() {
      wishController.list = loadedTasks;
    });
  }

  void _addTask({required var packageImage,
    required var id,
    required var packageName,
    required var startDate,
    required var endDate,
    required var include,
    required var cost}) async {
    final wish = WishList(
        packageImage: packageImage,
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
  var selected = 1;
  var lengt = 0;
  int _selectedIndex = 0;

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
                          _loadTasks();
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
                                fontSize: responsive(12, context),
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
              fontSize: responsive(14, context),
              letterSpacing: 0,
              fontWeight: FontWeight.w500,
              height: 1),
        ),
      ),
    );
  }

  List tabList = [
    "Hajj",
    "Umrah",
    "eVisa",
    "Tour & Transport",
  ];

  PageController pageController =
  PageController(viewportFraction: 0.7, initialPage: 0);
  int currentPage = 0;
  int isSelect = 1;

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
                              radius:
                              responsive(40, context),
                              // specify the radius of the circular container
                              backgroundColor: Colors.grey[100],
                              // set the background color of the container
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Image.asset(
                                    "assets/images/guest_icon.png",),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          "assets/images/guest_icon.png"),
                                  imageUrl:
                                  '${NetworkServices.ibaseUrl}${user.isUser
                                      ?.userPhoto}',
                                  // replace with the URL of your image
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: user.isUser == null ? responsive(
                                  20, context) : responsive(20, context),
                            ),
                            Text(
                              user.isUser?.name ?? 'Guest Account',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: responsive(14, context),
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
                                padding:  EdgeInsets.symmetric(vertical: responsive(05, context)),
                                child: Text(
                                  'Log out',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: AppColors.GlobelColor,
                                      fontFamily: 'Poppins',
                                      fontSize: responsive(13, context),
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
                          text: 'How It is Work',
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
            body: Consumer<pakagecontrollers>(
                builder: (context, packagecontroller, child) {
                  // if (packagecontroller.package == null) {
                  //   packagecontroller.Getpackages('Umrah');
                  // }

                  return widget.selectedIndex == 0
                      ? homeButton(context, packagecontroller)
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

  // List list = ["package 1", "Package 2", "Package 3"];

  Widget homeButton(BuildContext context, pakagecontrollers packagecontroller) {
    return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(10, context),

              // Search bar
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: responsive(20, context)),
                child: Search(context: context, onchange: (value) {}),
              ),

              // TabBar

              Padding(
                padding: EdgeInsets.only(
                    left: responsive(20, context),
                    top: responsive(29, context)),
                child: Row(
                  children: List.generate(
                      tabList.length,
                          (index) =>
                          Padding(
                            padding:
                            EdgeInsets.only(right: responsive(10, context)),
                            child: tabBarContainer(
                                context: context,
                                index: index,
                                onTap: () {
                                  setState(() {
                                    isSelect = index;
                                    print(isSelect);
                                  });

                                  packagecontroller.isApiCalled = false;
                                  // packagecontroller.package =null;
                                  packagecontroller.fromtabs = true;
                                  packagecontroller.notifyListeners();
                                  if (index == 3) {
                                    packagecontroller.GetTransport();
                                  } else {
                                    // await Future.delayed(Duration(milliseconds: 500));
                                    packagecontroller.Getpackages(
                                        tabList[index]);
                                  }
                                },
                                text: tabList[index],
                                isSelect: isSelect),
                          )),
                ),
              ),

              packagecontroller.isApiCalled == false
                  ? Padding(
                padding: EdgeInsets.only(top: responsive(300, context)),
                child: Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.GlobelColor,
                    ),
                  ),
                ),
              )
                  : isSelect == 3
                  ? ListView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: responsive(20, context),
                      vertical: responsive(10, context)),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: true,
                  scrollDirection: Axis.vertical,
                  itemCount: packagecontroller.transport?.results!.length,
                  itemBuilder: (context, i) {
                    int lengt =
                        packagecontroller.transport!.results!.length;

                    // if(i >= packagecontroller.length){
                    //   return Container(
                    //     height: responsive(100, context),
                    //   );
                    // } else{

                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: i == lengt - 1
                              ? responsive(120, context)
                              : responsive(0, context)),
                      child: Transportpackage(
                        index: i,
                      ),
                    );
                    // }
                  })
                  : packagecontroller.package!.results!.isEmpty
                  ? Center(
                child: Padding(
                  padding: EdgeInsets.only(top: responsive(140, context)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/empty_box.svg",
                        height: responsive(160, context),
                        width: responsive(154, context),
                      ),
                      verticalSpace(20, context),
                      customFonts(text: "${tabList[isSelect]} is Empty",
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
                        size: 18,
                        fontWeight: FontWeight.w600,
                        context: context),
                  ),
                  verticalSpace(20, context),
                  PageBuilder(
                      total: packagecontroller.package!.results!.length,
                      package: packagecontroller,
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
                            size: 18,
                            fontWeight: FontWeight.w600,
                            context: context),
                        customFonts(
                            text: "See all",
                            size: 18,
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
                        itemCount: packagecontroller
                            .package?.results!.length,
                        itemBuilder: (context, index) {
                          int lengt = packagecontroller
                              .package!.results!.length;

                          var pkg = packagecontroller
                              .package?.results?[index];
                          var hotelimage;

                          if (tabList[isSelect] == 'Umrah') {
                            String hotelname = pkg
                                ?.hotelInfoDetail?[1].hotelName
                                .replaceAll(' ', '_');
                            hotelimage =
                            "https://hajjumrah.co/makkah/${hotelname}_image1.jpg";
                          } else {
                            String hotelname = pkg
                                ?.hotelInfoDetail?[1].hotelName
                                .replaceAll(' ', '_');
                            hotelimage =
                            "https://hajjumrah.co/madinah/${hotelname}_image1.jpg";
                          }

                          print(hotelimage);

                          bool isFav = toggle(wishController.list,
                              pkg?.huzToken, false);

                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: responsive(16, context)),
                            child: GestureDetector(
                              onTap: () {
                                packagecontroller.details = null;
                                packagecontroller.isApiCalled = false;
                                packagecontroller.notifyListeners();

                                Get.to(() =>
                                    DetailScreen(
                                      token: pkg?.huzToken,
                                    ));
                              },

                              child: packagesContainer(
                                onTapFav: () {
                                  isFav = toggle(wishController.list,
                                      pkg?.huzToken, true);
                                  if (isFav) {} else {
                                    _addTask(
                                      packageImage: hotelimage,
                                      id: pkg?.huzToken,
                                      packageName: pkg?.packageName,
                                      include: packagecontroller
                                          ?.allincludes[index],
                                      startDate: pkg?.startDate,
                                      endDate: pkg?.endDate,
                                      cost: pkg?.packageCost,
                                    );
                                  }
                                },
                                isFav: isFav,
                                image: hotelimage,
                                id: pkg?.huzToken,
                                packageName: pkg?.packageName,
                                rating: "4.6",
                                startDate: pkg?.startDate,
                                endDate: pkg?.endDate,
                                amount: formatCurrency(
                                    pkg?.packageCost.toInt()),
                                inlcudes: packagecontroller
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
        ));
  }

  bool toggle(List wishlist, String packageId, isDelete) {
    for (var m in wishlist) {
      if (m.id == packageId) {
        if (isDelete){
          _removeTask(m);
          showSnackbar(context, 'Removed from wishlist successfully');
        }
        return true;
      }
    }
    if(isDelete)
    showSnackbar(context, 'Added to wishlist successfully');
    return false;
  }

  Container packagesContainer({
    required var id,
    required var isFav,
    required var onTapFav,
    required var image,
    required var packageName,
    required var startDate,
    required var endDate,
    var includeList,
    var excludeList,
    required var amount,
    var rating,
    var inlcudes,
  }) {
    return Container(
      padding: EdgeInsets.all(responsive(5, context)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(responsive(6, context)),
          border: Border.all(color: const Color(0xFFDEDEDE))),
      height: responsive(128, context),
      width: responsive(382, context),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                height: responsive(118, context),
                width: responsive(139, context),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(responsive(10, context)),
                    topRight: Radius.circular(responsive(10, context)),
                    bottomRight: Radius.circular(responsive(10, context)),
                    bottomLeft: Radius.circular(responsive(10, context)),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: "${image}",
                    placeholder: (context, url) =>
                        Image.asset(
                          'images/placeholder-image.png',
                          fit: BoxFit.cover,
                        ),
                    errorWidget: (context, url, error) =>
                        Image.asset(
                          'images/placeholder-image.png',
                          fit: BoxFit.cover,
                        ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: responsive(0, context),
                right: responsive(0, context),
                child: GestureDetector(
                  onTap: onTapFav,
                  child: Padding(
                    padding: EdgeInsets.only(top: responsive(08, context),
                        right: responsive(08, context),
                        left: responsive(50, context),
                        bottom: responsive(50, context)),
                    child: Container(
                      alignment: Alignment.center,
                      height: responsive(20, context),
                      width: responsive(20, context),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: isFav
                          ? SvgPicture.asset(
                        "images/heart_icon_fill.svg",
                        height: responsive(13, context),
                      )
                          : SvgPicture.asset(
                        "images/Shape.svg",
                        height: responsive(13, context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: responsive(10, context),
                  vertical: responsive(5, context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customFonts(
                          text: packageName,
                          size: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlackColor.withOpacity(0.90),
                          context: context),
                      customFonts(
                          text:
                          "${formatDateString(startDate)} to ${formatDateString(
                              endDate)}",
                          size: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryBlackColor,
                          context: context),
                    ],
                  ),
                  Wrap(
                    spacing: 0.0,
                    children: List.generate(
                      inlcudes.length,
                          (index) =>
                      index == 0
                          ? customFonts(
                          text: "Includes: ",
                          size: 12,
                          color: AppColors.primaryBlackColor,
                          fontWeight: FontWeight.bold,
                          context: context)
                          : customFonts(
                          text: "${inlcudes[index]}",
                          size: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryBlackColor,
                          context: context),
                    ),
                  ),
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

                  SizedBox(
                    width: responsive(300, context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customFonts(
                            text: 'PKR $amount',
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
                                text: "$rating",
                                size: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryBlackColor
                                    .withOpacity(0.9),
                                context: context),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tabBarContainer({required String text,
    required int index,
    required int isSelect,
    required var context,
    required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: responsive(33, context),
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
            size: 14,
            context: context,
            color:
            isSelect == index ? Colors.white : AppColors.primaryBlackColor),
      ),
    );
  }

}

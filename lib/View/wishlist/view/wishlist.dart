import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:huz/Responsive/ResponsiveClass.dart';
import 'package:huz/TextStyles/styles.dart';
import 'package:huz/View/Details/View/detail_screen.dart';
import 'package:huz/View/Home/View/home_screen.dart';
import 'package:huz/View/wishlist/controller/wishlist_controller.dart';
import 'package:huz/Widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../Controller/pakagecontroller.dart';
import '../../../TextStyles/Color.dart';
import '../../../Widgets/snackbar.dart';
import '../../auth/controller/is_user_exist_controller.dart';
import '../model/wishlist_model.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {


  WishListController wishListController = WishListController();

  @override
  void initState() {
    _loadTasks();
    super.initState();
  }

  void _loadTasks() async {
    final loadedTasks = await wishListController.getTasks();
    print('tasks length is : ${loadedTasks.length}');
    setState(() {
      wishListController.list = loadedTasks;
    });
  }

  void _removeTask(WishList wish) async {
    wishListController.isFav = false;
    await wishListController.removeTask(wish);
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return wishListController.list.isEmpty
        ?  Consumer2<pakagecontrollers, IsUserExitsController>(
        builder: (context, packagecontroller, user, child) {
            return Scaffold(
                  backgroundColor: Color(0xFFF2F2F2),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/wishlist_icon.png",
                      height: responsive(170, context),
                      width: responsive(170, context),
                      fit: BoxFit.cover,
                    ),
                    verticalSpace(20, context),
                    customFonts(
                        text: "No Wishlist",
                        size: 14,
                        color: Colors.black,
                        context: context)
                  ],
                ),
              ),
            );
          }
        )
        : Consumer2<pakagecontrollers, IsUserExitsController>(
        builder: (context, packagecontroller, user, child) {
            return Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: responsive(20, context)),
                    height: responsive(49, context),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xFFF2F2F2),
                            width: responsive(2, context))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "images/heart_icon_round.svg",
                          height: responsive(17, context),
                        ),
                        horizontalSpace(14, context),
                        customFonts(
                            text:
                                "${wishListController.list.length} packages added in Wishlist.",
                            size: 18,
                            color: AppColors.GlobelColor,
                            context: context)
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.all(responsive(20, context)),
                          itemCount: wishListController.list.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(bottom: responsive(20, context)),
                              child: GestureDetector(
                                onTap: () {
                                  packagecontroller.details = null;
                                  packagecontroller.isApiCalled = false;
                                  packagecontroller.notifyListeners();

                                  Get.to(() => DetailScreen(
                                    token: wishListController.list[index].id,
                                  ));
                                },
                                child: PackageContainer(
                                    onClose: () {
                                      if (wishListController.list.isNotEmpty) {
                                        for (var m in wishListController.list) {
                                          if (m.id ==
                                              wishListController.list[index].id) {
                                            _removeTask(
                                                wishListController.list[index]);
                                            showSnackbar(context, 'Removed from wishlist successfully');
                                          }
                                        }
                                      }

                                      _removeTask(wishListController.list[index]);
                                      print("**************** clicked");
                                    },
                                    image: wishListController.list[index].packageImage,
                                    includeList:
                                        wishListController.list[index].incldues,
                                    packageName:
                                        wishListController.list[index].packageName,
                                    startDate: formatDateString(
                                        wishListController.list[index].startDate),
                                    endDate: formatDateString(
                                        wishListController.list[index].endDate),
                                    amount: wishListController.list[index].cost,
                                    rating:wishListController.list[index].rating ),
                              ),
                            );
                          })),
                ],
              );
          }
        );
  }


}

class PackageContainer extends StatefulWidget {
   var image;

       var packageName;
       var startDate;
       var endDate;
  var includeList;
  var excludeList;
       VoidCallback onClose;
       var amount;
   var rating;
   PackageContainer({super.key, required var image,
    required this.packageName,
    required this.startDate,
    required this.endDate,
    this.includeList,
    this.excludeList,
    required this.onClose,
    required this.amount,
    this.rating});

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
              // Positioned(
              //   top: responsive(0, context),
              //   right: responsive(0, context),
              //   child: GestureDetector(
              //     onTap: widget.onTapFav,
              //     child: Padding(
              //       padding: EdgeInsets.only(
              //           top: responsive(08, context),
              //           right: responsive(08, context),
              //           left: responsive(50, context),
              //           bottom: responsive(50, context)),
              //       child: Container(
              //
              //         alignment: Alignment.center,
              //         height: responsive(25, context),
              //         width: responsive(25, context),
              //         decoration: const BoxDecoration(
              //           color: Colors.white,
              //           shape: BoxShape.circle,
              //         ),
              //         child: widget.isFav
              //             ? SvgPicture.asset(
              //           "images/heart_icon_fill.svg",
              //           height: responsive(15, context),
              //         )
              //             : SvgPicture.asset(
              //           "images/Shape.svg",
              //           height: responsive(15, context),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
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
                      "${widget.startDate} to ${widget.endDate}",
                      size: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryBlackColor,
                      context: context),
                  verticalSpace(5, context),
                  Wrap(
                    spacing: 0.0,
                    children: List.generate(
                      widget.includeList.length,
                          (index) => index == 0
                          ? customFonts(
                          text: "Includes: ",
                          size: 13,
                          color: AppColors.primaryBlackColor,
                          fontWeight: FontWeight.bold,
                          context: context)
                          : customFonts(
                          text: "${widget.includeList[index]}",
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
                              text: "${widget.rating}",
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


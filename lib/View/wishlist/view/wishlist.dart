import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    super.initState();
    _loadTasks();
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
                                child: packagesContainer(
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

  Widget packagesContainer(
      {required var image,
      required var packageName,
      required var startDate,
      required var endDate,
      var includeList,
      var excludeList,
      required VoidCallback onClose,
      required var amount,
      var rating}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: responsive(5, context),
          bottom: 0,
          top: 0,
          child: Opacity(
            opacity: 0.1,
            child: SvgPicture.asset(
              "images/heart_icon_round.svg",
              height: responsive(96, context),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(responsive(5, context)),
          decoration: BoxDecoration(
            color: Colors.transparent,
              borderRadius: BorderRadius.circular(responsive(6, context)),
              border: Border.all(color: const Color(0xFFDEDEDE))),
          height: responsive(128, context),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    height: responsive(118, context),
                    width: responsive(139, context),
                    child:  ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(responsive(10, context)),
                        topRight: Radius.circular(responsive(10, context)),
                        bottomRight: Radius.circular(responsive(10, context)),
                        bottomLeft: Radius.circular(responsive(10, context)),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                        "${image}",
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
                    child: Padding(
                      padding:  EdgeInsets.only(top: responsive(08, context),right: responsive(08, context),left: responsive(50, context),bottom: responsive(50, context)),
                      child: Container(
                        alignment: Alignment.center,
                        height: responsive(20, context),
                        width: responsive(20, context),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          "images/heart_icon_fill.svg",
                          height: responsive(13 , context),
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
                              color: AppColors.primaryBlackColor
                                  .withOpacity(0.90),
                              context: context),
                          customFonts(
                              text: "$startDate to $endDate",
                              size: 11,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryBlackColor,
                              context: context),
                        ],
                      ),
                      Wrap(
                        spacing: 0.0,
                        children: List.generate(
                          includeList.length,
                          (index) => index == 0
                              ? customFonts(
                                  text: "Includes: ",
                                  size: 10,
                                  color: AppColors.primaryBlackColor,
                                  fontWeight: FontWeight.bold,
                                  context: context)
                              : customFonts(
                                  text: "${includeList[index]}",
                                  size: 10,
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
                              
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customFonts(
                              text: "PKR $amount",
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
                                  text: rating.toString(),
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
        ),
        Positioned(
          right: responsive(-7, context),
          top: responsive(-7, context),
          child: GestureDetector(
            onTap: onClose,
            child: Container(
              alignment: Alignment.center,
              height: responsive(20, context),
              width: responsive(20, context),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFDEDEDE))),
              child: Icon(
                Icons.close,
                size: responsive(14, context),
              ),
            ),
          ),
        )
      ],
    );
  }
}

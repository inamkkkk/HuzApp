import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huz/View/hajj_umrah_guide/umra_guide_detal_screen.dart';

import 'package:provider/provider.dart';

import '../../Responsive/ResponsiveClass.dart';
import '../../TextStyles/AppFonts.dart';
import '../../TextStyles/Color.dart';
import '../../TextStyles/styles.dart';
import 'controller/umrah_guide_controller.dart';
import 'halq_or_taqsir.dart';

class UmrahGuide extends StatefulWidget {
  const UmrahGuide({super.key});

  @override
  State<UmrahGuide> createState() => _UmrahGuideState();
}

class _UmrahGuideState extends State<UmrahGuide> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            // Top Image

            Container(
              padding: EdgeInsets.only(
                  left: responsive(23, context),
                  bottom: responsive(23, context)),
              height: responsive(199, context),
              width: size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/makkah.png",
                    ),
                    fit: BoxFit.cover),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Umrah Guide",
                      style: TextStyle(
                          fontSize: responsive(24, context),
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  Text("Experience the sacred steps of pilgrimage.",
                      style: TextStyle(
                          fontSize: responsive(14, context),
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),

                ],
              ),
            ),

            // Tab Container
            Container(

              alignment: Alignment.center,
              width: MediaQuery.sizeOf(context).width,
              height: responsive(65, context),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: responsive(-10, context),
                      blurRadius: responsive(25, context),

                    )
                  ],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(responsive(15, context)),
                      bottomRight: Radius.circular(responsive(15, context)))),
              child: TabBar(
                  tabAlignment: TabAlignment.center,
                  labelColor: Colors.white,
                  unselectedLabelColor: AppColors.primaryBlackColor,
                  labelStyle: TextStyle(
                      fontFamily: AppFonts.poppinsSemiBold,
                      fontSize: responsive(13, context)),

                  unselectedLabelStyle:
                  const TextStyle(fontFamily: AppFonts.poppinsMedium),
                  indicatorPadding: EdgeInsets.symmetric(vertical: responsive(12, context),),
                  labelPadding: EdgeInsets.symmetric(horizontal: responsive(10, context)),
                  indicatorSize: TabBarIndicatorSize.label,
                  dividerHeight: 0,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(responsive(15, context)),
                      color: AppColors.GlobelColor
                  ),
                  tabs:  [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: responsive(12, context)),
                      child: const Tab(
                        text: "Ihram",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: responsive(12, context)),
                      child: const Tab(
                        text: "Tawaf al-Umrah",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: responsive(12, context)),
                      child: const Tab(
                        text: "Sa'ii",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: responsive(12, context)),
                      child: const Tab(
                        text: "Halq or Taqsir",
                      ),
                    ),
                  ]),
            ),

            // Guidance steps
              Expanded(
                child: TabBarView(children: [

                  // ihramSteps
                 Consumer<IhramStepsProvider>(builder: (context, ihramSteps, child){
                   return  ListView.builder(
                       shrinkWrap: true,
                       primary: true,
                       padding: EdgeInsets.symmetric(
                           vertical: responsive(23, context),
                           horizontal: responsive(23, context)),
                       itemCount: ihramSteps.ihramSteps.length,
                       itemBuilder: (context, index) {
                         return GestureDetector(
                           onTap: (){
                             Get.to(()=> UmraGuideDetailScreen(
                               image: ihramSteps.ihramSteps[index].image!,
                               title: ihramSteps.ihramSteps[index].title!,
                               description: ihramSteps.ihramSteps[index].description!,
                             ));
                           },
                           child: GuideStepContainer(
                             image: ihramSteps.ihramSteps[index].image!,
                             title: ihramSteps.ihramSteps[index].title!,
                             description: ihramSteps.ihramSteps[index].description!,
                             isLast: index == ihramSteps.ihramSteps.length - 1 ? true : false,
                             index: index +1,
                           ),
                         );
                       });
                 }),

                  // Tawaf Steps
                  Consumer<TawafStepsProvider>(builder: (context, tawafSteps, child){
                    return  ListView.builder(
                        shrinkWrap: true,
                        primary: true,
                        padding: EdgeInsets.symmetric(
                            vertical: responsive(23, context),
                            horizontal: responsive(23, context)),
                        itemCount: tawafSteps.tawafSteps.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              Get.to(()=> UmraGuideDetailScreen(
                                image: tawafSteps.tawafSteps[index].image!,
                                title: tawafSteps.tawafSteps[index].title!,
                                description: tawafSteps.tawafSteps[index].description!,
                              ));
                            },
                            child: GuideStepContainer(
                              image: tawafSteps.tawafSteps[index].image!,
                              title: tawafSteps.tawafSteps[index].title!,
                              description: tawafSteps.tawafSteps[index].description!,
                              isLast: index == tawafSteps.tawafSteps.length - 1 ? true : false,
                              index: index +1,
                            ),
                          );
                        });
                  }),

                  // Sai Steps
                  Consumer<SaiStepsProvider>(builder: (context, saiSteps, child){
                    return  ListView.builder(
                      shrinkWrap: true,
                        primary: true,
                        padding: EdgeInsets.symmetric(
                            vertical: responsive(23, context),
                            horizontal: responsive(23, context)),
                        itemCount: saiSteps.saiSteps.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              Get.to(()=> UmraGuideDetailScreen(
                                image: saiSteps.saiSteps[index].image!,
                                title: saiSteps.saiSteps[index].title!,
                                description: saiSteps.saiSteps[index].description!,
                              ));
                            },
                            child: GuideStepContainer(
                              image: saiSteps.saiSteps[index].image!,
                              title: saiSteps.saiSteps[index].title!,
                              description: saiSteps.saiSteps[index].description!,
                              isLast: index == saiSteps.saiSteps.length - 1 ? true : false,
                              index: index +1,
                            ),
                          );
                        });
                  }),

                  //Halq
                  Padding(
                    padding: EdgeInsets.all(responsive(23, context)),
                    child: textPoppins(
                        context: context,
                        text: halq,
                        size: 16,
                        textAlign: TextAlign.justify),
                  ),
                ]),
              ),
          ],
        ),
      ),

    );
  }
}

class GuideStepContainer extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final bool isLast;
  final int index;

  const GuideStepContainer({
    super.key,
    required this.image,
    required this.isLast,
    required this.index,
    required this.title,
    required this.description
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: responsive(75, context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: responsive(50, context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                verticalSpace( 5, context,),
                textPoppins(
                    context: context,
                    text: "Step $index",
                    size: 15,
                    fontFamily: AppFonts.poppinsBold,
                    color: AppColors.GlobelColor),
                // verticalSpace(context: context, height: 5),
                // textPoppins(
                //     context: context,
                //     text: "3h 55m",
                //     size: 12,
                //     fontFamily: AppFonts.poppinsBold,
                //     color: Colors.black26),
              ],
            ),
          ),
          horizontalSpace( 15, context,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: responsive(8, context),
                width: responsive(8, context),
                decoration: const BoxDecoration(
                    color: AppColors.GlobelColor, shape: BoxShape.circle),
              ),


                  Expanded(
                      child: VerticalDivider(
                      color: isLast ? Colors.white : Colors.black26,
                      thickness: responsive(0, context),
                    ))
            ],
          ),
          horizontalSpace( 15, context,),
          Container(
            height: responsive(62, context),
            width: responsive(62, context),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(responsive(10, context)),
                image:  DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(image),
                )),
          ),
          horizontalSpace( 15, context,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                verticalSpace(5, context),
                textPoppins(
                    context: context,
                    text: title,
                    size: 15,
                    maxLines: 1,
                    fontFamily: AppFonts.poppinsSemiBold,
                    color: AppColors.GlobelColor),
                verticalSpace(5, context),
                textPoppins(
                    context: context,
                    text:
                        description,
                    maxLines: 2,
                    textAlign: TextAlign.justify,
                    textOverflow: TextOverflow.ellipsis,
                    size: 12,
                    fontFamily: AppFonts.poppinsMedium,
                    color: Colors.black38),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



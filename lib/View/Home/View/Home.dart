//
// import 'dart:async';
// import 'dart:math';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:get/route_manager.dart';
// import 'package:huz/Responsive/ResponsiveClass.dart';
// import 'package:huz/TextStyles/Color.dart';
// import 'package:huz/View/Details/View/Details.dart';
// import 'package:huz/View/Home/View/trips/view/trips.dart';
//
// import 'package:provider/provider.dart';
//
// import '../../../Controller/pakagecontroller.dart';
// import '../../../TextStyles/styles.dart';
// import '../../TransportPageWidgets/View/Transport.dart';
// import '../../TransportPageWidgets/controller/transportController.dart';
// import '../widgets/CustomTabs.dart';
// import '../widgets/Filterbutton.dart';
// import '../widgets/MainPackages.dart';
// import '../widgets/Searchwidget.dart';
//
// class Home extends StatefulWidget {
//     int selectedIndex;
//     Home({super.key, this.selectedIndex = 0});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//
//
//   final List<String> iconPaths = [
//     'images/home_icon.svg',
//     'images/wishlist_icon.svg',
//     'images/trips_icon.svg',
//     'images/inbox_icon.svg',
//     'images/profile_icon.svg',
//   ];
//   final List<String> iconTitles = [
//     "Explore",
//     "Wishlist",
//     "Trips",
//     "Inbox",
//     "Profile",
//   ];
//   var imagess = [
//     'images/muharram.svg',
//     'images/kaaba.svg',
//     'images/muharram.svg',
//   ];
//   var selected=1;
//   var lengt=0;
//   int _selectedIndex = 0;
//   Widget bottombar(){
//     return Container(
//       decoration: BoxDecoration(
//           border: Border(
//             top: BorderSide(
//               color: Color(0xffE8E8E8),
//               width: 2.0, // Adjust border width as needed
//             ),
//           ),
//         color: Colors.white,
//       ),
//       height: responsive(75, context),
//
//       // notchMargin: 20,
//       // shape: const CircularNotchedRectangle(),
//       // notchMargin: 20,
//       child: Padding(
//         padding:  EdgeInsets.symmetric(horizontal: responsive(10, context),),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//
//           children: [
//          // Container(height: responsive(1.8, context), width: double.infinity, color: const Color(0xFFB2B2B2),),
//             Padding(
//               padding: EdgeInsets.only( bottom:responsive(02, context), left:responsive(20, context), right: responsive(20, context)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   for (int i = 0; i < iconPaths.length; i++)
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           widget.selectedIndex = i;
//                         });
//                       },
//                       child: Container(
//                         // width: responsive(50, context),
//                         color: Colors.transparent,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             if( i == 3)
//                               Badge(
//
//                                 label: Text("1",
//                                   style: TextStyle (color:  Colors.white),
//                                 ),
//                                 backgroundColor:  AppColors.GlobelColor,
//                                 isLabelVisible: true,
//
//                                 child: SvgPicture.asset(
//                                   iconPaths[i],
//                                   height: responsive(28, context),
//                                   width: responsive(28, context),
//                                   color: widget.selectedIndex == i
//                                       ? AppColors.GlobelColor
//                                       : Colors.grey[600],
//                                 ),
//
//                               ),
//
//
//
//                             if( i != 3)
//
//                               SvgPicture.asset(
//
//                                 iconPaths[i],
//                                 height: responsive(28, context),
//                                 width: responsive(28, context),
//                                 color: widget.selectedIndex == i
//                                     ? AppColors.GlobelColor
//                                     : AppColors.black,
//                               ),
//                             SizedBox(
//                               height: responsive(6, context),),
//                             Text(
//                               iconTitles[i],
//                               style: TextStyle(
//                                 fontFamily: 'Poppins',
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: responsive(12, context),
//                                 color:widget.selectedIndex == i
//                                     ? AppColors.GlobelColor
//                                     : AppColors.black,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       bottomNavigationBar: bottombar(),
//       backgroundColor: Colors.white,
//       body: Consumer<pakagecontrollers>(
//           builder: (context, packagecontroller, child){
//             if(packagecontroller.package==null){
//               packagecontroller.Getpackages('Umrah');
//             }
//
//           return widget.selectedIndex == 0 ? homeButton(context, packagecontroller) :  widget.selectedIndex  == 2 ? Trips() : SizedBox();
//
//         }
//       ),
//     );
//   }
//
//   Stack homeButton(BuildContext context, pakagecontrollers packagecontroller) {
//     return Stack(
//           alignment: Alignment.bottomCenter,
//           children: [
//             SafeArea(
//               child:
//
//               Padding(
//                 padding: EdgeInsets.only(top:responsive(20, context),bottom:responsive(20, context),),
//                 child: Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//
//                       Padding(
//                         padding:   EdgeInsets.symmetric(horizontal: responsive(20, context)),
//                         child: Search(context:context,onchange: (value){
//                         }),
//                       ),
//                       Stack(
//                         children: [
//                           SingleChildScrollView(
//                             physics: BouncingScrollPhysics(),
//                             scrollDirection: Axis.horizontal,
//                             child: Padding(
//                               padding:  EdgeInsets.only(top: responsiveHeight(35, context)),
//                               child: Row(
//                                 children: [
//                                   for (int i = 0; i < list.length; i++)
//                                     InkWell(
//                                       onTap: () async {
//                                         selected = i;
//
//                                         setState(() {
//
//                                         });
//                                         packagecontroller.isApiCalled=false;
//                                         packagecontroller.notifyListeners();
//                                         if(i==2){
//                                           packagecontroller.GetTransport();
//                                         }else{
//
//                                           // await Future.delayed(Duration(milliseconds: 500));
//                                           packagecontroller.Getpackages(list[i]);
//                                         }
//
//
//                                       },
//
//                                       child: Padding(
//                                         padding:  EdgeInsets.only(left: responsive(5, context),right: i==list.length-1?responsive(10, context):0.0),
//                                         child: CustomTab(
//                                           // url: imagess[i],
//                                           text:  list[i],
//                                           isSelected: i == selected, // Set isSelected to true for the initially selected tab
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Transform.translate(
//                             offset: Offset(responsive(0, context),responsive(63, context)),
//                             child: Container(
//                               width: MediaQuery.sizeOf(context).width,
//                               child: Divider(
//                                 // color: Colors.red,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       // SizedBox(
//                       //   height: responsive(0, context),
//                       // ),
//                       packagecontroller.isApiCalled==false?
//                       Padding(
//                         padding:  EdgeInsets.only(top: responsive(300, context)),
//                         child: Container(child: Center(child: CircularProgressIndicator(color: AppColors.GlobelColor,),),),
//                       ):
//                       selected==2?Expanded(
//                         child: ListView.builder(
//                             padding: EdgeInsets.symmetric(horizontal: responsive(20, context), vertical: responsive(10, context)),
//                             physics: AlwaysScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             primary: true,
//                             scrollDirection:Axis.vertical,
//                             itemCount: packagecontroller.transport?.results!.length,
//                             itemBuilder: (context,i){
//                               int lengt =  packagecontroller.transport!.results!.length;
//
//                               // if(i >= packagecontroller.length){
//                               //   return Container(
//                               //     height: responsive(100, context),
//                               //   );
//                               // } else{
//
//                               return Padding(
//                                 padding:  EdgeInsets.only(bottom: i==lengt - 1? responsive(120, context):responsive(0, context)),
//                                 child:
//
//                                 Transportpackage(
//                                   index: i,
//                                 ),
//                               );
//                               // }
//
//                             }),
//                       ) :
//                       Expanded(
//                         child: ListView.builder(
//                             padding: EdgeInsets.symmetric(horizontal: responsive(20, context), vertical: responsive(10, context)),
//                             physics: AlwaysScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             primary: true,
//                             scrollDirection:Axis.vertical,
//                             itemCount:packagecontroller.package?.results!.length,
//                             itemBuilder: (context,i){
//                               int lengt =  packagecontroller.package!.results!.length;
//
//                               var pkg = packagecontroller.package?.results?[i];
//                               return Padding(
//                                 padding: EdgeInsets.only(bottom:i==lengt - 1? responsive(120, context):responsive(0, context)),
//                                 child: InkWell(
//                                     onTap: (){
//                                       packagecontroller.details = null;
//                                       packagecontroller.include =[];
//                                       packagecontroller.exclude=[];
//                                       packagecontroller.notifyListeners();
//                                       Get.to(Details(token: pkg?.huzToken));
//                                     },
//                                     child: MainPackages(
//                                       url: i,
//                                       title: pkg?.packageName,
//                                       subtitle: pkg?.packageName,
//                                       amount: pkg?.packageCost,
//                                       // rating: pkg?.hotelInfoDetail?[i]
//                                       //     .hotelRating,
//                                       start: pkg?.startDate,
//                                       end: pkg?.endDate,
//                                     )),
//                               );
//                             }
//
//                         ),
//                       ),
//
//
//
//                     ],
//
//                   ),
//
//                 ),
//               ),
//             ),
//
//           ],
//         );
//   }
// }
//
//
//
//
// class sugesstioncard extends StatefulWidget {
//   var url, title, subtitle, amount;
//   sugesstioncard({super.key, this.url,this.title,this.subtitle,this.amount});
//
//   @override
//   State<sugesstioncard> createState() => _sugesstioncardState();
// }
//
// class _sugesstioncardState extends State<sugesstioncard> {
//   var currentImageUrl ="";
//
//   void startRandomImageTimer() {
//     Timer.periodic(Duration(seconds:2), (timer) {
//       setState(() {
//         // Randomly select an image URL
//         final random = Random();
//         final randomIndex = random.nextInt(widget.url.length);
//
//         print(randomIndex);
//         try{
//           currentImageUrl = "http://159.89.172.34${widget.url[randomIndex].hotelPhotos[0].hotelPhotos}";
//         }catch(e){
//           print(e);
//         }
//
//
//       });
//     });
//   }
//
//   @override
//   void initState() {
//      startRandomImageTimer();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:  EdgeInsets.symmetric(vertical: responsive(10, context),horizontal: responsive(20, context)),
//       child: Container(
//         child:  Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   width: responsive(85, context),
//                   height: responsive(78, context),
//                   decoration: BoxDecoration(
//                     color: AppColors.grayboxcolor.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(responsive(10, context)),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(responsive(10, context)),
//                     child: CachedNetworkImage(
//                       imageUrl: currentImageUrl,
//                       placeholder: (context, url) => Image.asset('images/errorimage.jpeg',
//                         fit: BoxFit.cover,
//                       ),
//                       errorWidget: (context, url, error) => Image.asset('images/errorimage.jpeg',
//                         fit: BoxFit.cover,
//                       ),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: responsive(10, context),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Heading2(
//                       center: false,
//                       context: context,
//                       text: '${widget.title}',
//
//                     ),
//                     cardsubtitle(
//                         center: false,
//                         context: context,
//                         text: '${widget.subtitle}',
//                         color: AppColors.grayboxcolor
//                     ),
//                     // cardsubtitle(
//                     //     center: false,
//                     //     context: context,
//                     //     text: 'Continental hotel in saudia',
//                     // )
//                   ],
//                 ),
//               ],
//             ),
//
//             Column(
//               children: [
//                 cardtrailing2(
//                   center: false,
//                   context: context,
//                   text: 'PKR ${widget.amount.toStringAsFixed(0)}',
//                   color: AppColors.GlobelColor
//                 ),
//                 // cardtrailingsubtitle(
//                 //   center: false,
//                 //   context: context,
//                 //   text: 'Per Day',
//                 //     color: AppColors.grayboxcolor
//                 // ),
//               ],
//             )
//           ],
//         ) ,
//       ),
//     );
//   }
// }
// //
//
//
// // class sugesstioncard extends StatelessWidget {
// //   const sugesstioncard({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding:  EdgeInsets.symmetric(vertical: responsive(10, context),horizontal: responsive(20, context)),
// //       child: Container(
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             Row(
// //               children: [
// //                 Container(
// //                   width: responsive(85, context),
// //                   height: responsive(78, context),
// //                   decoration: BoxDecoration(
// //                     color: AppColors.grayboxcolor.withOpacity(0.2),
// //                     borderRadius: BorderRadius.circular(responsive(10, context)),
// //                   ),
// //                   child: ClipRRect(
// //                     borderRadius: BorderRadius.circular(responsive(10, context)),
// //                     child: CachedNetworkImage(
// //                       imageUrl: 'https://media.istockphoto.com/id/535695503/photo/pakistan-monument-islamabad.jpg?s=612x612&w=0&k=20&c=bNqjdf8L-5igcRB89DdMgx0kNOmyeo1J_zzXmoxxl8w=',
// //                       placeholder: (context, url) => Center(child: CircularProgressIndicator(color: AppColors.GlobelColor,)),
// //                       errorWidget: (context, url, error) => Icon(Icons.error,color: AppColors.GlobelColor ,),
// //                       fit: BoxFit.cover,
// //                     ),
// //                   ),
// //                 ),
// //                 SizedBox(
// //                   width: responsive(10, context),
// //                 ),
// //                 Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Heading2(
// //                       center: false,
// //                       context: context,
// //                       text: 'Continental',
// //
// //                     ),
// //                     cardsubtitle(
// //                         center: false,
// //                         context: context,
// //                         text: 'Saudia arbia',
// //                         color: AppColors.grayboxcolor
// //                     ),
// //                     cardsubtitle(
// //                       center: false,
// //                       context: context,
// //                       text: 'Continental hotel in saudia',
// //                     )
// //                   ],
// //                 ),
// //               ],
// //             ),
// //
// //             Column(
// //               children: [
// //                 cardtrailing2(
// //                     center: false,
// //                     context: context,
// //                     text: '\$1000',
// //                     color: AppColors.GlobelColor
// //                 ),
// //                 cardtrailingsubtitle(
// //                     center: false,
// //                     context: context,
// //                     text: 'Per Day',
// //                     color: AppColors.grayboxcolor
// //                 ),
// //               ],
// //             )
// //           ],
// //         ) ,
// //       ),
// //     );
// //   }
// // }
//
//
// // ListView.builder(
// // physics: NeverScrollableScrollPhysics(),
// // shrinkWrap: true,
// // primary: true,
// // scrollDirection:Axis.vertical,
// // itemCount: packages.length,
// // itemBuilder: (context,i){
// // var pkg = packages.package?.results?[i];
// // return InkWell(
// //
// // onTap: (){
// // packages.details = null;
// // packages.notifyListeners();
// // Get.to(Details(token: pkg?.huzToken));
// // },
// // child: sugesstioncard(url: pkg?.hotelInfoDetail,title: pkg?.packageType,subtitle: pkg?.packageName,amount: pkg?.packageCost,));
// // }),
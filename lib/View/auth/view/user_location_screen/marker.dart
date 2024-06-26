// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gif/flutter_gif.dart';
// import 'package:gif/gif.dart';
// import '../../../utils/BaseUrls/BaseUrls.dart';
// class homemarker extends StatefulWidget {
//   var url;
//   homemarker({this.url});
//
//   @override
//   State<homemarker> createState() => _homemarkerState();
// }
//
// class _homemarkerState extends State<homemarker>  with TickerProviderStateMixin {
//   late FlutterGifController controller1, controller2, controller3, controller4;
//   @override
//   void initState() {
//     super.initState();
//     controller1 = FlutterGifController(vsync: this);
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       controller1.repeat(
//         min: 0,
//         max: 53,
//         period: const Duration(milliseconds: 200),
//       );
//     });
//
//   }
//
//   // @override
//   // void dispose() {
//   //   _controller?.dispose();
//   //   super.dispose();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         // Gif(
//         //   height: 150,
//         //   width: 100,
//         //   autostart: Autostart.loop,
//         //   placeholder: (context) =>
//         //   const Center(child: CircularProgressIndicator()),
//         //   image: const AssetImage('assets/images/riple.gif'),
//         // ),
//         CircleAvatar(
//           radius: 16, // specify the radius of the circular container
//           backgroundColor: Colors.grey[100], // set the background color of the container
//           child: ClipOval(
//             child: CachedNetworkImage(
//               placeholder: (context, url) =>Icon(Icons.person,size: 30,color: Colors.grey,),
//               errorWidget: (context, url, error) => Icon(Icons.person,size: 30,color: Colors.grey,),
//               imageUrl: '${baseUrl.baseURLi}${widget.url}', // replace with the URL of your image
//               fit: BoxFit.cover,
//               width: 30,
//               height: 30,
//             ),
//           ),
//         ),
//
//
//       ],
//     );
//   }
// }
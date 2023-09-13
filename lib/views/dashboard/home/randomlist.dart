// import 'dart:math';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:ecommerse/utils/helper_function.dart';
// import 'package:ecommerse/utils/image_constant.dart';
// import 'package:ecommerse/utils/responsive_class.dart';
// import 'package:flutter/material.dart';

// class RandomList extends StatefulWidget {
  
//   const RandomList({super.key});

//   @override
//   _RandomList createState() => _RandomList();
// }

// class _RandomList extends State<RandomList> {
//   int currentIndexforimage1 = 0;
//   int currentIndexforimage2 = 0;
//   int currentIndexforimage3 = 0;
//   Random random = Random();

//   @override
//   void initState() {
//     super.initState();
//     _startDisplay();
//   }

//   void _startDisplay() {
//     Future.delayed(const Duration(seconds: 3), () {
//       if (mounted) {
//         setState(() {
//           currentIndexforimage1 = random.nextInt(ImageConstant.items.length);
//           currentIndexforimage2 = random.nextInt(ImageConstant.items.length);
//           currentIndexforimage3 = random.nextInt(ImageConstant.items.length);
//         });
//         _startDisplay();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size=responseMediaQuery(context);

//     return Scaffold(
//       body: Padding(
//         padding:  EdgeInsets.only(left:size.width*0.05,top:size.width*0.03,bottom:size.width*0.03),
//         child: Container(
//           decoration: BoxDecoration(color: const Color.fromARGB(153, 160, 174, 171),borderRadius: BorderRadius.circular(80)),
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     height: Responsive.isDesktop(context)? size.width*0.4:size.width*0.3,
//                     width: double.infinity,
//                     decoration:  BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(15)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(1.0),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: CachedNetworkImage(
//                           imageUrl:ImageConstant.items[currentIndexforimage1].img, 
//                           fit: BoxFit.fill,  
//                           imageBuilder: (context, imageProvider) => Container(
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                   image: imageProvider,
//                                   fit: BoxFit.cover,
//                                   colorFilter:
//                                       ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
//                             ),
//                           ),
//                           placeholder: (context, url) => CircularProgressIndicator(),
//                           errorWidget: (context, url, error) => Icon(Icons.error),     
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                    height: Responsive.isDesktop(context)? size.width*0.4:size.width*0.3,
//                     width: double.infinity,
//                     decoration:  BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(15)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(1.0),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: CachedNetworkImage(
//                           imageUrl:ImageConstant.items[currentIndexforimage2].img,  
//                           fit: BoxFit.cover,    
//                           imageBuilder: (context, imageProvider) => Container(
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                   image: imageProvider,
//                                   fit: BoxFit.cover,
//                                   colorFilter:
//                                       ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
//                             ),
//                           ),
//                           placeholder: (context, url) => CircularProgressIndicator(),
//                           errorWidget: (context, url, error) => Icon(Icons.error),    
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: Responsive.isDesktop(context)? size.width*0.4:size.width*0.3,
//                     width: double.infinity,
//                     decoration:  BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(15)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(1.0),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: CachedNetworkImage(
//                           imageUrl:ImageConstant.items[currentIndexforimage3].img,  
//                           fit: BoxFit.cover,    
//                           imageBuilder: (context, imageProvider) => Container(
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                   image: imageProvider,
//                                   fit: BoxFit.cover,
//                                   colorFilter:
//                                       ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
//                             ),
//                           ),
//                           placeholder: (context, url) => CircularProgressIndicator(),
//                           errorWidget: (context, url, error) => Icon(Icons.error),    
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

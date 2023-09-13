import 'package:ecommerse/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../utils/color_constant.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? errorHeight;
  final double? errorWidth;  

  const CustomCachedNetworkImage( {super.key, 
    required this.imageUrl,
    this.height,
    this.errorHeight,
    this.errorWidth
  });

  @override
  Widget build(BuildContext context) {
    Size size=responseMediaQuery(context);
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.fill,
      height: height,
      placeholder: (context, url) => Container(height: errorHeight,width: errorWidth,decoration: const BoxDecoration(color: Color.fromARGB(255, 233, 230, 230)), child: Center(child: SizedBox(
        height: size.width * 0.05,
        width: size.width * 0.05,
        child: const CircularProgressIndicator(color: ColorConstant.primaryColor,strokeWidth: 3)))),
      errorWidget: (context, url, error) => Container(height: errorHeight,width: errorWidth,decoration: const BoxDecoration(color: Color.fromARGB(255, 233, 230, 230)),child: const Center(child: Icon(Icons.error_outline)))
    );
  }
}

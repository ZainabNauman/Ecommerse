import 'package:flutter/material.dart';

import '../utils/responsive_class.dart';
import 'desktop_screen.dart';
import 'mobile_screen.dart';
import 'tablet_screen.dart';


class Ecommerse extends StatelessWidget {
  const Ecommerse({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print("width: $width");
    print("height: $height");

    return const Responsive(
      mobile: MobileLayout(), // Widget for mobile view
      tablet: TabletLayout(), // Widget for tablet view
      desktop: DesktopLayout(), // Widget for desktop view
    );
  }
}

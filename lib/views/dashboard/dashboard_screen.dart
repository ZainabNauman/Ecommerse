import 'package:ecommerse/provider/person_provider.dart';
import 'package:ecommerse/utils/color_constant.dart';
import 'package:ecommerse/utils/responsive_class.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/dashboard_provider.dart';
import '../../utils/helper_function.dart';
import '../../utils/media_query.dart';
import 'home/vertical_navigationbar_widget.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, UserDataProvider? userDataProvider});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    
    dashboardProvider.role(context);
    
    double width = displayWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Responsive.isMobile(context)
          ? dashboardProvider.usertype[dashboardProvider.currentIndex]
          : Responsive.isTablet(context)
              ? Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: VerticalNavigationBar(
                        currentIndex: dashboardProvider.currentIndex,
                        changeIndex: dashboardProvider.changeIndex,
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: dashboardProvider.usertype[dashboardProvider.currentIndex],
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 1,
                      child: VerticalNavigationBar(
                        currentIndex: dashboardProvider.currentIndex,
                        changeIndex: dashboardProvider.changeIndex,
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: dashboardProvider.usertype[dashboardProvider.currentIndex],
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ),
      bottomNavigationBar: Responsive.isMobile(context)
          ? Padding(
              padding: EdgeInsets.only(left: width * 0.01, right: width * 0.01, bottom: width * 0.01),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: BottomNavigationBar(
                  backgroundColor: ColorConstant.primaryColor,
                  items: dashboardProvider.bottomNavigationBarItems,
                  currentIndex: dashboardProvider.currentIndex,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: const Color.fromARGB(255, 214, 213, 213),
                  showUnselectedLabels: true,
                  selectedIconTheme: IconThemeData(
                    size: responseSize(width * 0.06, context),
                  ),
                  onTap: (index) {
                    print("Tapped index: $index");
                    if (index >= 0 && index < dashboardProvider.bottomNavigationBarItems.length) {
                      dashboardProvider.changeIndex(index);
                    }
                  },
                ),
              ),
            )
          : null,
    );
  }
}

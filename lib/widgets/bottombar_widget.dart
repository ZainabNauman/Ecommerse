import 'package:flutter/material.dart';

import '../utils/media_query.dart';



class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width=displayWidth(context);
    return  Padding(
      padding: EdgeInsets.only(left: width*0.01,right:width*0.01,bottom: width*0.01),
      child: ClipRRect(
          borderRadius:BorderRadius.circular(40),
          child: BottomNavigationBar(
            backgroundColor: Color.fromARGB(153, 215, 210, 210),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'History',  
                )
              ],
              currentIndex: selectedIndex,
              selectedItemColor: Colors.black,
              selectedIconTheme:IconThemeData(
                size: width<650 ?width*0.06
              :width>650&&width<750 ?width*0.04
              :width>750&&width<850 ?width*0.038
              :width>850&&width<950 ?width*0.035
              :width>950&&width<1050 ?width*0.031
              :width>1050&&width<1150 ?width*0.028
              :width>=1150 && width<1250 ?width*0.025
              :width>=1250 && width<1350 ?width*0.023
              :width>=1350 && width<1450 ?width*0.021
              :width>=1450 && width<1600 ?width*0.019
              :width*0.07),
              onTap: _onItemTapped,
            ),
        ),
      );
  }
}

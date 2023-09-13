
import 'package:ecommerse/utils/color_constant.dart';
import 'package:ecommerse/utils/helper_function.dart';
import 'package:ecommerse/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../../provider/person_provider.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen>  with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: const Offset(0.0, -0.5), 
      end: Offset.zero, 
    ).animate(_controller);

    _controller.forward();
    SchedulerBinding.instance.addPostFrameCallback((_) {
     Provider.of<UserDataProvider>(context, listen: false).getCurrentUserAndFetchData(context);
    });
    
  }

  @override
  void dispose() {
    _controller.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size =responseMediaQuery(context);
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: ColorConstant.primaryColor,
          child:  SlideTransition(
            position: _animation,
            child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
              Container(decoration: const BoxDecoration(color: Colors.black,shape: BoxShape.circle),
                child: Padding(padding: EdgeInsets.all(size.width*0.02),
                  child: Icon(Icons.chair,size: size.width*0.2,color: Colors.white))),
                Stack(children: [
                  Text("House Fittings",
                    style: TextStyle(   
                      fontFamily: StringConstant.font,
                      fontSize: size.width*0.1,
                      letterSpacing: 5,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 10
                        ..color = Colors.black)),
                  Text("House Fittings",
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 5,
                      fontFamily: StringConstant.font,
                      fontSize: size.width*0.1,
                      fontWeight: FontWeight.bold))])])))));
  }
}
  

import 'package:ecommerse/provider/addtocart_provider.dart';
import 'package:ecommerse/provider/admin_provider.dart';
import 'package:ecommerse/provider/bookmark_provider.dart';
import 'package:ecommerse/provider/dashboard_provider.dart';
import 'package:ecommerse/provider/edit_profile_provider.dart';
import 'package:ecommerse/provider/orderdetail_page.dart';
import 'package:ecommerse/provider/orderlisthistory_provider.dart';
import 'package:ecommerse/provider/person_provider.dart';
import 'package:ecommerse/views/onBoarding/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'provider/authEmailandPassword_Provider.dart';
import 'provider/profile_provider.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

 runApp(MultiProvider(providers: [
  ChangeNotifierProvider<UserDataProvider>(create: (context) => UserDataProvider()),
  ChangeNotifierProvider<DashboardProvider>(create: (context) => DashboardProvider()),
  ChangeNotifierProvider<AdminPageProvider>(create: (context) => AdminPageProvider()),
  ChangeNotifierProvider<ProfileProvider>(create: (context) => ProfileProvider(context)),
  ChangeNotifierProvider<ProfileDataProvider>(create: (context) => ProfileDataProvider()),
  ChangeNotifierProvider<OrderListHistoryProvider>(create: (context) => OrderListHistoryProvider()),
  ChangeNotifierProvider<OrderDetailProvider>(create: (context) => OrderDetailProvider()),
  ChangeNotifierProvider<AddtoCartProvider>(create: (context) => AddtoCartProvider()),
  ChangeNotifierProvider<BookmarkProvider>(create: (context) => BookmarkProvider()),
  ChangeNotifierProvider<AuthServiceEmailPassword>(create: (context) => AuthServiceEmailPassword()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

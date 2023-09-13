
// import 'package:ecommerse/views/dashboard/dashboard_screen.dart';
// import 'package:ecommerse/views/onBoarding/login.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../provider/person_provider.dart';

// class AuthEmailPassword extends StatelessWidget {
//   const AuthEmailPassword({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.active) {
//             final user = snapshot.data;
//            if (user == null) {
//               return const LoginInScreen();
//             } else {
//              return FutureBuilder<void>(
//                 future: getuseranddata(context),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
                   
//                     return DashboardScreen(userDataProvider: userDataProvider);
//                   } else {
//                     return CircularProgressIndicator();
//                   }
//                 },
//               );
//             }
//           } else {
//            return CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }
//   Future<void> getuseranddata(BuildContext context) async {
//     final userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
//     await userDataProvider.getCurrentUserAndFetchData();
//     // print("zainabnnnn");
//     // print(userDataProvider.profileData.brand);
//     // print("zainabnnnn");
//   }
// }

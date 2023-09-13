import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerse/utils/color_constant.dart';
import 'package:ecommerse/utils/helper_function.dart';
import 'package:ecommerse/utils/string_constant.dart';
import 'package:ecommerse/views/dashboard/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/person_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../../utils/responsive_class.dart';
import '../../../widgets/custom_appbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool loader=true;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final userDataProvider = Provider.of<UserDataProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    profileProvider.updateProfileDataList(context);
    Size size=responseMediaQuery(context);
    return 
    Scaffold(
      appBar: CustomAppBar(title: 'Profile',
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
          }, 
          icon: const Icon(Icons.edit)),
          IconButton(onPressed:(){
            profileProvider.signOut(context);
          }, 
          icon: const Icon(Icons.logout))]),
      body: Center(
        child: Row(children: [       
            Expanded(
              flex: Responsive.isDesktop(context) ?8:10,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(size.width*0.02),
                  child: Container(
                    width: screenWidth * 0.8,
                    padding: EdgeInsets.all(size.width*0.04),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3))]),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                       Container(decoration:const BoxDecoration(color: ColorConstant.primaryColor,shape: BoxShape.circle), height: size.width*0.5,width: size.width*0.5,child: ClipRRect(borderRadius: BorderRadius.circular(100),child: CachedNetworkImage(width: double.infinity,imageUrl: userDataProvider.profileData.img,fit: BoxFit.fill,))),
                        SizedBox(height: size.width*0.01),
                        Text(userDataProvider.profileData.name,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: StringConstant.font)),
                        SizedBox(height: size.width*0.01),
                        Text(userDataProvider.profileData.email,
                          style: TextStyle(
                            fontSize: size.width*0.04,
                            color: Colors.black,
                            fontFamily: StringConstant.font)),
                        SizedBox(height: size.width*0.01),
                        Wrap(children: [
                          IntrinsicHeight(
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Text(userDataProvider.profileData.phoneno,
                              style: TextStyle(
                                fontSize: size.width*0.04,
                                color: Colors.black,
                                fontFamily: StringConstant.font)),
                              VerticalDivider(thickness: size.width*0.001,color: Colors.black,),
                               Wrap(children: [
                                Text(userDataProvider.profileData.address,
                                  style: TextStyle(
                                  fontSize: size.width*0.04,
                                  color: Colors.black,
                                  fontFamily: StringConstant.font))])]))]),                        
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: profileProvider.profileDataList.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.all(size.width * 0.03),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(5),
                                            boxShadow:  [
                                              BoxShadow(color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 3,
                                                blurRadius: 7,
                                                offset: const Offset(0, 3))]),
                                          width: size.width * 0.9,
                                          child: Padding(
                                            padding: EdgeInsets.all(size.width * 0.05),
                                            child: Row(
                                              children: [
                                                profileProvider.profileDataList[index].icon,
                                                SizedBox(width: size.width*0.03),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(profileProvider.profileDataList[index].title,
                                                      style: TextStyle(
                                                        fontFamily: StringConstant.font,
                                                        fontWeight: FontWeight.w500,
                                                      )),
                                                      SizedBox(height: size.width*0.01),
                                                    Text(
                                                      profileProvider.profileDataList[index].value,
                                                      style: TextStyle(
                                                        fontFamily: StringConstant.font,
                                                        fontWeight: FontWeight.bold))]),
                                              ]))));
                                    })])))))])));
  }
}
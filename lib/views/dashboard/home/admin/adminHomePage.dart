import 'package:ecommerse/provider/admin_provider.dart';
import 'package:ecommerse/utils/color_constant.dart';
import 'package:ecommerse/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'adminUserList.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    final adminProvider = Provider.of<AdminPageProvider>(context, listen: false);
    adminProvider.fetchUsersWithoutAdminAndCustomer();
    adminProvider.fetchUsersWithoutBrandAndAdmin();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('TabBar Widget', style: TextStyle(fontFamily: StringConstant.font)),
        backgroundColor: ColorConstant.primaryColor,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const <Widget>[
            Tab(text: 'Customers',
              icon: Icon(Icons.groups_sharp),),
            Tab(text: "Vendors",
              icon: Icon(Icons.person),
            )])),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          AdminUsersList(usersType: UsersType.withoutBrandAndAdmin ),
          AdminUsersList(usersType: UsersType.withoutAdminAndCustomer)]));
  }
}


enum UsersType {
  withoutAdminAndCustomer,
  withoutBrandAndAdmin,
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/person_model.dart';
import '../../../../provider/admin_provider.dart';
import '../../../../utils/helper_function.dart';
import '../../../../utils/string_constant.dart';
import 'adminHomePage.dart';
import 'userDetailPage.dart';

class AdminUsersList extends StatelessWidget {
  final UsersType usersType;

  const AdminUsersList({Key? key, required this.usersType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = responseMediaQuery(context);
    final adminProvider = Provider.of<AdminPageProvider>(context);
    final List<PersonModel> usersList = usersType == UsersType.withoutAdminAndCustomer
        ? adminProvider.usersWithoutAdminAndCustomer
        : adminProvider.usersWithoutBrandAndAdmin;

    return ListView.builder(
      itemCount: usersList.length,
      itemBuilder: (context, index) {
        final user = usersList[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => UserDetailScreen(user: user)));
          },
          child: Padding(padding: EdgeInsets.all(size.width * 0.05),
            child: Card(elevation: 10,
              child: Padding(padding: EdgeInsets.all(size.width * 0.05),
                child: Column(children: [
                    Text(user.name,
                      style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.bold,fontSize: size.width * 0.05)),
                    Text(user.brand.isEmpty ? 'Customer' : user.brand,
                      style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.normal,fontSize: size.width * 0.05))])))));
      });
  }
}

import 'dart:io';

import 'package:ecommerse/utils/helper_function.dart';
import 'package:ecommerse/widgets/custom_appbar.dart';
import 'package:ecommerse/widgets/custom_button.dart';
import 'package:ecommerse/widgets/textfield_credentials.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../provider/edit_profile_provider.dart';
import '../../../provider/person_provider.dart';
import '../../../widgets/custom_showdialog.dart';


class EditProfilePage extends StatefulWidget {
  EditProfilePage({super.key});
  
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController imgController = TextEditingController();
  File? image1;

  @override
  void initState() {
    super.initState();
    final userDataProvider = Provider.of<UserDataProvider>(context,listen:false);
    nameController.text = userDataProvider.profileData.name;
    emailController.text = userDataProvider.profileData.email;
    phoneController.text = userDataProvider.profileData.phoneno;
    addressController.text = userDataProvider.profileData.address;
    birthdayController.text=userDataProvider.profileData.birthday;
    imgController.text=userDataProvider.profileData.img;
  }

  @override
  Widget build(BuildContext context) {
    final editProfileProvider = Provider.of<ProfileDataProvider>(context,listen:false);
    Size size=responseMediaQuery(context);
    return Scaffold(
      appBar: CustomAppBar(title: 'Edit Profile'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size.width*0.1),
          child: Column(
            children: [
              CustomTextFieldCredential(
                controller: nameController,
                hint: 'Name', icon: const Icon(Icons.person), isObscure: false, text: 'Enter Name',
              ),
              SizedBox(height: size.width*0.1,),
              CustomTextFieldCredential(
                controller: emailController,
                hint: 'Email', icon: const Icon(Icons.email), isObscure: false, text: 'Enter Email',
              ),
              SizedBox(height: size.width*0.1,),
              CustomTextFieldCredential(
                controller: phoneController,
                hint: 'PhoneNo', icon: const Icon(Icons.phone_android), isObscure: false, text: 'Enter PhoneNo',
              ),
              SizedBox(height: size.width*0.1,),
              CustomTextFieldCredential(
                controller: addressController,
                hint: 'Address', icon: const Icon(Icons.location_on), isObscure: false, text: 'Enter Address',
              ),
              SizedBox(height: size.width*0.1,),
              CustomTextFieldCredential(
                controller: imgController,
                hint: 'Image', icon: const Icon(Icons.image), isObscure: false, text: 'Enter Image',
              ),
              SizedBox(height: size.width*0.1,),
              CustomTextFieldCredential(
                controller: birthdayController,
                hint: 'Birthday', icon: const Icon(Icons.cake), isObscure: false, text: 'Enter Address',
              ),
              SizedBox(height: size.width*0.15,),           
              CustomButton(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                    return CustomDeleteConfirmationDialog(
                      onCancel: () {
                      Navigator.of(context).pop();
                    },
                    onConfirm:  () {
                      if(emailController.text.trim().isNotEmpty && nameController.text.trim().isNotEmpty &&phoneController.text.trim().isNotEmpty &&addressController.text.trim().isNotEmpty &&birthdayController.text.trim().isNotEmpty ) {
                      editProfileProvider.updateProfileData(context,nameController.text.trim(),birthdayController.text.trim(),addressController.text.trim(),phoneController.text.trim(),emailController.text.trim(),imgController.text.trim());
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }}, 
                    button1text: 'No', button2text: 'Yes', description: 'Are you sure you want to Update?', heading: 'Update Data');}
                  );
                },
                text: 'Update')])))
    );
  }  
 
  Future pickImage() async{
    
    final image= await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image==null) return;

    final tempImage=File(image.path);
    setState(() => this.image1=tempImage);
  }

}

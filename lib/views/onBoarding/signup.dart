import 'package:ecommerse/utils/color_constant.dart';
import 'package:ecommerse/utils/helper_function.dart';
import 'package:ecommerse/utils/string_constant.dart';
import 'package:ecommerse/views/onBoarding/login.dart';
import 'package:ecommerse/widgets/textfield_credentials.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/person_provider.dart';
import '../../widgets/custom_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameTfController = TextEditingController();
  final emailTfController = TextEditingController();
  final passwordTfController = TextEditingController();
  final phoneTfController = TextEditingController();
  final addressTfController = TextEditingController();
  final birthdayTfController = TextEditingController();
  final brandTfController = TextEditingController();
  final imgTfController=TextEditingController();
  int selectedOption=1;

  @override
  Widget build(BuildContext context) {
    Size size=responseMediaQuery(context);
    var p = Provider.of<UserDataProvider>(context,listen: false);
    var plisten = Provider.of<UserDataProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(size.width*0.05),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
            Text(StringConstant.titleSignUp,style:TextStyle(fontSize: 30, fontWeight: FontWeight.bold,fontFamily: StringConstant.font)),
            SizedBox(height: size.width*0.03,),
            Text(StringConstant.descriptionSignUp,style: TextStyle(color: Colors.grey.shade600,fontSize: 15,fontWeight: FontWeight.normal,fontFamily: StringConstant.font),),
            SizedBox(height: size.width*0.05),
            CustomTextFieldCredential(
                hint: StringConstant.email,
                icon: const Icon(Icons.email),
                isObscure: false,
                text: StringConstant.emailtext,
                controller: emailTfController),
            SizedBox(height: size.width*0.05),
            CustomTextFieldCredential(
                hint: StringConstant.name,
                icon: const Icon(Icons.person),
                isObscure: false,
                text: StringConstant.nametext,
                controller: nameTfController),
            SizedBox(height: size.width*0.05),
            CustomTextFieldCredential(
              controller: passwordTfController,
              hint: StringConstant.password,
              icon: const Icon(Icons.lock),
              text: StringConstant.passwordtext,
              sufixicon: IconButton(
                icon: Icon(plisten.loginIsobscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  p.changeloginIsobscure(!plisten.loginIsobscure);
                }),
              isObscure: plisten.loginIsobscure),
            SizedBox(height: size.width*0.05),
            CustomTextFieldCredential(
                hint: StringConstant.phone,
                icon: const Icon(Icons.phone_android),
                isObscure: false,
                text: StringConstant.phoneLabel,
                controller: phoneTfController),
            SizedBox(height: size.width*0.05),
            CustomTextFieldCredential(
                hint: StringConstant.address,
                icon: const Icon(Icons.place),
                isObscure: false,
                text: StringConstant.addressLabel,
                controller: addressTfController),
            SizedBox(height: size.width*0.05),
            CustomTextFieldCredential(
                hint: StringConstant.birthday,
                icon: const Icon(Icons.cake),
                isObscure: false,
                text: StringConstant.birthdayLabel,
                controller: birthdayTfController),
            SizedBox(height: size.width*0.05),
            CustomTextFieldCredential(
                hint: "Image",
                icon: const Icon(Icons.email),
                isObscure: false,
                text: "Enter Image",
                controller: imgTfController),
            SizedBox(height: size.width*0.05),
              Center(
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                    Expanded(flex: 1,
                      child: Row(children: [
                        Radio(value: 1, 
                          groupValue: selectedOption,
                          activeColor: ColorConstant.primaryColor, 
                          fillColor: MaterialStateProperty.all(ColorConstant.primaryColor), 
                          splashRadius: 20, 
                          onChanged: (index) {
                            setState(() {
                              selectedOption = index!;
                            });
                          }),
                          Expanded(child: Text('Customer',style: TextStyle(fontFamily: StringConstant.font)))])),
                    Expanded(flex: 1,
                      child: Row(children: [
                        Radio(value: 2,
                          groupValue: selectedOption,
                          activeColor: ColorConstant.primaryColor, 
                          fillColor: MaterialStateProperty.all(ColorConstant.primaryColor),
                          splashRadius: 20, 
                          onChanged: (index) { 
                            setState(() {
                              selectedOption = index!;
                            });
                          }),
                          Expanded(child: Text('Vendor',style: TextStyle(fontFamily: StringConstant.font)))
                      ]))])])),
              if (selectedOption==2) SizedBox(height: size.width*0.05),
              if (selectedOption==2) CustomTextFieldCredential(
                hint: "Brand",
                icon: const Icon(Icons.shopify_rounded),
                isObscure: false,
                text: "Enter Brand Name",
                controller: brandTfController),
                SizedBox(height: size.width*0.05),
              Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,children: [
                Checkbox(
                  value: plisten.signUpIsCkecked,
                  onChanged: (value) {
                    p.changesignUpIsCkecked(value!);
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
                Flexible(
                  child: Text(StringConstant.termscondition,
                    maxLines: 2,
                    style: TextStyle(overflow: TextOverflow.ellipsis,fontWeight: FontWeight.w200,fontFamily: StringConstant.font)))]),
              SizedBox(height: size.width*0.1),
              plisten.loginLoader ? const Center(child: CircularProgressIndicator(color: ColorConstant.primaryColor,strokeWidth: 2,)) : Center(
                child: CustomButton(
                  color: Colors.white,
                  text: StringConstant.buttonSignUp,
                  onTap: () {
                    if(selectedOption!=2 && selectedOption!=3)brandTfController.text="";
                    p.signUpTap(context, emailTfController.text.trim(), passwordTfController.text.trim(),nameTfController.text.trim(), birthdayTfController.text.trim(), addressTfController.text.trim(),phoneTfController.text.trim(), brandTfController.text.trim(),imgTfController.text.trim());
                  })),
              SizedBox(height: size.width*0.075),
              GestureDetector(
                onTap: () {
                  tapsignintextbutton(context);
                },
                child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                    Text(StringConstant.alreadyaccountexistSignUp,style: TextStyle(fontFamily: StringConstant.font),),
                    Text(StringConstant.boldSignIn,
                      style: TextStyle(fontWeight: FontWeight.bold,fontFamily: StringConstant.font))]))]))));
  }
  void tapsignintextbutton(BuildContext context) {
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const LoginInScreen()));
  } 
}
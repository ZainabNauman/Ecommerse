import 'package:ecommerse/utils/helper_function.dart';
import 'package:ecommerse/views/onBoarding/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/person_provider.dart';
import '../../utils/color_constant.dart';
import '../../utils/string_constant.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/textfield_credentials.dart';

class LoginInScreen extends StatefulWidget {
  const LoginInScreen({super.key});

  @override
  State<LoginInScreen> createState() => _LoginInScreenState();
}

class _LoginInScreenState extends State<LoginInScreen> {

  final emailTfController = TextEditingController();
  final passwordTfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size=responseMediaQuery(context);
    var p = Provider.of<UserDataProvider>(context,listen: false);
    var plisten = Provider.of<UserDataProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(size.width*0.1),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Login In",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,fontFamily: StringConstant.font)),
                  SizedBox(height: size.width*0.1,),
                  Text(StringConstant.descriptionSignIn,
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,fontFamily: StringConstant.font),
                  ),
                  SizedBox(height: size.width*0.1,),
                  CustomTextFieldCredential(
                      hint: StringConstant.email,
                      icon: const Icon(Icons.person),
                      isObscure: false,
                      text: StringConstant.emailLabel,
                      controller: emailTfController),
                  SizedBox(height: size.width*0.1,),
                  CustomTextFieldCredential(
                    controller: passwordTfController,
                    hint: StringConstant.password,
                    text: StringConstant.passwordtext,
                    icon: const Icon(Icons.lock),
                    sufixicon: IconButton(
                    icon: Icon(plisten.loginIsobscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                     p.changeloginIsobscure(!plisten.loginIsobscure);
                    }),
                  isObscure: plisten.loginIsobscure,
                  ),
                  SizedBox(height: size.width*0.1,),
                  plisten.loginLoader ? const Center(child: CircularProgressIndicator(color: ColorConstant.primaryColor,strokeWidth: 2,)) : Center(
                    child: CustomButton(
                        color: Colors.white,
                        text: "LOGIN IN",
                        onTap: () {
                           p.signInTap(context, emailTfController.text.trim(), passwordTfController.text.trim());
                        })),
                  SizedBox(height: size.width*0.1,),
                  GestureDetector(
                    onTap: () {
                      tapsignuptextbutton(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(StringConstant.nopastaccountSignIn,style: TextStyle(fontFamily: StringConstant.font)),
                        Text(StringConstant.boldSignUp,
                          style: TextStyle(fontWeight: FontWeight.bold,fontFamily: StringConstant.font))]))])))));
  }

  void tapsignuptextbutton(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }
}
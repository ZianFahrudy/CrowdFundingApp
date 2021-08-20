import 'package:crowd_funding/app/presentation/screen/navigation/mynavigation.dart';
import 'package:crowd_funding/app/presentation/widget/button_widget/button_widget.dart';
import 'package:crowd_funding/app/presentation/widget/textfield/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Spacer(),
              TextFieldWidget(
                  prefixIcon: Icon(CupertinoIcons.mail),
                  hintText: "Type your email address",
                  labelText: "Email Address"),
              TextFieldWidget(
                  prefixIcon: Icon(CupertinoIcons.lock),
                  suffixIcon: Icon(CupertinoIcons.eye),
                  hintText: "Type your password",
                  labelText: "Password"),
              ButtonWidget(
                  text: "SIGN IN NOW",
                  textColor: Colors.white,
                  width: double.infinity,
                  height: 45,
                  onPressed: () => Get.to(() => MyNavigation())),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

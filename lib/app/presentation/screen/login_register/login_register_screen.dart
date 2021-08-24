import 'package:crowd_funding/app/core/common/palette.dart';
import 'package:crowd_funding/app/presentation/screen/login_register/local_screen/login_screen.dart';
import 'package:crowd_funding/app/presentation/screen/login_register/local_screen/register_screen.dart';
import 'package:crowd_funding/app/presentation/widget/button_widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginRegisterScreen extends StatefulWidget {
  LoginRegisterScreen({Key? key}) : super(key: key);

  @override
  _LoginRegisterScreenState createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: Get.height * 0.54,
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ButtonWidget(
              color: Colors.transparent,
              borderColor: Theme.of(context).cardColor,
              textColor: Theme.of(context).cardColor,
              text: "SIGN IN",
              elevation: 0,
              width: double.infinity,
              height: 45,
              onPressed: () => Get.to(() => LoginScreen()),
            ),
            SizedBox(height: 10),
            ButtonWidget(
                textColor: Theme.of(context).cardColor,
                text: "REGISTER",
                width: double.infinity,
                height: 45,
                color: Palette.orangeColor,
                onPressed: () => Get.to(() => RegisterScreen())),
          ]),
        ),
      ],
    ));
  }
}

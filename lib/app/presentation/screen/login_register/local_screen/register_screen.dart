import 'package:crowd_funding/app/core/common/palette.dart';
import 'package:crowd_funding/app/core/component/blocs/login/login_bloc.dart';
import 'package:crowd_funding/app/core/component/blocs/user/register/register_bloc.dart';
import 'package:crowd_funding/app/core/di/injection.dart';
import 'package:crowd_funding/app/presentation/screen/navigation/mynavigation.dart';
import 'package:crowd_funding/app/presentation/widget/loader_widget/loader_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:crowd_funding/app/core/component/domain/models/request/register_body.dart';

import '../../../widget/button_widget/button_widget.dart';
import '../../../widget/textfield/textfield_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final registerBloc = getIt<RegisterBloc>();

    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final occupationController = TextEditingController();
    final passwordController = TextEditingController();

    onRegisterPressed() {
      registerBloc.add(OnRegisterEvent(RegisterBody(
          name: nameController.text,
          occupation: occupationController.text,
          email: emailController.text,
          password: passwordController.text)));
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (context) => registerBloc,
          child: BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state) {
            if (state is RegisterFailure) {
              print(state.error);
            } else if (state is RegisterSuccess) {
              Get.off(() => MyNavigation());
            }
          }, builder: (context, state) {
            return Stack(
              children: [
                SafeArea(
                  minimum: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Hey,",
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Palette.orangeColor)),
                        Text("Register Now",
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Palette.primaryColor)),
                        SizedBox(height: 30),
                        TextFieldWidget(
                            controller: nameController,
                            prefixIcon: Icon(CupertinoIcons.person),
                            hintText: "Type your name",
                            labelText: "Name"),
                        TextFieldWidget(
                            controller: emailController,
                            prefixIcon: Icon(CupertinoIcons.mail),
                            hintText: "Type your email address",
                            labelText: "Email Address"),
                        TextFieldWidget(
                            controller: occupationController,
                            prefixIcon: Icon(CupertinoIcons.cube_box),
                            hintText: "Type your occupation",
                            labelText: "Occupation"),
                        TextFieldWidget(
                            controller: passwordController,
                            prefixIcon: Icon(CupertinoIcons.lock),
                            suffixIcon: Icon(CupertinoIcons.eye),
                            hintText: "Type your password",
                            labelText: "Password"),
                        ButtonWidget(
                            text: "SIGN UP NOW",
                            color: Palette.primaryColor,
                            textColor: Colors.white,
                            width: double.infinity,
                            height: 45,
                            onPressed: onRegisterPressed),
                      ],
                    ),
                  ),
                ),
                state is LoginLoading
                    ? LoaderWidget(title: "Loading")
                    : SizedBox.shrink()
              ],
            );
          }),
        ),
      ),
    );
  }
}

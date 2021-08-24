import 'package:crowd_funding/app/core/common/palette.dart';
import 'package:crowd_funding/app/core/component/blocs/login/login_bloc.dart';
import 'package:crowd_funding/app/core/di/injection.dart';
import 'package:crowd_funding/app/presentation/screen/navigation/mynavigation.dart';
import 'package:crowd_funding/app/presentation/widget/loader_widget/loader_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:crowd_funding/app/core/component/domain/models/request/login_body.dart';

import '../../../widget/button_widget/button_widget.dart';
import '../../../widget/textfield/textfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final loginBloc = getIt<LoginBloc>();

    final passwordController = TextEditingController();
    final emailController = TextEditingController();

    onLoginPressed() {
      loginBloc.add(OnLoginEvent(LoginBody(
          email: emailController.text, password: passwordController.text)));
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (context) => loginBloc,
          child:
              BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
            if (state is LoginFailure) {
              print(state.error);
            } else if (state is LoginSuccess) {
              Get.off(() => MyNavigation());
            } else if (state is LoginLoading) {
              print("LOGIN LOADING");
            }
          }, builder: (context, state) {
            return Stack(
              children: [
                SafeArea(
                  minimum: const EdgeInsets.symmetric(horizontal: 20),
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
                      Text("Login Now",
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Palette.primaryColor)),
                      SizedBox(height: 30),
                      TextFieldWidget(
                          controller: emailController,
                          prefixIcon: Icon(CupertinoIcons.mail),
                          hintText: "Type your email address",
                          labelText: "Email Address"),
                      TextFieldWidget(
                          controller: passwordController,
                          prefixIcon: Icon(CupertinoIcons.lock),
                          suffixIcon: Icon(CupertinoIcons.eye),
                          hintText: "Type your password",
                          labelText: "Password"),
                      ButtonWidget(
                          text: "SIGN IN NOW",
                          color: Palette.primaryColor,
                          textColor: Colors.white,
                          width: double.infinity,
                          height: 45,
                          onPressed: onLoginPressed),
                    ],
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

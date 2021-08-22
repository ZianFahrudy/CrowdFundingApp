import 'package:crowd_funding/app/core/component/blocs/login/login_bloc.dart';
import 'package:crowd_funding/app/core/di/injection.dart';
import 'package:crowd_funding/app/presentation/screen/navigation/mynavigation.dart';
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

    onLoginPressed() {
      loginBloc.add(OnLoginEvent(
          LoginBody(email: "kambingimut@gmail.com", password: "password")));
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                          onPressed: onLoginPressed),
                    ],
                  ),
                ),
                state is LoginLoading
                    ? Center(child: CircularProgressIndicator())
                    : SizedBox.shrink()
              ],
            );
          }),
        ),
      ),
    );
  }
}

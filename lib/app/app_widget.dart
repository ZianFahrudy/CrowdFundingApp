import 'package:crowd_funding/app/core/common/theme.dart';
import 'package:crowd_funding/app/presentation/screen/login_register/login_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';


class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.basic,
      home: LoginRegisterScreen(),
    );
  }
}

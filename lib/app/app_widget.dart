import 'package:crowd_funding/app/core/common/theme.dart';
import 'package:crowd_funding/app/core/constants/keycontant.dart';
import 'package:crowd_funding/app/presentation/screen/login_register/login_register_screen.dart';
import 'package:crowd_funding/app/presentation/screen/navigation/mynavigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with TickerProviderStateMixin {
  final storage = GetStorage();
  @override
  Widget build(BuildContext context) {
    bool isLogin = storage.hasData(KeyConstant.token);
    return GetMaterialApp(
      theme: AppTheme.basic,
      home: isLogin ? MyNavigation() : LoginRegisterScreen(),
    );
  }
}

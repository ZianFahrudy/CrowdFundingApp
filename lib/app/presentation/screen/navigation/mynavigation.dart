import 'package:crowd_funding/app/presentation/screen/dashboard/dashboard_screen.dart';
import 'package:crowd_funding/app/presentation/screen/home/home_screen.dart';
import 'package:crowd_funding/app/presentation/screen/profile/profile_screen.dart';
import 'package:crowd_funding/app/presentation/widget/bottombar/bottombar.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class MyNavigation extends StatefulWidget {
  MyNavigation({Key? key, this.index = 0}) : super(key: key);
  int? index;

  @override
  _MyNavigationState createState() => _MyNavigationState();
}

class _MyNavigationState extends State<MyNavigation> {
  onTapItem(int index) {
    setState(() {
      widget.index = index;
    });
  }

  List<Widget> screen = [HomeScreen(), DashboardScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: widget.index!,
      child: Scaffold(
        body: IndexedStack(
          index: widget.index!,
          children: screen.map((e) => e).toList(),
        ),
        bottomNavigationBar: BottomNavbarWidget(
            onTapItem: onTapItem, selectedIndex: widget.index!),
      ),
    );
  }
}

import 'package:crowd_funding/app/core/common/palette.dart';
import 'package:crowd_funding/app/presentation/screen/project/project_screen.dart';
import 'package:crowd_funding/app/presentation/screen/transaction/transaction_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late TabController tabBarController;
  int selectedTabIndex = 0;
  tabListener() {
    setState(() {
      selectedTabIndex = tabBarController.index;
    });
  }

  @override
  void initState() {
    tabBarController = TabController(length: 2, vsync: this);
    tabBarController.addListener(tabListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (context, inner) {
          return [
            SliverAppBar(
              centerTitle: true,
              backgroundColor: Palette.primaryColor,
              floating: true,
              pinned: true,
              snap: true,
              elevation: 0.5,
              iconTheme: Theme.of(context).iconTheme.copyWith(
                    color: Colors.white,
                  ),
              title: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Text("Dashboard"),
                ],
              ),
              bottom: TabBar(
                controller: tabBarController,
                labelStyle: Theme.of(context).textTheme.button,
                labelColor: Colors.white,
                unselectedLabelColor: CupertinoColors.white.withOpacity(0.6),
                unselectedLabelStyle: Theme.of(context).textTheme.button,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 5.0,
                    color: Palette.orangeColor,
                    style: BorderStyle.solid,
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                tabs: [
                  Tab(
                    text: "Transactions",
                  ),
                  Tab(text: "Project"),
                ],
              ),
              automaticallyImplyLeading: false,
            )
          ];
        },
        body: TabBarView(
            controller: tabBarController,
            children: [TransactionScreen(), ProjectScreen()]),
      )),
    );
  }
}

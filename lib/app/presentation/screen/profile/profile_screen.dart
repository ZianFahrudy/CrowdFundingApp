import 'package:crowd_funding/app/core/common/palette.dart';
import 'package:crowd_funding/app/core/component/blocs/user/get_userdata_bloc.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/login_model.dart';
import 'package:crowd_funding/app/core/constants/constant.dart';
import 'package:crowd_funding/app/core/constants/keycontant.dart';
import 'package:crowd_funding/app/core/di/injection.dart';
import 'package:crowd_funding/app/presentation/screen/login_register/login_register_screen.dart';
import 'package:crowd_funding/app/presentation/widget/button_widget/button_widget.dart';
import 'package:crowd_funding/app/presentation/widget/loader_page/loading_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final getUserDataBloc = getIt<GetUserDataBloc>();
  final box = GetStorage();

  onLogout() {
    box.remove(KeyConstant.token);
    box.remove(KeyConstant.userId);

    Get.off(() => LoginRegisterScreen());
  }

  @override
  void initState() {
    getUserDataBloc.fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<LoginModel>(
            stream: getUserDataBloc.data,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!.data;
                return SafeArea(
                    child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 100,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      color: Palette.primaryColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            data!.imageUrl! != ''
                                ? "${Constants.baseUrl}/${data.imageUrl!}"
                                : "http://stiepetrabitung.ac.id/wp-content/uploads/2021/03/placeholder.png",
                            width: 80,
                            height: 80,
                          ),
                          SizedBox(width: 10),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data.name!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                Text(data.occupation!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.grey[200])),
                                Text(
                                  data.email!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.grey[200]),
                                ),
                              ]),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      margin: EdgeInsets.all(0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(Icons.person, size: 30),
                              SizedBox(width: 20),
                              Text("Personal data"),
                            ]),
                            Icon(CupertinoIcons.arrow_right)
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(Icons.settings, size: 30),
                              SizedBox(width: 20),
                              Text("Setting"),
                            ]),
                            Icon(CupertinoIcons.arrow_right)
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(Icons.star_outline, size: 30),
                              SizedBox(width: 20),
                              Text("E-statement"),
                            ]),
                            Icon(CupertinoIcons.arrow_right)
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(Icons.refresh_sharp, size: 30),
                              SizedBox(width: 20),
                              Text("Refereral code"),
                            ]),
                            Icon(CupertinoIcons.arrow_right)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      margin: EdgeInsets.all(0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(Icons.format_quote, size: 30),
                              SizedBox(width: 20),
                              Text("FAQs"),
                            ]),
                            Icon(CupertinoIcons.arrow_right)
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(Icons.book, size: 30),
                              SizedBox(width: 20),
                              Text("Our handbooks"),
                            ]),
                            Icon(CupertinoIcons.arrow_right)
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(Icons.commute_outlined, size: 30),
                              SizedBox(width: 20),
                              Text("Community"),
                            ]),
                            Icon(CupertinoIcons.arrow_right)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ButtonWidget(
                          text: "Logout",
                          width: double.infinity,
                          height: 45,
                          onPressed: onLogout),
                    ),
                  ],
                ));
              }

              return LoadingPage();
            }));
  }
}

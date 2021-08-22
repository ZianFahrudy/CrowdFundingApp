import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/common/palette.dart';
import '../../../core/component/blocs/campaign/campaign_detail_bloc.dart';
import '../../../core/component/domain/models/response/campaign_detail_model.dart';
import '../../../core/constants/constant.dart';
import '../../../core/di/injection.dart';
import '../../widget/button_widget/button_widget.dart';
import '../../widget/loader_page/loading_page.dart';

class DetailCampaignScreen extends StatefulWidget {
  DetailCampaignScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  _DetailCampaignScreenState createState() => _DetailCampaignScreenState();
}

class _DetailCampaignScreenState extends State<DetailCampaignScreen> {
  final campaignDetailBloc = getIt<CampaignDetailBloc>();

  @override
  void initState() {
    campaignDetailBloc.fetchCampaignDetail(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<CampaignDetailModel>(
          stream: campaignDetailBloc.data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              // int goal = (data.data!.goalAmount! / 100000).round();
              // int curent = (data.data!.currentAmount! / 100000).round();

              // var percentage = ((curent / goal) * 100).roundToDouble();

              return Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                            height: Get.height * 0.38,
                            scrollDirection: Axis.horizontal,
                            autoPlay: true,
                            viewportFraction: 1),
                        items: data.data!.images!.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "${Constants.baseUrl}/${i.imageUrl!}"),
                                        fit: BoxFit.cover)),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(data.data!.name!,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(data.data!.shortDescription!,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Palette.greyColor)),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(children: [
                                Text(
                                  data.data!.backerCount!.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: Palette.primaryColor,
                                          fontWeight: FontWeight.bold),
                                ),
                                Text("Backer"),
                              ]),
                              Container(
                                  height: 40,
                                  width: 2,
                                  color: Palette.greyColor),
                              Column(children: [
                                Text(
                                  data.data!.user!.name!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: Palette.primaryColor,
                                          fontWeight: FontWeight.bold),
                                ),
                                Text("Project Leader"),
                              ]),
                              Container(
                                  height: 40,
                                  width: 2,
                                  color: Palette.greyColor),
                              Column(children: [
                                Text(
                                  data.data!.goalAmount.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: Palette.primaryColor,
                                          fontWeight: FontWeight.bold),
                                ),
                                Text("Target"),
                              ])
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(thickness: 2),
                      ),
                      // SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(data.data!.description!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Palette.greyColor)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(thickness: 2),
                      ),
                      SizedBox(height: 10),

                      // Center(
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Container(
                      //         height: 60,
                      //         width: 60,
                      //         child: Stack(
                      //           children: [
                      //             CircularStepProgressIndicator(
                      //               totalSteps:
                      //                   data.data!.goalAmount! == 0 ? 1 : goal,
                      //               currentStep: data.data!.currentAmount! == 0
                      //                   ? 0
                      //                   : curent,
                      //               stepSize: 8,
                      //               selectedColor:
                      //                   Palette.primaryColor.withOpacity(0.6),
                      //               unselectedColor: Colors.grey[200],
                      //               padding: 0,
                      //               width: 60,
                      //               height: 60,
                      //               selectedStepSize: 8,
                      //               roundedCap: (_, __) => true,
                      //             ),
                      //             Center(
                      //               child: Text("$percentage%"),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //       SizedBox(width: 20),
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text("Terkumpul",
                      //               style: Theme.of(context)
                      //                   .textTheme
                      //                   .bodyText2!
                      //                   .copyWith(fontWeight: FontWeight.bold)),
                      //           Text("Rp. ${data.data!.currentAmount!}"),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: ButtonWidget(
                          color: Palette.orangeColor,
                          text: "Donate",
                          width: double.infinity,
                          height: 50,
                          onPressed: () {
                            Get.bottomSheet(SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(
                                  right: 20,
                                  left: 20,
                                  top: 20,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Project Leader:",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Row(children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          "${Constants.baseUrl}/${data.data!.user!.imageUrl!}",
                                          width: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(data.data!.user!.name!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        color: Palette
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                            Text(data.data!.backerCount
                                                    .toString() +
                                                " backer")
                                          ]),
                                    ]),
                                    SizedBox(height: 10),
                                    Text(
                                      "What will you get:",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    ...data.data!.perks!
                                        .map((e) => Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(Icons.done,
                                                        color:
                                                            Palette.greenColor),
                                                    SizedBox(width: 10),
                                                    Expanded(child: Text(e)),
                                                  ],
                                                ),
                                              ],
                                            ))
                                        .toList(),
                                    SizedBox(height: 10),
                                    TextField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText: "0",
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color:
                                                        Palette.primaryColor)),
                                            fillColor: Colors.transparent)),
                                    SizedBox(height: 10),
                                    ButtonWidget(
                                        text: "Fund Now",
                                        width: double.infinity,
                                        height: 45,
                                        onPressed: () {}),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ));
                          }),
                    ),
                  )
                ],
              );
            }

            return LoadingPage();
          }),
    );
  }
}

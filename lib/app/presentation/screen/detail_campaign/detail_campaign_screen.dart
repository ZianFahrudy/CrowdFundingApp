import 'package:carousel_slider/carousel_slider.dart';
import 'package:crowd_funding/app/core/common/palette.dart';
import 'package:crowd_funding/app/core/component/blocs/campaign/campaign_detail_bloc.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/campaign_detail_model.dart';
import 'package:crowd_funding/app/core/constants/constant.dart';
import 'package:crowd_funding/app/core/di/injection.dart';
import 'package:crowd_funding/app/presentation/widget/button_widget/button_widget.dart';
import 'package:crowd_funding/app/presentation/widget/loader_page/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

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
              int goal = (data.data!.goalAmount! / 100000).round();
              int curent = (data.data!.currentAmount! / 100000).round();

              var percentage = ((curent / goal) * 100).roundToDouble();

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
                        child: Text(data.data!.name!,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontWeight: FontWeight.bold)),
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

                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              child: Stack(
                                children: [
                                  CircularStepProgressIndicator(
                                    totalSteps:
                                        data.data!.goalAmount! == 0 ? 1 : goal,
                                    currentStep: data.data!.currentAmount! == 0
                                        ? 0
                                        : curent,
                                    stepSize: 8,
                                    selectedColor:
                                        Palette.primaryColor.withOpacity(0.6),
                                    unselectedColor: Colors.grey[200],
                                    padding: 0,
                                    width: 60,
                                    height: 60,
                                    selectedStepSize: 8,
                                    roundedCap: (_, __) => true,
                                  ),
                                  Center(
                                    child: Text("$percentage%"),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Terkumpul",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(fontWeight: FontWeight.bold)),
                                Text("Rp. ${data.data!.currentAmount!}"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: ButtonWidget(
                          color: Palette.orangeColor,
                          text: "Fund Now",
                          width: double.infinity,
                          height: 50,
                          onPressed: () {}),
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

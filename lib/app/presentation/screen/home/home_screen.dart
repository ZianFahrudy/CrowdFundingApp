import 'package:crowd_funding/app/core/common/palette.dart';
import 'package:crowd_funding/app/core/component/blocs/campaign/campaign_list_bloc.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/campaign_list_model.dart';
import 'package:crowd_funding/app/core/constants/constant.dart';
import 'package:crowd_funding/app/core/di/injection.dart';
import 'package:crowd_funding/app/presentation/screen/detail_campaign/detail_campaign_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final campaignListBloc = getIt<CampaignListBloc>();
  final PagingController<int, DataCampaignModel> pagingController =
      PagingController(firstPageKey: 0);

  Future<void> _fetchPage(int pageKey) async {
    try {
      campaignListBloc.fetchCampaignList();
      int i = 0;

      campaignListBloc.data.listen((event) {
        if (event != null && i == 0) {
          i++;

          final newItems = List.generate(
              event.data!.length,
              (index) => DataCampaignModel(
                  id: event.data![index].id,
                  name: event.data![index].name,
                  currentAmount: event.data![index].currentAmount,
                  goalAmount: event.data![index].goalAmount,
                  shortDescription: event.data![index].shortDescription,
                  slug: event.data![index].slug,
                  userId: event.data![index].userId,
                  imageUrl: event.data![index].imageUrl));
          pagingController.appendLastPage(newItems);
        }
      });
    } catch (error) {
      pagingController.error = error;
    }
  }

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() => pagingController.refresh()),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Get.height * 0.4,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    ProfileCard(),
                    SizedBox(height: 20),
                    SerarchBarCustom(),
                    CategoryCampaign()
                  ],
                ),
              ),
              TitileText(),
              Container(
                height: Get.height * 0.42,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: PagedListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    pagingController: pagingController,
                    builderDelegate:
                        PagedChildBuilderDelegate<DataCampaignModel>(
                            itemBuilder: (context, item, i) {
                      return GestureDetector(
                        onTap: () =>
                            Get.to(() => DetailCampaignScreen(id: item.id!)),
                        child: Padding(
                          padding: EdgeInsets.only(left: i == 0 ? 20 : 15),
                          child: CampaignItem(
                            imageUrl: item.imageUrl,
                            name: item.name,
                            goalAmount:
                                item.goalAmount! < 100000 ? 0 : item.goalAmount,
                            curentAmount: ((item.currentAmount! > 0) &&
                                    (item.goalAmount == 0))
                                ? 0
                                : item.currentAmount,
                          ),
                        ),
                      );
                    })),
              )
            ],
          ),
        )),
      ),
    );
  }
}

class TitileText extends StatelessWidget {
  const TitileText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Penggalangan mendesak",
            style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Palette.greyColor,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "Lihat semua",
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Palette.primaryColor),
          )
        ],
      ),
    );
  }
}

class CampaignItem extends StatelessWidget {
  const CampaignItem({
    Key? key,
    this.imageUrl,
    this.name,
    this.goalAmount = 0,
    this.curentAmount = 0,
  }) : super(key: key);

  final String? imageUrl;
  final String? name;
  final int? goalAmount;
  final int? curentAmount;

  @override
  Widget build(BuildContext context) {
    int goal = (goalAmount! / 100000).round();
    int curent = (curentAmount! / 100000).round();

    var percentage = ((curent / goal) * 100).roundToDouble();

    return Container(
      width: Get.width * 0.6,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: Image.network(
                imageUrl != ""
                    ? "${Constants.baseUrl}/$imageUrl"
                    : "http://stiepetrabitung.ac.id/wp-content/uploads/2021/03/placeholder.png",
                width: double.infinity,
                height: Get.height * 0.23,
                fit: BoxFit.cover),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              name ?? 'No name',
              maxLines: 2,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  child: Stack(
                    children: [
                      CircularStepProgressIndicator(
                        totalSteps: goalAmount == 0 ? 1 : goal,
                        currentStep: curentAmount == 0 ? 0 : curent,
                        stepSize: 8,
                        selectedColor: Palette.primaryColor.withOpacity(0.6),
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
                    Text("Target",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontWeight: FontWeight.bold)),
                    Text("Rp. $goalAmount"),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text("Terkumpul: Rp. $curentAmount"),
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/men/41.jpg"),
              ),
              SizedBox(width: 20),
              Text(
                "Zian Fahrudy",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
        Icon(
          CupertinoIcons.heart_fill,
          color: Colors.white,
        )
      ],
    );
  }
}

class SerarchBarCustom extends StatelessWidget {
  const SerarchBarCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.4),
          hintText: "Cari yang ingin kamu bantu",
          hintStyle: TextStyle(color: Colors.white),
          suffixIcon: Icon(
            CupertinoIcons.search,
            color: Colors.white,
          )),
    );
  }
}

class CategoryCampaign extends StatelessWidget {
  const CategoryCampaign({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CategoryItem(
            icon: Icons.computer,
            title: "IT",
          ),
          CategoryItem(
            icon: Icons.card_giftcard,
            title: "Social",
          ),
          CategoryItem(
            icon: Icons.bike_scooter,
            title: "Store",
          ),
          CategoryItem(
            icon: Icons.animation,
            title: "Lainnya",
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key, required this.icon, required this.title})
      : super(key: key);
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
        ],
      ),
    );
  }
}

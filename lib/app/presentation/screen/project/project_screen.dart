import 'package:crowd_funding/app/core/common/palette.dart';
import 'package:crowd_funding/app/core/component/blocs/campaign/campaign_list_bloc.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/campaign_list_model.dart';
import 'package:crowd_funding/app/core/constants/constant.dart';
import 'package:crowd_funding/app/core/di/injection.dart';
import 'package:crowd_funding/app/presentation/screen/create_campaign/create_campaign_screen.dart';
import 'package:crowd_funding/app/presentation/screen/edit_campaign/edit_campaign_screen.dart';
import 'package:crowd_funding/app/presentation/widget/loader_page/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({Key? key}) : super(key: key);

  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  final campaignBloc = getIt<CampaignListByIdBloc>();
  final PagingController<int, DataCampaignModel> _pagingController =
      PagingController(firstPageKey: 0);

  Future<void> _fetchPage(int pageKey) async {
    try {
      campaignBloc.fetchCampaignList();
      int i = 0;

      campaignBloc.data.listen((event) {
        if (event != null && i == 0) {
          i++;

          final newItems = List.generate(
              event.data!.length,
              (index) => DataCampaignModel(
                  id: event.data![index].id,
                  currentAmount: event.data![index].currentAmount,
                  goalAmount: event.data![index].goalAmount,
                  imageUrl: event.data![index].imageUrl,
                  name: event.data![index].name,
                  shortDescription: event.data![index].shortDescription,
                  slug: event.data![index].slug,
                  userId: event.data![index].userId));

          _pagingController.appendLastPage(newItems);
        }
      });
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  onSelectedPopUpButton(int value, DataCampaignModel item) {
    if (value == 0) {
      Get.to(() => EditCampaignScreen(
            id: item.id!,
            projectPagingController: _pagingController,
          ));
    } else {
      print("Delete");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.to(() => CreateCampaignScreen(
                projectPagingController: _pagingController,
              )),
          child: Icon(Icons.add),
        ),
        body: PagedListView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<DataCampaignModel>(
                firstPageProgressIndicatorBuilder: (context) => LoadingPage(),
                noItemsFoundIndicatorBuilder: (context) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Projects still empty!")]);
                },
                itemBuilder: (context, item, i) {
                  return GestureDetector(
                    onTap: () {},
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                item.imageUrl != ''
                                    ? "${Constants.baseUrl}/${item.imageUrl}"
                                    : "http://stiepetrabitung.ac.id/wp-content/uploads/2021/03/placeholder.png",
                                width: 60,
                                fit: BoxFit.cover,
                                height: 60,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    item.shortDescription!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Palette.greyColor),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuButton(
                                onSelected: (int value) =>
                                    onSelectedPopUpButton(value, item),
                                itemBuilder: (context) => [
                                      PopupMenuItem(
                                          value: 0, child: Text("Edit")),
                                      PopupMenuItem(
                                          value: 1, child: Text("Delete")),
                                    ]),
                          ],
                        ),
                      ),
                    ),
                  );
                })));
  }
}

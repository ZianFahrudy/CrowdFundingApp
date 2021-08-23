import 'package:crowd_funding/app/core/common/palette.dart';
import 'package:crowd_funding/app/core/component/blocs/transaction/transaction_list_bloc.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/transaction_list_model.dart';
import 'package:crowd_funding/app/core/constants/constant.dart';
import 'package:crowd_funding/app/core/di/injection.dart';
import 'package:crowd_funding/app/presentation/widget/loader_page/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final transactionBloc = getIt<TransactionListBloc>();
  final PagingController<int, DataTransaction> _pagingController =
      PagingController(firstPageKey: 0);

  Future<void> _fetchPage(int pageKey) async {
    try {
      transactionBloc.fetchCampaignList();
      int i = 0;

      transactionBloc.data.listen((event) {
        if (event != null && i == 0) {
          i++;

          final newItems = List.generate(
              event.data!.length,
              (index) => DataTransaction(
                  id: event.data![index].id,
                  amount: event.data![index].amount,
                  campaign: event.data![index].campaign,
                  createdAt: event.data![index].createdAt,
                  status: event.data![index].status));

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PagedListView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<DataTransaction>(
                firstPageProgressIndicatorBuilder: (context) => LoadingPage(),
                noItemsFoundIndicatorBuilder: (context) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Transactions still empty!")]);
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
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    item.campaign!.imageUrl != ''
                                        ? "${Constants.baseUrl}/${item.campaign!.imageUrl}"
                                        : "http://stiepetrabitung.ac.id/wp-content/uploads/2021/03/placeholder.png",
                                    width: 60,
                                    fit: BoxFit.cover,
                                    height: 60,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.campaign!.name!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Rp. ${item.amount}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: Palette.orangeColor),
                                    ),
                                    Text(
                                      "${DateTime.parse(item.createdAt!).day} - ${DateTime.parse(item.createdAt!).month} - ${DateTime.parse(item.createdAt!).year}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: Palette.greyColor),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Text(
                              item.status! == 'pending' ? "Pending" : "Paid",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: item.status! == 'pending'
                                          ? Palette.redColor
                                          : Palette.greenColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })));
  }
}

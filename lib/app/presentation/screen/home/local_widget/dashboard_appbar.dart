import 'package:crowd_funding/app/core/common/palette.dart';
import 'package:crowd_funding/app/core/component/blocs/user/get_userdata_bloc.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/login_model.dart';
import 'package:crowd_funding/app/core/constants/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final GetUserDataBloc getUserBloc;

  DashboardAppBar({
    required this.getUserBloc,
    required this.expandedHeight,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return StreamBuilder<LoginModel>(
        stream: getUserBloc.data,
        builder: (context, snapshot) {
          String name = '';
          String occupation = '';
          String imageUrl = '';

          if (snapshot.hasData) {
            name = snapshot.data!.data!.name!;
            occupation = snapshot.data!.data!.occupation!;
            imageUrl = snapshot.data!.data!.imageUrl!;
          }

          return Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              AppBar(
                title: Text("Welcome"),
                backgroundColor: Palette.primaryColor,
                leading: Icon(Icons.directions_railway_filled_rounded),
                actions: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Opacity(
                          opacity: shrinkOffset / expandedHeight,
                          child: CircleAvatar(
                              backgroundImage: NetworkImage(imageUrl != ''
                                  ? "${Constants.baseUrl}/$imageUrl"
                                  : "http://stiepetrabitung.ac.id/wp-content/uploads/2021/03/placeholder.png")))),
                ],
              ),
              Positioned(
                  bottom: -30,
                  left: 0,
                  right: 0,
                  child: Opacity(
                      opacity: (1 - shrinkOffset / expandedHeight),
                      child: buildContentTile(
                          context, name, occupation, imageUrl)))
            ],
          );
        });
  }

  Container buildContentTile(
      BuildContext context, String name, String occupation, String imageUrl) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: Theme.of(context).dividerColor, width: 0.3)),
        child: ListTile(
            leading: InkWell(
              onTap: () {},
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  imageUrl == ''
                      ? "http://stiepetrabitung.ac.id/wp-content/uploads/2021/03/placeholder.png"
                      : "${Constants.baseUrl}/$imageUrl",
                ),
              ),
            ),
            title: Text(name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1),
            subtitle: Text(occupation,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption)));
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + AppBar().preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

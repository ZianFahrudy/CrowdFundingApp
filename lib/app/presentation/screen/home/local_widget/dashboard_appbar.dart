import 'package:crowd_funding/app/core/common/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  DashboardAppBar({
    required this.expandedHeight,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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
                        child: Icon(Icons.person),
                        onBackgroundImageError: (exception, stackTrace) {},
                        backgroundImage: NetworkImage(
                            "http://stiepetrabitung.ac.id/wp-content/uploads/2021/03/placeholder.png")))),
          ],
        ),
        Positioned(
            bottom: -30,
            left: 0,
            right: 0,
            child: Opacity(
                opacity: (1 - shrinkOffset / expandedHeight),
                child: buildContentTile(context)))
      ],
    );
  }

  Container buildContentTile(BuildContext context) {
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
                child: Icon(Icons.person),
              ),
            ),
            title: Text("Zian Fahrudy",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1),
            subtitle: Text("3237627236",
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

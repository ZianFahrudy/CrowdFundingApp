import 'package:crowd_funding/app/presentation/widget/loader_page/loading_colorize.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ColorLoaderPage(
        dotOneColor: Colors.redAccent,
        dotTwoColor: Colors.blueAccent,
        dotThreeColor: Colors.green,
        dotType: DotType.circle,
        dotIcon: Icon(Icons.adjust),
        duration: Duration(milliseconds: 1000),
      ),
    );
  }
}
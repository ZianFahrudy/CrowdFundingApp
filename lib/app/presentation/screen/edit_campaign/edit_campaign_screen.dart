import 'package:flutter/material.dart';

class EditCampaignScreen extends StatelessWidget {
  const EditCampaignScreen({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Campaign id => $id"),
      ),
    );
  }
}

import 'package:crowd_funding/app/core/common/palette.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/checkout_model.dart';
import 'package:crowd_funding/app/core/utility/url_launcher.dart';
import 'package:crowd_funding/app/presentation/screen/navigation/mynavigation.dart';
import 'package:crowd_funding/app/presentation/widget/button_widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key, required this.transaction}) : super(key: key);

  final CheckoutModel transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(
              child: Image.asset(
                "assets/image/project.png",
                width: Get.width * 0.8,
              ),
            ),
            Spacer(),
            Text(
              "Yeay! You are super",
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 10),
            Text(
              "Your money has ben transferred into company's account",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Palette.greyColor),
            ),
            Spacer(),
            ButtonWidget(
                color: Palette.greyColor,
                textColor: Colors.white,
                text: "Payment Method",
                width: 150,
                height: 45,
                onPressed: () =>
                    Launch.openUrl(url: transaction.data!.paymentUrl!)),
            SizedBox(height: 10),
            ButtonWidget(
                text: "My Dashboard",
                width: 150,
                height: 45,
                onPressed: () => Get.to(() => MyNavigation(
                      index: 1,
                    ))),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

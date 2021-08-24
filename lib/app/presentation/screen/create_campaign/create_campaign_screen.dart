import 'package:crowd_funding/app/core/common/palette.dart';
import 'package:crowd_funding/app/core/component/blocs/campaign/create_campaign/create_campaign_bloc.dart';
import 'package:crowd_funding/app/core/component/blocs/campaign/upload_image/upload_image_campaign_bloc.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/campaign_list_model.dart';
import 'package:crowd_funding/app/core/di/injection.dart';
import 'package:crowd_funding/app/presentation/widget/button_widget/button_widget.dart';
import 'package:crowd_funding/app/presentation/widget/loader_widget/loader_widget.dart';
import 'package:crowd_funding/app/presentation/widget/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:crowd_funding/app/core/component/domain/models/request/create_campaign_body.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CreateCampaignScreen extends StatefulWidget {
  const CreateCampaignScreen({Key? key, required this.projectPagingController})
      : super(key: key);
  final PagingController<int, DataCampaignModel> projectPagingController;
  @override
  _CreateCampaignScreenState createState() => _CreateCampaignScreenState();
}

class _CreateCampaignScreenState extends State<CreateCampaignScreen> {
  final campaignBloc = getIt<CreateCampaignBloc>();
  final uploadImageBloc = getIt<UploadImageCampaignBloc>();

  final nameController = TextEditingController();
  final shortDescController = TextEditingController();
  final perkController = TextEditingController();
  final descController = TextEditingController();
  final amountController = TextEditingController();

  onCreateCampaign() {
    campaignBloc.add(OnCreateCampaignEvent(CreateCampaignBody(
        name: nameController.text,
        description: descController.text,
        goalAmount: int.parse(amountController.text),
        perks: perkController.text,
        shortDescription: shortDescController.text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create Campaign"),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => campaignBloc),
          BlocProvider(create: (context) => uploadImageBloc),
        ],
        child: BlocConsumer<CreateCampaignBloc, CreateCampaignState>(
            listener: (context, state) {
          if (state is CreateCampaignFailure) {
            Get.snackbar("Oopss", state.error,
                snackPosition: SnackPosition.TOP,
                backgroundColor: Palette.redColor,
                colorText: Colors.white);
          } else if (state is CreateCampaignSuccess) {
            Get.snackbar("Success", "Create Campaign Berhasil",
                snackPosition: SnackPosition.TOP,
                backgroundColor: Palette.greenColor,
                colorText: Colors.white);
            Future.delayed(Duration(seconds: 3)).then((value) {
              widget.projectPagingController.refresh();
              Get.back();
            });
          }
        }, builder: (context, state) {
          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    TextFieldWidget(
                      controller: nameController,
                      hintText: "",
                      labelText: "Campaign Name",
                    ),
                    TextFieldWidget(
                        controller: shortDescController,
                        maxLines: 1,
                        isFilled: false,
                        hintText: "",
                        labelText: "Short description"),
                    TextFieldWidget(
                        controller: perkController,
                        maxLines: 2,
                        isFilled: false,
                        hintText: "",
                        labelText: "What will backers get"),
                    TextFieldWidget(
                        controller: descController,
                        maxLines: 3,
                        isFilled: false,
                        hintText: "",
                        labelText: "Description"),
                    TextFieldWidget(
                      controller: amountController,
                      textInputType: TextInputType.number,
                      hintText: "",
                      labelText: "Goal Amount",
                    ),
                    ButtonWidget(
                        text: "Create",
                        width: double.infinity,
                        height: 45,
                        onPressed: onCreateCampaign)
                  ],
                ),
              ),
              state is CreateCampaignLoading
                  ? LoaderWidget(title: "Loading")
                  : SizedBox.shrink()
            ],
          );
        }),
      ),
    );
  }
}

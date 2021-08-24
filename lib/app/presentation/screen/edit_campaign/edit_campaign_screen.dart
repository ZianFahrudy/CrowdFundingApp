import 'dart:io';

import 'package:crowd_funding/app/core/common/palette.dart';
import 'package:crowd_funding/app/core/component/blocs/campaign/campaign_detail_bloc.dart';
import 'package:crowd_funding/app/core/component/blocs/campaign/update_campaign/update_campaign_bloc.dart';
import 'package:crowd_funding/app/core/component/blocs/campaign/upload_image/upload_image_campaign_bloc.dart';
import 'package:crowd_funding/app/core/component/domain/models/request/upload_campaign_image_body.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/campaign_detail_model.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/campaign_list_model.dart';
import 'package:crowd_funding/app/core/di/injection.dart';
import 'package:crowd_funding/app/presentation/widget/button_widget/button_widget.dart';
import 'package:crowd_funding/app/presentation/widget/loader_page/loading_page.dart';
import 'package:crowd_funding/app/presentation/widget/loader_widget/loader_widget.dart';
import 'package:crowd_funding/app/presentation/widget/textfield/textfield_widget.dart';
import 'package:file_support/file_support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:crowd_funding/app/core/component/domain/models/request/create_campaign_body.dart';

class EditCampaignScreen extends StatefulWidget {
  const EditCampaignScreen(
      {Key? key, required this.id, required this.projectPagingController})
      : super(key: key);
  final int id;
  final PagingController<int, DataCampaignModel> projectPagingController;

  @override
  _EditCampaignScreenState createState() => _EditCampaignScreenState();
}

class _EditCampaignScreenState extends State<EditCampaignScreen> {
  final detailCampignBloc = getIt<CampaignDetailBloc>();
  final uploadImageBloc = getIt<UploadImageCampaignBloc>();

  final updateCampaignBloc = getIt<UpdateCampaignBloc>();

  late TextEditingController nameController;
  late TextEditingController shortDescController;
  late TextEditingController perkController;
  late TextEditingController descController;
  late TextEditingController amountController;

  onUpdateCampaign() {
    final body = CreateCampaignBody(
        name: nameController.text,
        description: descController.text,
        goalAmount: int.parse(amountController.text),
        perks: perkController.text,
        shortDescription: shortDescController.text);
    updateCampaignBloc.add(OnUpdateCampaignEvent(body: body, id: widget.id));
  }

  File? _image;

  /// get image from camera and gallery
  void _getImage(bool isCamera) async {
    final pickedImage = await ImagePicker().pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 30);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        print(_image);
        Get.back();
      }
    });
  }

  showImageDialog() {
    Get.bottomSheet(
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => _getImage(true),
                child: Text("Camera",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Palette.greenColor,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => _getImage(false),
                child: Text("Gallery",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Palette.greenColor,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white);
  }

  @override
  void initState() {
    detailCampignBloc.fetchCampaignDetail(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Campaign"),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => updateCampaignBloc),
          BlocProvider(create: (context) => uploadImageBloc),
        ],
        child: BlocConsumer<UpdateCampaignBloc, UpdateCampaignState>(
            listener: (context, state) {
          if (state is UpdateCampaignFailure) {
            Get.snackbar("Oopss", state.error,
                snackPosition: SnackPosition.TOP,
                backgroundColor: Palette.redColor,
                colorText: Colors.white);
          } else if (state is UpdateCampaignSuccess) {
            Get.snackbar("Success", "Your Campaign Updated!",
                snackPosition: SnackPosition.TOP,
                backgroundColor: Palette.greenColor,
                colorText: Colors.white);

            if (_image != null) {
              uploadImageBloc.add(OnUploadImageCampaign(UploadCampaignImageBody(
                  campaignId: widget.id, file: _image!.path, isPrimary: true)));
            }

            Future.delayed(Duration(seconds: 3)).then((value) {
              widget.projectPagingController.refresh();
              Get.back();
            });
          }
        }, builder: (context, state) {
          return Stack(
            children: [
              StreamBuilder<CampaignDetailModel>(
                  stream: detailCampignBloc.data,
                  builder: (context, snapshot) {
                    String name = '';
                    if (snapshot.hasData) {
                      name = snapshot.data!.data!.name!;
                      var perkList = snapshot.data!.data!.perks!;

                      final perks = perkList.join(',');

                      nameController = TextEditingController(text: name);
                      amountController = TextEditingController(
                          text: snapshot.data!.data!.goalAmount.toString());
                      shortDescController = TextEditingController(
                          text: snapshot.data!.data!.shortDescription!);
                      perkController = TextEditingController(text: perks);
                      descController = TextEditingController(
                          text: snapshot.data!.data!.description);
                      return SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            TextFieldWidget(
                              controller: nameController,
                              hintText: nameController.text,
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
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Choose Image",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: showImageDialog,
                                            icon: Icon(Icons.upload_file)),
                                        Expanded(
                                          child: Text(_image != null
                                              ? FileSupport()
                                                  .getFileNameWithoutExtension(
                                                      _image!)!
                                              : ''),
                                        ),
                                        SizedBox(width: 20),
                                      ],
                                    ),
                                  ],
                                )),
                                ButtonWidget(
                                    text: "Save",
                                    width: 120,
                                    height: 45,
                                    onPressed: onUpdateCampaign),
                              ],
                            )
                          ],
                        ),
                      );
                    }
                    return LoadingPage();
                  }),
              state is UpdateCampaignLoading
                  ? LoaderWidget(title: "Loading")
                  : SizedBox.shrink()
            ],
          );
        }),
      ),
    );
  }
}

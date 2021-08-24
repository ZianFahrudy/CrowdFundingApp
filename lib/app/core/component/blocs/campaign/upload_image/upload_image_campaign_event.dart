part of 'upload_image_campaign_bloc.dart';

@immutable
abstract class UploadImageCampaignEvent {}

class OnUploadImageCampaign extends UploadImageCampaignEvent {
  final UploadCampaignImageBody body;

  OnUploadImageCampaign(this.body);
}

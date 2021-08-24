part of 'upload_image_campaign_bloc.dart';

@immutable
abstract class UploadImageCampaignState {}

class UploadImageCampaignInitial extends UploadImageCampaignState {}

class UploadImageCampaignLoading extends UploadImageCampaignState {}

class UploadImageCampaignFailure extends UploadImageCampaignState {
  final String error;

  UploadImageCampaignFailure(this.error);
}

class UploadImageCampaignSuccess extends UploadImageCampaignState {}

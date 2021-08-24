part of 'update_campaign_bloc.dart';

@immutable
abstract class UpdateCampaignState {}

class UpdateCampaignInitial extends UpdateCampaignState {}

class UpdateCampaignLoading extends UpdateCampaignState {}

class UpdateCampaignFailure extends UpdateCampaignState {
  final String error;
  UpdateCampaignFailure(this.error);
}

class UpdateCampaignSuccess extends UpdateCampaignState {}

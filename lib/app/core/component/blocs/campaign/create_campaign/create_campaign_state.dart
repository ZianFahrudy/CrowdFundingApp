part of 'create_campaign_bloc.dart';

@immutable
abstract class CreateCampaignState {}

class CreateCampaignInitial extends CreateCampaignState {}

class CreateCampaignLoading extends CreateCampaignState {}

class CreateCampaignFailure extends CreateCampaignState {
  final String error;
  CreateCampaignFailure(this.error);
}

class CreateCampaignSuccess extends CreateCampaignState {}

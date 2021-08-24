part of 'create_campaign_bloc.dart';

@immutable
abstract class CreateCampaignEvent {}

class OnCreateCampaignEvent extends CreateCampaignEvent {
  final CreateCampaignBody body;
  OnCreateCampaignEvent(this.body);
}

part of 'update_campaign_bloc.dart';

@immutable
abstract class UpdateCampaignEvent {}

class OnUpdateCampaignEvent extends UpdateCampaignEvent {
  final CreateCampaignBody body;
  final int id;
  OnUpdateCampaignEvent({required this.body, required this.id});
}

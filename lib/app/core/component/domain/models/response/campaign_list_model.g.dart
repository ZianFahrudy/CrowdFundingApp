// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignListModel _$CampaignListModelFromJson(Map<String, dynamic> json) {
  return CampaignListModel(
    meta: json['meta'] == null
        ? null
        : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => DataCampaignModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

DataCampaignModel _$DataCampaignModelFromJson(Map<String, dynamic> json) {
  return DataCampaignModel(
    id: json['id'] as int?,
    userId: json['user_id'] as int?,
    name: json['name'] as String?,
    shortDescription: json['short_description'] as String?,
    imageUrl: json['image_url'] as String?,
    goalAmount: json['goal_amount'] as int?,
    currentAmount: json['current_amount'] as int?,
    slug: json['slug'] as String?,
  );
}

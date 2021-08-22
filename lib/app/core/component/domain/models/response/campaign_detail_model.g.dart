// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignDetailModel _$CampaignDetailModelFromJson(Map<String, dynamic> json) {
  return CampaignDetailModel(
    meta: json['meta'] == null
        ? null
        : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    data: json['data'] == null
        ? null
        : DataCampaignDetailModel.fromJson(
            json['data'] as Map<String, dynamic>),
  );
}

DataCampaignDetailModel _$DataCampaignDetailModelFromJson(
    Map<String, dynamic> json) {
  return DataCampaignDetailModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    shortDescription: json['short_description'] as String?,
    description: json['description'] as String?,
    imageUrl: json['image_url'] as String?,
    goalAmount: json['goal_amount'] as int?,
    currentAmount: json['current_amount'] as int?,
    backerCount: json['backer_count'] as int?,
    userId: json['user_id'] as int?,
    slug: json['slug'] as String?,
    perks: (json['perks'] as List<dynamic>?)?.map((e) => e as String).toList(),
    user: json['user'] == null
        ? null
        : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    images: (json['images'] as List<dynamic>?)
        ?.map((e) => ImagesModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    name: json['name'] as String?,
    imageUrl: json['image_url'] as String?,
  );
}

ImagesModel _$ImagesModelFromJson(Map<String, dynamic> json) {
  return ImagesModel(
    imageUrl: json['image_url'] as String?,
    isPrimary: json['is_primary'] as bool?,
  );
}

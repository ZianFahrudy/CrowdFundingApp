import 'package:crowd_funding/app/core/component/domain/models/response/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'campaign_detail_model.g.dart';

@JsonSerializable(
    createToJson: false, explicitToJson: false, fieldRename: FieldRename.snake)
class CampaignDetailModel {
  final Meta? meta;
  final DataCampaignDetailModel? data;

  CampaignDetailModel({this.meta, this.data});

  factory CampaignDetailModel.fromJson(Map<String, dynamic> json) =>
      _$CampaignDetailModelFromJson(json);
}

@JsonSerializable(
    createToJson: false, explicitToJson: false, fieldRename: FieldRename.snake)
class DataCampaignDetailModel {
  final int? id;
  final String? name;
  final String? shortDescription;
  final String? description;
  final String? imageUrl;
  final int? goalAmount;
  final int? currentAmount;
  final int? backerCount;
  final int? userId;
  final String? slug;
  final List<String>? perks;
  final UserModel? user;
  final List<ImagesModel>? images;

  DataCampaignDetailModel(
      {this.id,
      this.name,
      this.shortDescription,
      this.description,
      this.imageUrl,
      this.goalAmount,
      this.currentAmount,
      this.backerCount,
      this.userId,
      this.slug,
      this.perks,
      this.user,
      this.images});
  factory DataCampaignDetailModel.fromJson(Map<String, dynamic> json) =>
      _$DataCampaignDetailModelFromJson(json);
}

@JsonSerializable(
    createToJson: false, explicitToJson: false, fieldRename: FieldRename.snake)
class UserModel {
  final String? name;
  final String? imageUrl;

  UserModel({this.name, this.imageUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@JsonSerializable(
    createToJson: false, explicitToJson: false, fieldRename: FieldRename.snake)
class ImagesModel {
  final String? imageUrl;
  final bool? isPrimary;

  ImagesModel({this.imageUrl, this.isPrimary});
  factory ImagesModel.fromJson(Map<String, dynamic> json) =>
      _$ImagesModelFromJson(json);
}

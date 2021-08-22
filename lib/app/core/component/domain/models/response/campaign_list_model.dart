import 'package:crowd_funding/app/core/component/domain/models/response/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'campaign_list_model.g.dart';

@JsonSerializable(createToJson: false, explicitToJson: false)
class CampaignListModel {
  final Meta? meta;
  final List<DataCampaignModel>? data;
  CampaignListModel({this.meta, this.data});

  factory CampaignListModel.fromJson(Map<String, dynamic> json) =>
      _$CampaignListModelFromJson(json);
}

@JsonSerializable(
    createToJson: false, explicitToJson: false, fieldRename: FieldRename.snake)
class DataCampaignModel {
  final int? id;
  final int? userId;
  final String? name;
  final String? shortDescription;
  final String? imageUrl;
  final int? goalAmount;
  final int? currentAmount;
  final String? slug;

  DataCampaignModel(
      {this.id,
      this.userId,
      this.name,
      this.shortDescription,
      this.imageUrl,
      this.goalAmount,
      this.currentAmount,
      this.slug});
  factory DataCampaignModel.fromJson(Map<String, dynamic> json) =>
      _$DataCampaignModelFromJson(json);
}

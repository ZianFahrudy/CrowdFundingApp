import 'package:json_annotation/json_annotation.dart';

part 'upload_campaign_image_body.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class UploadCampaignImageBody {
  final int? campaignId;
  final String? file;
  final bool? isPrimary;

  UploadCampaignImageBody({this.campaignId, this.file, this.isPrimary});

  Map<String, dynamic> toJson() => _$UploadCampaignImageBodyToJson(this);
}

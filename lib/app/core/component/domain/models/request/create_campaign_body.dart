import 'package:json_annotation/json_annotation.dart';

part 'create_campaign_body.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class CreateCampaignBody {
  final String? name;
  final String? shortDescription;
  final String? description;
  final int? goalAmount;
  final String? perks;

  CreateCampaignBody(
      {this.name,
      this.shortDescription,
      this.description,
      this.goalAmount,
      this.perks});

  Map<String, dynamic> toJson() => _$CreateCampaignBodyToJson(this);
}

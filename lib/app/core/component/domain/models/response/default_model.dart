import 'package:json_annotation/json_annotation.dart';

import 'meta.dart';

part 'default_model.g.dart';

@JsonSerializable(createToJson: false, explicitToJson: false)
class DefaultModel {
  final Meta meta;

  DefaultModel(this.meta);
  factory DefaultModel.fromJson(Map<String, dynamic> json) =>
      _$DefaultModelFromJson(json);
}

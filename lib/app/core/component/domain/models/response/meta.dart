import 'package:json_annotation/json_annotation.dart';

part 'meta.g.dart';

@JsonSerializable(createToJson: false, explicitToJson: false)
class Meta {
  final String? message;
  final int? code;
  final String? status;

  Meta({this.message, this.code, this.status});

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}

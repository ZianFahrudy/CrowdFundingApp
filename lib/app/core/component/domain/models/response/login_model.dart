import 'package:crowd_funding/app/core/component/domain/models/response/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable(createToJson: false, explicitToJson: false)
class LoginModel {
  final Meta? meta;
  final DataLoginModel? data;

  LoginModel({this.meta, this.data});
  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
}

@JsonSerializable(
    createToJson: false, explicitToJson: false, fieldRename: FieldRename.snake)
class DataLoginModel {
  final int? id;
  final String? name;
  final String? occupation;
  final String? email;
  final String? token;
  final String? imageUrl;

  DataLoginModel({
    this.id,
    this.name,
    this.occupation,
    this.email,
    this.token,
    this.imageUrl,
  });

  factory DataLoginModel.fromJson(Map<String, dynamic> json) =>
      _$DataLoginModelFromJson(json);
}

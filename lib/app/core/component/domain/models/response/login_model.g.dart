// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) {
  return LoginModel(
    meta: json['meta'] == null
        ? null
        : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    data: json['data'] == null
        ? null
        : DataLoginModel.fromJson(json['data'] as Map<String, dynamic>),
  );
}

DataLoginModel _$DataLoginModelFromJson(Map<String, dynamic> json) {
  return DataLoginModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    occupation: json['occupation'] as String?,
    email: json['email'] as String?,
    token: json['token'] as String?,
    imageUrl: json['image_url'] as String?,
  );
}

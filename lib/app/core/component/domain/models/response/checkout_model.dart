import 'package:crowd_funding/app/core/component/domain/models/response/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'checkout_model.g.dart';

@JsonSerializable(createToJson: false, explicitToJson: false)
class CheckoutModel {
  final Meta? meta;
  final DataCheckoutModel? data;

  CheckoutModel({this.meta, this.data});

  factory CheckoutModel.fromJson(Map<String, dynamic> json) =>
      _$CheckoutModelFromJson(json);
}

@JsonSerializable(
    createToJson: false, explicitToJson: false, fieldRename: FieldRename.snake)
class DataCheckoutModel {
  final int? id;
  final int? campaignId;
  final int? userId;
  final int? amount;
  final String? status;
  final String? code;
  final String? paymentUrl;

  DataCheckoutModel(
      {this.id,
      this.campaignId,
      this.userId,
      this.amount,
      this.status,
      this.code,
      this.paymentUrl});

  factory DataCheckoutModel.fromJson(Map<String, dynamic> json) =>
      _$DataCheckoutModelFromJson(json);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutModel _$CheckoutModelFromJson(Map<String, dynamic> json) {
  return CheckoutModel(
    meta: json['meta'] == null
        ? null
        : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    data: json['data'] == null
        ? null
        : DataCheckoutModel.fromJson(json['data'] as Map<String, dynamic>),
  );
}

DataCheckoutModel _$DataCheckoutModelFromJson(Map<String, dynamic> json) {
  return DataCheckoutModel(
    id: json['id'] as int?,
    campaignId: json['campaign_id'] as int?,
    userId: json['user_id'] as int?,
    amount: json['amount'] as int?,
    status: json['status'] as String?,
    code: json['code'] as String?,
    paymentUrl: json['payment_url'] as String?,
  );
}

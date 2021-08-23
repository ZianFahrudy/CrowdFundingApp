// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionListModel _$TransactionListModelFromJson(Map<String, dynamic> json) {
  return TransactionListModel(
    meta: json['meta'] == null
        ? null
        : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => DataTransaction.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

DataTransaction _$DataTransactionFromJson(Map<String, dynamic> json) {
  return DataTransaction(
    id: json['id'] as int?,
    amount: json['amount'] as int?,
    status: json['status'] as String?,
    createdAt: json['created_at'] as String?,
    campaign: json['campaign'] == null
        ? null
        : DataCampaign.fromJson(json['campaign'] as Map<String, dynamic>),
  );
}

DataCampaign _$DataCampaignFromJson(Map<String, dynamic> json) {
  return DataCampaign(
    name: json['name'] as String?,
    imageUrl: json['image_url'] as String?,
  );
}

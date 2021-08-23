import 'package:crowd_funding/app/core/component/domain/models/response/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction_list_model.g.dart';

@JsonSerializable(createToJson: false, explicitToJson: false)
class TransactionListModel {
  final Meta? meta;
  final List<DataTransaction>? data;

  TransactionListModel({this.meta, this.data});

  factory TransactionListModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionListModelFromJson(json);
}

@JsonSerializable(
    createToJson: false, explicitToJson: false, fieldRename: FieldRename.snake)
class DataTransaction {
  final int? id;
  final int? amount;
  final String? status;
  final String? createdAt;
  final DataCampaign? campaign;

  DataTransaction(
      {this.id, this.amount, this.status, this.createdAt, this.campaign});
  factory DataTransaction.fromJson(Map<String, dynamic> json) =>
      _$DataTransactionFromJson(json);
}

@JsonSerializable(
    createToJson: false, explicitToJson: false, fieldRename: FieldRename.snake)
class DataCampaign {
  final String? name;
  final String? imageUrl;

  DataCampaign({this.name, this.imageUrl});
  factory DataCampaign.fromJson(Map<String, dynamic> json) =>
      _$DataCampaignFromJson(json);
}

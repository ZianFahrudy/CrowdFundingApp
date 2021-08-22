import 'package:json_annotation/json_annotation.dart';

part 'checkout_body.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class CheckoutBody {
  final int? amount;
  final int? campaignId;
  CheckoutBody({this.amount, this.campaignId});

  Map<String, dynamic> toJson() => _$CheckoutBodyToJson(this);
}

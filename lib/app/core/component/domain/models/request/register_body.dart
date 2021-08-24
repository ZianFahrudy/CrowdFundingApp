import 'package:json_annotation/json_annotation.dart';

part 'register_body.g.dart';

@JsonSerializable(createFactory: false)
class RegisterBody {
  final String? name;
  final String? email;
  final String? occupation;
  final String? password;

  RegisterBody({this.name, this.email, this.occupation, this.password});
  Map<String, dynamic> toJson() => _$RegisterBodyToJson(this);
}

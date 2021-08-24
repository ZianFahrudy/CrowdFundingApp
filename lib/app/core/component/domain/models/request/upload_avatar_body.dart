import 'package:json_annotation/json_annotation.dart';

part 'upload_avatar_body.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class UploadAvatarBody {
  final String? avatar;

  UploadAvatarBody(this.avatar);

  Map<String, dynamic> toJson() => _$UploadAvatarBodyToJson(this);
}

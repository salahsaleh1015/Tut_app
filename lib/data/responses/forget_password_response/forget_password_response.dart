import 'package:json_annotation/json_annotation.dart';
part 'forget_password_response.g.dart';
@JsonSerializable()
class BaseForgetPasswordResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class SupportForgetPasswordResponse  extends BaseForgetPasswordResponse{
  @JsonKey(name: "support")
  String? supportMessage;

  SupportForgetPasswordResponse(this.supportMessage);

  factory SupportForgetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$SupportForgetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SupportForgetPasswordResponseToJson(this);
}



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
class ForgetPasswordResponse  extends BaseForgetPasswordResponse{
  @JsonKey(name: "support")
  String? supportMessage;

  ForgetPasswordResponse(this.supportMessage);

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordResponseToJson(this);
}



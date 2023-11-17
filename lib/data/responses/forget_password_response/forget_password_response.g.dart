// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseForgetPasswordResponse _$BaseForgetPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    BaseForgetPasswordResponse()
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$BaseForgetPasswordResponseToJson(
        BaseForgetPasswordResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

ForgetPasswordResponse _$ForgetPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ForgetPasswordResponse(
      json['support'] as String?,
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$ForgetPasswordResponseToJson(
        ForgetPasswordResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'support': instance.supportMessage,
    };

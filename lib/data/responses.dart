import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
class BaseResponse{
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}


@JsonSerializable()
class CustomerResponse{
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name ;
  @JsonKey(name:"numOfNotifications")
  int? numOfNotifications;
}

@JsonSerializable()
class ContactResponse{
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "phone")
  String? phone ;
  @JsonKey(name:"link")
  String? link;
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse{
  @JsonKey(name: "customer")
  CustomerResponse? customerResponse;
  @JsonKey(name: "contact")
  ContactResponse? contactResponse;



}


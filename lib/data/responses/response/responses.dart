import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;

  CustomerResponse(this.id, this.name, this.numOfNotifications);

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactResponse {
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "link")
  String? link;

  ContactResponse(this.email, this.phone, this.link);

  factory ContactResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContactResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contact")
  ContactResponse? contact;

  AuthenticationResponse(this.customer, this.contact);

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);

}


@JsonSerializable()
class ServicesResponse{
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;

  factory ServicesResponse.fromJson(Map<String, dynamic>json)=>
      _$ServicesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesResponseToJson(this);


  ServicesResponse(this.id,this.image,this.title);

}


@JsonSerializable()
class BannersResponse{
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "link")
  String? link;
  @JsonKey(name: "image")
  String? image;

  factory BannersResponse.fromJson(Map<String, dynamic>json)=>
      _$BannersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BannersResponseToJson(this);

  BannersResponse(this.id,this.image,this.title, this.link);


}


@JsonSerializable()
class StoresResponse{

  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;

  factory StoresResponse.fromJson(Map<String, dynamic>json)=>
      _$StoresResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoresResponseToJson(this);


  StoresResponse(this.id,this.image,this.title);

}
@JsonSerializable()
class HomeDataResponse{

  @JsonKey(name: "services")
  List<ServicesResponse>? services;
  @JsonKey(name: "banners")
  List<BannersResponse>? banners;
  @JsonKey(name: "stores")
  List<StoresResponse>? stores;

  factory HomeDataResponse.fromJson(Map<String, dynamic>json)=>
      _$HomeDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);


  HomeDataResponse(this.services, this.banners, this.stores);

}

@JsonSerializable()
class HomeResponse extends BaseResponse{
  @JsonKey(name: "data")
  HomeDataResponse ? data;

  factory HomeResponse.fromJson(Map<String, dynamic>json)=>
      _$HomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);


  HomeResponse(this.data);


}

































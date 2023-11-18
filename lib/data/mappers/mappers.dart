import 'package:dio/dio.dart';
import 'package:tut_app/application/costants.dart';
import 'package:tut_app/application/extensions.dart';
import 'package:tut_app/data/responses/login_response/responses.dart';

import '../../domain/entities/entities.dart';
import '../responses/forget_password_response/forget_password_response.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id.orEmpty() ?? Constants.empty,
        this?.name.orEmpty() ?? Constants.empty,
        this?.numOfNotifications.orZero() ?? Constants.zero);
  }
}

extension ContactsResponseMapper on ContactResponse? {
  Contacts toDomain() {
    return Contacts(
        this?.email.orEmpty() ?? Constants.empty,
        this?.phone.orEmpty() ?? Constants.empty,
        this?.link.orEmpty() ?? Constants.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this?.customer.toDomain(), this?.contact.toDomain());
  }
}

extension ForgetPasswordResponseMapper
    on ForgetPasswordResponse? {
  ForgetPassword toDomain() {
    return ForgetPassword(
        this?.supportMessage.orEmpty() ?? Constants.empty);
  }
}

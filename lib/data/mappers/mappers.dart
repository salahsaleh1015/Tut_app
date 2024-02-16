import 'package:tut_app/application/costants.dart';
import 'package:tut_app/application/extensions.dart';

import '../../domain/entities/entities.dart';
import '../responses/forget_password_response/forget_password_response.dart';
import '../responses/response/responses.dart';

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

extension ForgetPasswordResponseMapper on ForgetPasswordResponse? {
  ForgetPassword toDomain() {
    return ForgetPassword(this?.supportMessage.orEmpty() ?? Constants.empty);
  }
}

extension ServicesResponseMapper on ServicesResponse? {
  Service toDomain() {
    return Service(
        this?.id.orZero() ?? Constants.zero,
        this?.image.orEmpty() ?? Constants.empty,
        this?.title.orEmpty() ?? Constants.empty);
  }
}

extension StoresResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(
        this?.id.orZero() ?? Constants.zero,
        this?.image.orEmpty() ?? Constants.empty,
        this?.title.orEmpty() ?? Constants.empty);
  }
}

extension BannerResponseMapper on BannersResponse? {
  BannerAd toDomain() {
    return BannerAd(
        this?.id.orZero() ?? Constants.zero,
        this?.image.orEmpty() ?? Constants.empty,
        this?.title.orEmpty() ?? Constants.empty,
        this?.link.orEmpty() ?? Constants.empty);
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Store> stores = (this
                ?.data
                ?.stores
                ?.map((storesResponse) => storesResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Store>()
        .toList();

    List<BannerAd> banners = (this
                ?.data
                ?.banners
                ?.map((bannersResponse) => bannersResponse.toDomain()) ??
            const Iterable.empty())
        .cast<BannerAd>()
        .toList();

    List<Service> services = (this
                ?.data
                ?.services
                ?.map((servicesResponse) => servicesResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Service>()
        .toList();

    var data = HomeData(services, banners, stores);
    return HomeObject(data);
  }
}

extension HomeDetailsMapper on HomeDetailsResponse? {
  HomeDetails toDomain() {
    return HomeDetails(
      this?.image.orEmpty() ?? Constants.empty,
      this?.id.orZero() ?? Constants.zero,
      this?.title.orEmpty() ?? Constants.empty,
      this?.details.orEmpty() ?? Constants.empty,
      this?.services.orEmpty() ?? Constants.empty,
      this?.about.orEmpty() ?? Constants.empty,
    );
  }
}

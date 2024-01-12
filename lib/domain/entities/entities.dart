class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class SliderViewObject {
  SliderObject sliderObject;
  int currentIndex;
  int numOfSlides;

  SliderViewObject(this.sliderObject, this.currentIndex, this.numOfSlides);
}

class Customer {
  String id;

  String name;

  int numOfNotifications;

  Customer(this.id, this.name, this.numOfNotifications);
}

class Contacts {
  String email;

  String phone;

  String link;

  Contacts(this.email, this.phone, this.link);
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer, this.contacts);
}

class ForgetPassword {
  String supportMessage;

  ForgetPassword(this.supportMessage);
}

class Service {
  int id;

  String title;

  String image;

  Service(this.id, this.image, this.title);
}

class BannerAd {
  int id;

  String title;

  String link;

  String image;

  BannerAd(this.id, this.image, this.title, this.link);
}

class Store {
  int id;

  String title;

  String image;

  Store(this.id, this.image, this.title);
}

class HomeData {
  List<Service> services;

  List<BannerAd> banners;

  List<Store> stores;

  HomeData(this.services, this.banners, this.stores);
}

class HomeObject {
  HomeData data;

  HomeObject(this.data);
}

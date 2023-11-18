class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class SliderViewObject{
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

class Contacts{
  String email;

  String phone;

  String link;

  Contacts(this.email, this.phone, this.link);
}

class Authentication{
  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer, this.contacts);
}

class ForgetPassword{
  String supportMessage;

  ForgetPassword(this.supportMessage);

}
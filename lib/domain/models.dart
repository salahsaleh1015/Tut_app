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
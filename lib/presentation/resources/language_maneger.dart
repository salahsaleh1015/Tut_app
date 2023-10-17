



enum LangaugeType{english , arabic}


const String arabic = "ar";
const String english = "en";

extension LangaugeTypeExtension on LangaugeType{

 String getLanguage(){
    switch(this){
      case LangaugeType.arabic:
      return arabic;
      case LangaugeType.english:
        return english;

    }
  }
}


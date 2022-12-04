enum SexChoice {
  male('MA'), female('FE');

  const SexChoice(this.value);
  final String value;

  static SexChoice getValue(int i){
    return SexChoice.values.firstWhere((x) => x.value == i);
  }

  static SexChoice getValueByEnum(String value){
    return SexChoice.values.firstWhere((x) => x.value == value);
  }
}

enum NeutralizeChoice {
  yes('IS'), no('NT'), dontknow('DO');

  const NeutralizeChoice(this.value);
  final String value;

  static NeutralizeChoice getValue(int i){
    return NeutralizeChoice.values.firstWhere((x) => x.value == i);
  }

  static NeutralizeChoice getValueByEnum(String value){
    return NeutralizeChoice.values.firstWhere((x) => x.value == value);
  }
}
enum AllergicChoice {
  yes('IS'), no('NT'), dontknow('DO');

  const AllergicChoice(this.value);
  final String value;

  static AllergicChoice getValue(int i){
    return AllergicChoice.values.firstWhere((x) => x.value == i);
  }

  static AllergicChoice getValueByEnum(String value){
    return AllergicChoice.values.firstWhere((x) => x.value == value);
  }
}

enum PetSort {
  DOG("강아지"), CAT("고양이"), ETC("기타");

  const PetSort(this.value);
  final String value;

  static PetSort getValue(int i){
    return PetSort.values.firstWhere((x) => x.value == i);
  }

  static PetSort getValueByEnum(String value){
    return PetSort.values.firstWhere((x) => x.name == value);
  }

  static String getEnumByName(String value){
  return PetSort.values.firstWhere((x) => x.value == value).name;
  }
}

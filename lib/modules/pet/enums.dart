enum SexChoice { male, female }
enum NeutralizeChoice { yes, no, dontknow }
enum AllergicChoice { yes, no, dontknow }

String PetSexRawValue(SexChoice sex){
  if (sex.name == 'male') {
    return 'MA';
  } else {
    return 'FE';
  }
}

String PetNeutralizeRawValue(NeutralizeChoice neutralize){
  if (neutralize.name == 'yes') {
    return 'IS';
  } else if (neutralize.name == 'no') {
    return 'NT';
  } else {
    return 'DO';
  }
}

String PetAllergicRawValue(AllergicChoice allergicChoice){
  if (allergicChoice.name == 'yes') {
    return 'IS';
  } else if (allergicChoice.name == 'no') {
    return 'NT';
  } else {
    return 'DO';
  }
}

String PetSortRawValue(int kind) {
  if (kind == 0) {
    return '강아지';
  } else if (kind == 1) {
    return '고양이';
  } else {
    return '기타';
  }
}
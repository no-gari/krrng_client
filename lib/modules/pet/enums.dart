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
    return '';
  } else if (neutralize.name == 'no') {
    return '';
  } else {
    return '';
  }
}

String PetAllergicRawValue(AllergicChoice allergicChoice){
  if (allergicChoice.name == 'yes') {
    return '';
  } else if (allergicChoice.name == 'no') {
    return '';
  } else {
    return '';
  }
}
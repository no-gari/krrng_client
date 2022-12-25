enum HospitalFilter {
  distance('거리순'),
  price('가격순'),
  recommend('애정온도순'),
  review('리뷰순');

  const HospitalFilter(this.title);
  final String title;

  static int getIndex(HospitalFilter? filter) {
    return HospitalFilter.values
        .firstWhere((element) => element == filter)
        .index;
  }

  static HospitalFilter getFilter(String value) {
    return HospitalFilter.values
        .firstWhere((element) => element.title == value);
  }
}

enum HospitalPart {
  everything('전체 보기'),
  allDay('24시 진료'),
  ophthalmology('안과 진료'),
  dermatology('피부 진료'),
  digestive('소화기관'),
  respiratory('호흡기'),
  dentist('치과 전문'),
  psychiatry('정신(뇌)'),
  koreaMedicine('한의원');

  const HospitalPart(this.title);
  final String title;

  static int getIndex(HospitalPart part) {
    return HospitalPart.values.firstWhere((element) => element == part).index;
  }

  static HospitalPart getPart(String value) {
    return HospitalPart.values.firstWhere((element) => element.title == value);
  }
}

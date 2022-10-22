class Item {
  Item(
      {required this.title,
      required this.time,
      this.sort,
      this.isExpanded = false,
      this.amount,
      this.reason});

  bool? isExpanded;
  String? title;
  String? time;
  String? sort;
  int? amount;
  String? reason;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
        title: '친구 초대',
        time: '2022-09-15',
        sort: '적립',
        amount: 10000,
        reason:
            '우수 회원으로 선정되어 포인트를 지급합니다. 우수 회원으로 선정되어 포인트를 지급합니다. 우수 회원으로 선정되어 포인트를 지급합니다');
  });
}

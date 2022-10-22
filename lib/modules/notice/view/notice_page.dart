import 'package:flutter/material.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  final List<Item> _data = generateItems(8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: Text('공지사항', style: Theme.of(context).textTheme.headline2)),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          SizedBox(height: 20),
          ExpansionPanelList(
              dividerColor: Colors.black12,
              elevation: 0,
              expansionCallback: (int index, bool isExpanded) =>
                  setState(() => _data[index].isExpanded = !isExpanded),
              children: _data.map<ExpansionPanel>((Item item) {
                return ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Text(item.sort!,
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).accentColor)),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color:
                                          Theme.of(context).backgroundColor)),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(item.headerValue!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w900)),
                              ),
                            ],
                          ),
                          subtitle: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(item.date!,
                                  style: TextStyle(fontSize: 14))));
                    },
                    body: Container(
                        padding:
                            EdgeInsets.only(bottom: 10, left: 16, right: 16),
                        alignment: Alignment.centerLeft,
                        child: Text('blabla', style: TextStyle(fontSize: 14))),
                    isExpanded: item.isExpanded!);
              }).toList())
        ]))));
  }
}

class Item {
  Item(
      {required this.expandedValue,
      required this.headerValue,
      this.isExpanded = false,
      this.sort,
      this.date});

  String? expandedValue;
  String? headerValue;
  String? date;
  String? sort;
  bool? isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
        headerValue: '친구는 어떻게 초대 할 수 있나요? $index',
        date: '2022-09-15',
        sort: '공지',
        expandedValue: '답변입니다. $index');
  });
}

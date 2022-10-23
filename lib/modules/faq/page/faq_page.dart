import 'package:flutter/material.dart';
import 'package:krrng_client/modules/faq/components/faq_button.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  int selectedIndex = 0;
  final _scrollController = ScrollController();
  final List<Item> _data = generateItems(8);

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: Text('FAQ', style: Theme.of(context).textTheme.headline2)),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          Container(
              height: 78,
              padding: EdgeInsets.only(top: 20, bottom: 10, left: 16),
              child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () => setState(() => selectedIndex = index),
                        child: FaqButton(
                            title: '전체', isSelected: selectedIndex == index));
                  })),
          ExpansionPanelList(
              dividerColor: Colors.black12,
              elevation: 0,
              expansionCallback: (int index, bool isExpanded) =>
                  setState(() => _data[index].isExpanded = !isExpanded),
              children: _data.map<ExpansionPanel>((Item item) {
                return ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                          title: Text(item.headerValue,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w900)));
                    },
                    body: Container(
                        padding:
                            EdgeInsets.only(bottom: 10, left: 16, right: 16),
                        alignment: Alignment.centerLeft,
                        child: Text('blabla', style: TextStyle(fontSize: 14))),
                    isExpanded: item.isExpanded);
              }).toList())
        ]))));
  }
}

class Item {
  Item(
      {required this.expandedValue,
      required this.headerValue,
      this.isExpanded = false});

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
        headerValue: '친구는 어떻게 초대 할 수 있나요? $index',
        expandedValue: '답변입니다. $index');
  });
}

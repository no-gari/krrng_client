import 'package:flutter/material.dart';
import 'package:krrng_client/modules/point/components/point_tile.dart';
import 'package:krrng_client/support/style/format_unit.dart';
import '../components/point_button.dart';

class PointPage extends StatefulWidget {
  const PointPage({Key? key}) : super(key: key);

  @override
  State<PointPage> createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {
  int _selectedIndex = 0;
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
            title:
                Text('포인트 관리', style: Theme.of(context).textTheme.headline2)),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          Container(
              width: double.maxFinite,
              padding:
                  EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 40),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color(0xFFDFE2E9), width: 1))),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('보유 포인트', style: TextStyle(fontSize: 14)),
                            SizedBox(height: 10),
                            Text('117,500P',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    color: Theme.of(context).accentColor)),
                            SizedBox(height: 20),
                            Row(children: [
                              PointButton(
                                  title: '최신순',
                                  isSelected: _selectedIndex == 0,
                                  onTap: () =>
                                      setState(() => _selectedIndex = 0)),
                              PointButton(
                                  title: '과거순',
                                  isSelected: _selectedIndex == 1,
                                  onTap: () =>
                                      setState(() => _selectedIndex = 1))
                            ])
                          ]),
                    ),
                    Image.asset('assets/images/point.png'),
                  ])),
          ExpansionPanelList(
              dividerColor: Colors.black12,
              elevation: 0,
              expansionCallback: (int index, bool isExpanded) =>
                  setState(() => _data[index].isExpanded = !isExpanded),
              children: _data.map<ExpansionPanel>((Item item) {
                return ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Container(
                          // decoration: BoxDecoration(
                          //     border: Border(
                          //         bottom: BorderSide(color: Colors.black12))),
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(item.title!,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 8),
                                      Text(item.time!,
                                          style: TextStyle(fontSize: 14))
                                    ]),
                                Row(children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: item.sort == '적립'
                                              ? Theme.of(context)
                                                  .backgroundColor
                                              : Color(0xFFFFF1F1)),
                                      height: 24,
                                      child: Text(item.sort!,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: item.sort == '적립'
                                                  ? Theme.of(context)
                                                      .accentColor
                                                  : Color(0xFFF85757)))),
                                  SizedBox(width: 6),
                                  Text(
                                      currencyFromString(
                                          item.amount.toString()),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                          color: item.sort == '적립'
                                              ? Theme.of(context).accentColor
                                              : Color(0xFFF85757)))
                                ])
                              ]));
                    },
                    body: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black12, width: 0.5),
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFFFBFBFB)),
                        child: Text(
                          item.reason!,
                          style: TextStyle(fontSize: 14),
                        )),
                    isExpanded: item.isExpanded!);
              }).toList())
        ]))));
  }
}

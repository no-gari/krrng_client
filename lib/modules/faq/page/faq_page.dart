import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/faq/components/faq_button.dart';
import 'package:krrng_client/modules/faq/cubit/faq_cubit.dart';
import 'package:krrng_client/repositories/faq_repository/models/faq.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  late FAQCubit _faqCubit;

  int selectedIndex = 0;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _faqCubit = BlocProvider.of<FAQCubit>(context);
    _faqCubit.getFAQList();
  }

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
        body: SafeArea(child:
            BlocBuilder<FAQCubit, FAQState>(builder: (context, faqState) {
          if (faqState.isLoaded == true) {
            var faqList = faqState.faq![selectedIndex].faq.toList();

            return SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Container(
                      height: 78,
                      padding: EdgeInsets.only(top: 20, bottom: 10, left: 16),
                      child: ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: faqState.faq!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () =>
                                    setState(() => selectedIndex = index),
                                child: FaqButton(
                                    title: faqState.faq![index].name.toString(),
                                    isSelected: selectedIndex == index));
                          })),
                  ExpansionPanelList(
                      dividerColor: Colors.black12,
                      elevation: 0,
                      expansionCallback: (int index, bool isExpanded) =>
                          setState(() =>
                              faqState.faq![selectedIndex].faq[index] = FAQ(
                                faqList[index].name,
                                faqList[index].content,
                                faqList[index].id,
                                !isExpanded,
                              )),
                      children: faqList.map<ExpansionPanel>((FAQ faq) {
                        return ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(
                                  title: Text(faq.name.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w900)));
                            },
                            body: Container(
                                padding: EdgeInsets.only(
                                    bottom: 10, left: 16, right: 16),
                                alignment: Alignment.centerLeft,
                                child: Text(faq.content.toString(),
                                    style: TextStyle(fontSize: 14))),
                            isExpanded: faq.isExpanded!);
                      }).toList())
                ]));
          }
          return Center(
              child: Image.asset('assets/images/indicator.gif',
                  width: 100, height: 100));
        })));
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

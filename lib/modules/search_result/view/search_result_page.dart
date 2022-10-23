import 'package:flutter/material.dart';
import 'package:krrng_client/modules/search_result/components/search_bar.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({Key? key}) : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(children: [
                SearchBar(textEditingController: _textEditingController),
                SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('검색 결과',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      GestureDetector(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                            Text('22개 검색 결과', style: TextStyle(fontSize: 14)),
                            SizedBox(width: 10),
                            Icon(Icons.filter_alt_outlined, size: 20)
                          ]))
                    ]),
              ]))),
    );
  }
}

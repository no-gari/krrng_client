import 'package:flutter/material.dart';
import 'package:krrng_client/modules/search/components/search_text_field.dart';
import '../components/hot_search_tile.dart';
import '../components/recent_search_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late FocusNode _focusNode;
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SearchTextField(
                          focusNode: _focusNode,
                          textEditingController: _textEditingController),
                      SizedBox(height: 30),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('최근 검색',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            GestureDetector(
                                child: Text('전체삭제',
                                    style: TextStyle(fontSize: 13)))
                          ]),
                      SizedBox(height: 16),
                      Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          direction: Axis.horizontal,
                          children: [
                            RecentSearchTile(title: '하늘 동물'),
                            RecentSearchTile(title: '강남'),
                            RecentSearchTile(title: '청담'),
                            RecentSearchTile(title: '청담'),
                            RecentSearchTile(title: '청담'),
                            RecentSearchTile(title: '청담')
                          ]),
                      SizedBox(height: 50),
                      Text('인기 검색어',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20),
                      HotSearchTile(leading: '1', title: '어쩌구'),
                      HotSearchTile(leading: '2', title: '저쩌구'),
                      HotSearchTile(leading: '3', title: '어쩌구'),
                    ]))));
  }
}

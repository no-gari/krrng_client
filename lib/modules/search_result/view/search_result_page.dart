import 'package:flutter/material.dart';
import 'package:krrng_client/modules/hospital_detail/view/hospital_detail_screen.dart';
import 'package:krrng_client/modules/search_result/components/search_bar.dart';
import 'package:krrng_client/modules/search_result/components/search_filter.dart';
import '../components/hospital_tile.dart';

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
                          onTap: () => showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return SearchFilter();
                              }),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('22개 검색 결과',
                                    style: TextStyle(fontSize: 14)),
                                SizedBox(width: 10),
                                Icon(Icons.filter_alt_outlined, size: 20)
                              ]))
                    ]),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HospitalDetailScreen())),
                  child: HospitalTile(
                      name: '하늘 동물 병원',
                      location: '서울 강남구 강남대로 117길 24 하늘빌딩 어쩌구 저쩌구 블라블라',
                      price: 100000,
                      image:
                          'https://media.istockphoto.com/vectors/free-3d-speech-bubble-sign-vector-id1156404289?k=20&m=1156404289&s=612x612&w=0&h=jpzVSuwyf8D33nng1wyGe80GRj9B5r7RvWA2_rf2bvc=',
                      temperature: 68,
                      reviews: 30,
                      howFar: 31),
                )
              ]))),
    );
  }
}

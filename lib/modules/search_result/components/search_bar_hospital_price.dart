import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krrng_client/modules/disease/page/disease_screen.dart';
import 'package:krrng_client/modules/search/cubit/recent_search_cubit.dart';
import 'package:krrng_client/modules/search_result/view/search_result_screen.dart';
import 'package:krrng_client/repositories/search_repository/models/recent_search.dart';
import 'package:vrouter/vrouter.dart';

class SearchBarHospitalPrice extends StatelessWidget {
  SearchBarHospitalPrice(
      {this.textEditingController,
      this.recentSearchCubit,
      this.focusNode,
      this.isFirstPage = true});

  final TextEditingController? textEditingController;
  final RecentSearchCubit? recentSearchCubit;
  final FocusNode? focusNode;
  final bool? isFirstPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              if (value.trim() != '') {
                var random = Random.secure();
                var values = List<int>.generate(8, (i) => random.nextInt(255));
                var randomId = base64UrlEncode(values);

                recentSearchCubit!
                    .addRecentSearch(RecentSearch(randomId, value));

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (_) => DiseaseScreen(symptom: value)));

                // textEditingController!.clear();
              }
            },
            autofocus: false,
            controller: textEditingController,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                icon: isFirstPage == true
                    ? null
                    : GestureDetector(
                        onTap: () => context.vRouter.pop(),
                        child: Icon(Icons.arrow_back_ios, color: Colors.black)),
                isCollapsed: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Color(0xFFDFE2E9))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xFFDFE2E9))),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Color(0xFFDFE2E9))),
                fillColor: Colors.white,
                filled: true,
                hintText: '증상을 검색하세요.',
                suffixIcon: Container(
                    width: 66,
                    child: Row(children: [
                      GestureDetector(
                          onTap: () => textEditingController!.clear(),
                          child: CircleAvatar(
                              radius: 9,
                              backgroundColor: Colors.black12,
                              child: Icon(Icons.close,
                                  color: Colors.white, size: 12))),
                      IconButton(
                          icon: SvgPicture.asset('assets/icons/search_icon.svg',
                              width: 20),
                          color: Colors.black,
                          onPressed: () => textEditingController!.clear())
                    ])))),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              ListTile(title: Text('hihi')),
              ListTile(title: Text('hihi')),
              ListTile(title: Text('hihi')),
              ListTile(title: Text('hihi')),
            ],
          ),
        )
      ],
    );
  }
}

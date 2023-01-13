import 'package:krrng_client/modules/search_result_branch/view/search_result_branch_screen.dart';
import 'package:krrng_client/repositories/search_repository/models/recent_search.dart';
import 'package:krrng_client/modules/search_result/view/search_result_screen.dart';
import 'package:krrng_client/modules/search/cubit/recent_search_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';
import 'dart:convert';
import 'dart:math';

class SearchTextField extends StatelessWidget {
  SearchTextField(
      {this.focusNode, this.textEditingController, this.recentSearchCubit});

  final TextEditingController? textEditingController;
  final RecentSearchCubit? recentSearchCubit;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
        focusNode: focusNode,
        textInputAction: TextInputAction.go,
        onSubmitted: (value) {
          if (value.trim() != '') {
            var random = Random.secure();
            var values = List<int>.generate(8, (i) => random.nextInt(255));
            var randomId = base64UrlEncode(values);

            recentSearchCubit!.addRecentSearch(RecentSearch(randomId, value));
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => SearchResultBranchScreen(keyword: value)));

            textEditingController!.clear();
          }
        },
        autofocus: true,
        controller: textEditingController,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            icon: GestureDetector(
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
            hintText: '검색어를 입력하세요.',
            suffixIcon: IconButton(
                icon:
                    SvgPicture.asset('assets/icons/search_icon.svg', width: 20),
                color: Colors.black,
                onPressed: () {})));
  }
}

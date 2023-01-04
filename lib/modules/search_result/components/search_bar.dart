import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krrng_client/modules/search/cubit/recent_search_cubit.dart';
import 'package:vrouter/vrouter.dart';

class SearchBar extends StatelessWidget {
  SearchBar({this.focusNode, this.textEditingController});

  final TextEditingController? textEditingController;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
        focusNode: focusNode,
        textInputAction: TextInputAction.go,
        onSubmitted: (value) {
          if (value.trim() != '') {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (_) => HospitalSearch(keyword: value)));

            textEditingController!.clear();
          }
        },
        autofocus: true,
        controller: textEditingController,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
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

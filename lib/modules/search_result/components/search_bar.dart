import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vrouter/vrouter.dart';

class SearchBar extends StatelessWidget {
  SearchBar({this.textEditingController});

  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
        textInputAction: TextInputAction.go,
        onSubmitted: (value) {
          if (value.trim() != '') {
            var random = Random.secure();
            var values = List<int>.generate(8, (i) => random.nextInt(255));
            var randomId = base64UrlEncode(values);

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
            hintText: '검색어를 입력 하세요.',
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
                ]))));
  }
}

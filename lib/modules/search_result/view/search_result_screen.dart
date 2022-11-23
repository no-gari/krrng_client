import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';
import 'search_result_page.dart';

class SearchResultScreen extends StatelessWidget {
  static const String routeName = '/search-result';

  @override
  Widget build(BuildContext context) {
    final keyword = context.vRouter.pathParameters['keyword'];

    return SearchResultPage(keyword: keyword);
  }
}

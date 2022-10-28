import 'package:flutter/material.dart';
import 'views.dart';

class WritingReviewScreen extends StatelessWidget {
  static const String routeName = '/review';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("병원 리뷰 등록", style: Theme.of(context).textTheme.headline2),
          centerTitle: false,
        ),
        body: WritingReviewPage()
    );
  }
}

import 'package:flutter/material.dart';

class ReviewNoticePage extends StatefulWidget {
  static const String routeName = '/review/notice';

  const ReviewNoticePage({Key? key}) : super(key: key);

  @override
  State<ReviewNoticePage> createState() => _ReviewNoticePageState();
}

class _ReviewNoticePageState extends State<ReviewNoticePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("병원 리뷰 등록", style: Theme.of(context).textTheme.headline2),
          centerTitle: false,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [

            ],
          ),
        )
    );
  }
}
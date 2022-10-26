import 'package:flutter/material.dart';
import 'package:krrng_client/app_view.dart';
import 'package:vrouter/vrouter.dart';

enum ReviewNotice {
  receipt('receipt', '영수증 첨부 안내'),
  hospital('hospital', '병원 리뷰 등록 안내사항'),
  none('', '');

  const ReviewNotice(this.code, this.title);
  final String code;
  final String title;

  factory ReviewNotice.getByCode(String code){
    return ReviewNotice.values.firstWhere((value) => value.code == code, orElse: () => ReviewNotice.none);
  }
}

class ReviewNoticePage extends StatefulWidget {
  static const String routeName = '/review/notice';

  const ReviewNoticePage({Key? key}) : super(key: key);

  @override
  State<ReviewNoticePage> createState() => _ReviewNoticePageState();
}

class _ReviewNoticePageState extends State<ReviewNoticePage> {

  String? code;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      code = context.vRouter.pathParameters["code"];
    });

    return Scaffold(
        appBar: AppBar(
          title: Text(code == null ? "안내" : ReviewNotice.getByCode(code!).title, style: Theme.of(context).textTheme.headline2),
          centerTitle: false,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text("안내 본문")
            ],
          ),
        )
    );
  }
}
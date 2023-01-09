import 'package:krrng_client/repositories/hospital_repository/models/review.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:krrng_client/support/style/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class ReviewDetailPage extends StatefulWidget {
  static const String routeName = '/hospital/review';

  final Review review;

  ReviewDetailPage(this.review);

  @override
  State<ReviewDetailPage> createState() => _ReviewDetailState(this.review);
}

class _ReviewDetailState extends State<ReviewDetailPage> {
  _ReviewDetailState(this.review);

  final Review review;
  final _scrollController = PageController();
  List<String?> imageList = [];
  int index = 0;

  @override
  void initState() {
    super.initState();

    setState(() {
      imageList = review.reviewImage?.map((e) => e.image).toList() ?? [];
    });

    _scrollController.addListener(() {
      setState(() {
        index = _scrollController.page?.toInt() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Column(children: [
          imageList.isNotEmpty
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.56,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      PageView.builder(
                          controller: _scrollController,
                          itemCount: imageList.length,
                          itemBuilder: (context, itemIndex) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.56,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          imageList[itemIndex]!),
                                      fit: BoxFit.cover)),
                            );
                          }),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, bottom: 10),
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black87,
                              shape: StadiumBorder(),
                              padding: EdgeInsets.zero,
                            ),
                            child: Text("${this.index + 1}/${imageList.length}",
                                style:
                                    font_12_w500.copyWith(color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(height: 0),
          SizedBox(height: 30),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.nickname ?? "", style: font_20_w900),
                    SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Icon(Icons.favorite,
                                color: Theme.of(context).accentColor, size: 16),
                            SizedBox(width: 8),
                            Text(review.rates!.toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).accentColor)),
                            Container(
                                height: 12,
                                width: 1,
                                color: Colors.black12,
                                margin: EdgeInsets.symmetric(horizontal: 10)),
                            Text(review.diagnosis!,
                                style: TextStyle(fontSize: 15))
                          ]),
                          Padding(
                              padding: EdgeInsets.only(right: 24.0),
                              child: Text(review.createdAt!,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey)))
                        ]),
                    SizedBox(height: 20),
                    Text(review.content!, style: font_15_w500),
                    SizedBox(height: 20),
                    Row(children: [
                      SvgPicture.asset(review.isLike == true
                          ? 'assets/icons/like_on.svg'
                          : 'assets/icons/like_off.svg'),
                      SizedBox(width: 10),
                      Text.rich(
                          TextSpan(style: TextStyle(fontSize: 15), children: [
                        TextSpan(
                            text: review.likes!.toString() + '명이 ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor)),
                        TextSpan(text: '이 리뷰를 좋아합니다.')
                      ]))
                    ])
                  ]))
        ])));
  }
}

import 'package:flutter/material.dart';

class LevelTile extends StatelessWidget {
  LevelTile({this.imagePath, this.title, this.app, this.product, this.review});

  final String? imagePath;
  final String? title;
  final String? app;
  final String? product;
  final String? review;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black12),
            color: Color(0xFFF3F3F3)),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              width: 80,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(imagePath!, width: 50, height: 50),
                    Text(title!, style: Theme.of(context).textTheme.headline5)
                  ])),
          SizedBox(width: 20),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text('앱 접속일'),
                  SizedBox(width: 10),
                  Container(height: 10, width: 1, color: Colors.black12),
                  SizedBox(width: 10),
                  Text(app!)
                ]),
                SizedBox(height: 5),
                Row(children: [
                  Text('상품 구매'),
                  SizedBox(width: 10),
                  Container(height: 10, width: 1, color: Colors.black12),
                  SizedBox(width: 10),
                  Text(product!)
                ]),
                SizedBox(height: 5),
                Row(children: [
                  Text('병원 리뷰'),
                  SizedBox(width: 10),
                  Container(height: 10, width: 1, color: Colors.black12),
                  SizedBox(width: 10),
                  Text(review!)
                ])
              ])
        ]));
  }
}

import 'package:flutter/material.dart';
import 'level_tile.dart';

class LevelInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: MediaQuery(
            data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
            child: SafeArea(
                child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('회원 등급 안내',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2),
                                    GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Icon(Icons.close))
                                  ])),
                          Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).backgroundColor,
                                  borderRadius: BorderRadius.circular(12)),
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 10),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Image.asset('assets/images/head.png',
                                          width: 40),
                                      SizedBox(width: 10.5),
                                      Text('크르릉 회원 등급표를 안내 드립니다.',
                                          style: TextStyle(fontSize: 13))
                                    ])
                                  ])),
                          LevelTile(
                              imagePath: 'assets/images/level1.png',
                              title: '씨앗단계',
                              app: '10일 미만',
                              product: '구매 전',
                              review: '5개 미만'),
                          LevelTile(
                              imagePath: 'assets/images/level2.png',
                              title: '새싹단계',
                              app: '10일 이상',
                              product: '5만원 이상',
                              review: '5개 이상'),
                          LevelTile(
                              imagePath: 'assets/images/level3.png',
                              title: '열매단계',
                              app: '30일 이상',
                              product: '10만원 이상',
                              review: '10개 이상'),
                          LevelTile(
                              imagePath: 'assets/images/level4.png',
                              title: '나무단계',
                              app: '50일 이상',
                              product: '15만원 이상',
                              review: '15개 이상'),
                          LevelTile(
                              imagePath: 'assets/images/level5.png',
                              title: '숲단계',
                              app: '100일 이상',
                              product: '20만원 이상',
                              review: '20개 이상'),
                          SizedBox(height: 15),
                          Text('회원등급은 운영 정책에 따라 변경될 수 있는 점 참고 부탁드립니다.'),
                          SizedBox(height: 15),
                          Text('※ 등급 기준 중 2개 이상 충족 되어야 승급.',
                              style: TextStyle(
                                  color: Theme.of(context).accentColor))
                        ])))));
  }
}

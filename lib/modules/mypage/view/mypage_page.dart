import 'package:krrng_client/modules/mypage/components/level_tile.dart';
import 'package:krrng_client/modules/mypage/components/sub_menu.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:krrng_client/modules/settings/view/setting_screen.dart';
import 'package:logger/logger.dart';
import 'package:vrouter/vrouter.dart';
import '../components/main_menu.dart';

class MyPagePage extends StatefulWidget {
  @override
  State<MyPagePage> createState() => _MyPagePageState();
}

class _MyPagePageState extends State<MyPagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: Text('마이페이지', style: Theme.of(context).textTheme.headline2),
            actions: [
              GestureDetector(
                  onTap: () => context.vRouter.to(SettingScreen.routeName),
                  child: Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: SvgPicture.asset('assets/icons/settings.svg')))
            ]),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          SizedBox(height: 30),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Image.asset('assets/images/default_image.png',
                          width: 44, height: 44),
                      SizedBox(width: 10),
                      Text('로그인',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Theme.of(context).accentColor,
                              decoration: TextDecoration.underline))
                    ]),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return Container(
                                  height: MediaQuery.of(context).size.height,
                                  child: MediaQuery(
                                      data: MediaQueryData.fromWindow(
                                          WidgetsBinding.instance.window),
                                      child: SafeArea(
                                          child: SingleChildScrollView(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text('회원 등급 안내',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .headline2),
                                                              GestureDetector(
                                                                  onTap: () =>
                                                                      Navigator.pop(
                                                                          context),
                                                                  child: Icon(
                                                                      Icons
                                                                          .close))
                                                            ])),
                                                    Container(
                                                        decoration: BoxDecoration(
                                                            color: Theme.of(
                                                                    context)
                                                                .backgroundColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 14,
                                                                vertical: 10),
                                                        child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(children: [
                                                                Image.asset(
                                                                    'assets/images/head.png',
                                                                    width: 40),
                                                                SizedBox(
                                                                    width:
                                                                        10.5),
                                                                Text(
                                                                    '크르릉 회원 등급표를 안내 드립니다.',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            13))
                                                              ])
                                                            ])),
                                                    LevelTile(
                                                        imagePath:
                                                            'assets/images/level1.png',
                                                        title: '씨앗단계',
                                                        app: '10일 미만',
                                                        product: '구매 전',
                                                        review: '5개 미만'),
                                                    LevelTile(
                                                        imagePath:
                                                            'assets/images/level2.png',
                                                        title: '새싹단계',
                                                        app: '10일 이상',
                                                        product: '5만원 이상',
                                                        review: '5개 이상'),
                                                    LevelTile(
                                                        imagePath:
                                                            'assets/images/level3.png',
                                                        title: '열매단계',
                                                        app: '30일 이상',
                                                        product: '10만원 이상',
                                                        review: '10개 이상'),
                                                    LevelTile(
                                                        imagePath:
                                                            'assets/images/level4.png',
                                                        title: '나무단계',
                                                        app: '50일 이상',
                                                        product: '15만원 이상',
                                                        review: '15개 이상'),
                                                    LevelTile(
                                                        imagePath:
                                                            'assets/images/level5.png',
                                                        title: '숲단계',
                                                        app: '100일 이상',
                                                        product: '20만원 이상',
                                                        review: '20개 이상'),
                                                    SizedBox(height: 15),
                                                    Text(
                                                        '회원등급은 운영 정책에 따라 변경될 수 있는 점 참고 부탁드립니다.'),
                                                    SizedBox(height: 15),
                                                    Text(
                                                        '※ 등급 기준 중 2개 이상 충족 되어야 승급.',
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .accentColor))
                                                  ])))));
                            });
                      },
                      child: Row(children: [
                        Text('등급안내', style: TextStyle(fontSize: 14)),
                        SizedBox(width: 6),
                        Icon(Icons.info_outline, size: 20, color: Colors.grey)
                      ]),
                    )
                  ])),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 36, vertical: 30),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MainMenu(iconPath: 'assets/icons/point.svg', title: '포인트'),
                    MainMenu(
                        iconPath: 'assets/icons/favorite.svg', title: '찜 목록'),
                    MainMenu(iconPath: 'assets/icons/order.svg', title: '주문 목록')
                  ])),
          Container(
              width: double.maxFinite, height: 12, color: Color(0xFFF3F3F3)),
          SubMenu(title: '친구초대'),
          SubMenu(title: '내가 쓴 리뷰'),
          SubMenu(title: '내가 즐겨찾는 상품'),
          SubMenu(title: '자주 묻는 질문 (FAQ)'),
          SubMenu(title: '공지사항'),
          SubMenu(title: '내 정보 변경')
        ]))));
  }
}

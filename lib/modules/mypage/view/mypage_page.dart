import 'package:krrng_client/modules/faq/page/faq_screen.dart';
import 'package:krrng_client/modules/mypage/components/sub_menu.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:krrng_client/modules/notice/view/notice_screen.dart';
import 'package:krrng_client/modules/point/page/point_screen.dart';
import 'package:krrng_client/modules/profile_change/view/profile_change_screen.dart';
import 'package:krrng_client/modules/settings/view/setting_screen.dart';
import 'package:vrouter/vrouter.dart';
import '../components/main_menu.dart';
import '../components/level_info.dart';

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
                                return LevelInfo();
                              });
                        },
                        child: Row(children: [
                          Text('등급안내', style: TextStyle(fontSize: 14)),
                          SizedBox(width: 6),
                          Icon(Icons.info_outline, size: 20, color: Colors.grey)
                        ]))
                  ])),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 36, vertical: 30),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MainMenu(
                        iconPath: 'assets/icons/point.svg',
                        title: '포인트',
                        onTap: () => context.vRouter.to(PointScreen.routeName)),
                    MainMenu(
                        iconPath: 'assets/icons/favorite.svg', title: '찜 목록'),
                    MainMenu(iconPath: 'assets/icons/order.svg', title: '주문 목록')
                  ])),
          Container(
              width: double.maxFinite, height: 12, color: Color(0xFFF3F3F3)),
          SubMenu(title: '친구초대'),
          SubMenu(title: '내가 쓴 리뷰'),
          // SubMenu(title: '내가 즐겨찾는 상품'),
          SubMenu(
              title: '자주 묻는 질문 (FAQ)',
              onTap: () => context.vRouter.to(FaqScreen.routeName)),
          SubMenu(
              title: '공지사항',
              onTap: () => context.vRouter.to(NoticeScreen.routeName)),
          SubMenu(
              title: '내 정보 변경',
              onTap: () => context.vRouter.to(ProfileChangeScreen.routeName))
        ]))));
  }
}

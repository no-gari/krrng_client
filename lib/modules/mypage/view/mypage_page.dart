import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/modules/authentication/signin/view/signin_screen.dart';
import 'package:krrng_client/modules/faq/page/faq_screen.dart';
import 'package:krrng_client/modules/invite/page/invite_screen.dart';
import 'package:krrng_client/modules/mypage/components/sub_menu.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:krrng_client/modules/notice/view/notice_screen.dart';
import 'package:krrng_client/modules/pet_register/view/pet_register_screen.dart';
import 'package:krrng_client/modules/point/page/point_screen.dart';
import 'package:krrng_client/modules/profile_change/view/profile_change_screen.dart';
import 'package:krrng_client/modules/settings/view/setting_screen.dart';
import 'package:krrng_client/repositories/authentication_repository/authentication_repository.dart';
import 'package:vrouter/vrouter.dart';
import '../components/main_menu.dart';
import '../components/level_info.dart';

class MyPagePage extends StatefulWidget {
  @override
  State<MyPagePage> createState() => _MyPagePageState();
}

class _MyPagePageState extends State<MyPagePage> {
  late AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
  }

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
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, authState) {
            if (authState.status == AuthenticationStatus.authenticated) {
              return Column(children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 21),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Text(authState.user.nickname!,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                      overflow: TextOverflow.ellipsis))),
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
                                Image.asset(
                                  'assets/images/level1.png',
                                  width: 20,
                                ),
                                Text('씨앗단계', style: TextStyle(fontSize: 14)),
                                SizedBox(width: 6),
                                Icon(Icons.info_outline,
                                    size: 20, color: Colors.grey)
                              ]))
                        ])),
                if (authState.user.animals!.isNotEmpty)
                  Container(
                      height: 112,
                      width: double.maxFinite,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: authState.user.animals!.length,
                          itemBuilder: (context, index) {
                            var birthday = authState
                                .user.animals![index].birthday
                                .toString();
                            var year = int.parse(birthday.split('-')[0]);
                            var nowYear = DateTime.now().year;
                            var age = (nowYear - year + 1).toString();

                            return buildAnimalTile(
                                authState, index, age, context);
                          })),
                if (authState.user.animals!.isEmpty)
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 16),
                      child: GestureDetector(
                          onTap: () =>
                              context.vRouter.to(PetRegisterScreen.routeName),
                          child: Image.asset("assets/images/mainbanner.png")))
              ]);
            }
            return Column(
              children: [
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
                            GestureDetector(
                                onTap: () =>
                                    context.vRouter.to(SigninScreen.routeName),
                                child: Text('로그인',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900,
                                        color: Theme.of(context).accentColor,
                                        decoration: TextDecoration.underline)))
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
                                Icon(Icons.info_outline,
                                    size: 20, color: Colors.grey)
                              ]))
                        ])),
              ],
            );
          }),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 36, vertical: 30),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MainMenu(
                        iconPath: 'assets/icons/point.svg',
                        title: '포인트',
                        onTap: () => _authenticationBloc.state.status ==
                                AuthenticationStatus.authenticated
                            ? context.vRouter.to(PointScreen.routeName)
                            : showLoginNeededDialog(context)),
                    MainMenu(
                        onTap: () => showOnProgressDialog(context),
                        iconPath: 'assets/icons/favorite.svg',
                        title: '찜 목록'),
                    MainMenu(
                        onTap: () => showOnProgressDialog(context),
                        iconPath: 'assets/icons/order.svg',
                        title: '주문 목록')
                  ])),
          Container(
              width: double.maxFinite, height: 12, color: Color(0xFFF3F3F3)),
          SubMenu(
              title: '친구초대',
              onTap: () => context.vRouter.to(InviteScreen.routeName)),
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
              onTap: () => _authenticationBloc.state.status ==
                      AuthenticationStatus.authenticated
                  ? context.vRouter.to(ProfileChangeScreen.routeName)
                  : showLoginNeededDialog(context))
        ]))));
  }

  Future<dynamic> showOnProgressDialog(BuildContext context) {
    return showDialog(
        useRootNavigator: false,
        context: context,
        builder: (context) {
          return AlertDialog(title: const Text("준비 중입니다."), actions: [
            MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("확인")),
          ]);
        });
  }

  Future<dynamic> showLoginNeededDialog(BuildContext context) {
    return showDialog(
        useRootNavigator: false,
        context: context,
        builder: (context) {
          return AlertDialog(title: const Text("로그인이 필요합니다."), actions: [
            MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("확인")),
          ]);
        });
  }

  GestureDetector buildAnimalTile(AuthenticationState authState, int index,
      String age, BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Color(0xFFDFE2E9)),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(authState
                                        .user.animals![index].image ??
                                    'https://github.com/cheonhyeonjin/krrng/blob/main/default_image.png?raw=true')))),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text.rich(
                              TextSpan(children: [
                                TextSpan(
                                    text: authState.user.animals![index].name!),
                                TextSpan(
                                    text: '(${age}세)',
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor))
                              ]),
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w900)),
                          Text(
                            authState.user.animals![index].kind.toString(),
                            style: TextStyle(fontSize: 15),
                          ),
                          Row(children: [
                            Text(
                                authState.user.animals![index].sexChoices ==
                                        'MA'
                                    ? '남'
                                    : '여',
                                style: TextStyle(fontSize: 15)),
                            Container(
                                width: 1,
                                height: 10,
                                color: Colors.grey,
                                margin: EdgeInsets.symmetric(horizontal: 5)),
                            Text(
                              authState.user.animals![index].weight!,
                              style: TextStyle(fontSize: 15),
                            )
                          ])
                        ])
                  ]),
                  Icon(Icons.edit, size: 20, color: Colors.black26)
                ]),
            width: MediaQuery.of(context).size.width * 0.85,
            padding: EdgeInsets.all(20),
            height: 110,
            margin: EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Color(0xFFDFE2E9)))));
  }
}

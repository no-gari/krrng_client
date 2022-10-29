import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krrng_client/modules/mypage/view/mypage_screen.dart';
import 'package:krrng_client/modules/notification/view/notification_screen.dart';
import 'package:krrng_client/modules/pet_register/view/pet_register_screen.dart';
import 'package:krrng_client/modules/search/view/search_screen.dart';
import 'package:krrng_client/modules/search_result/view/search_result_screen.dart';
import 'package:vrouter/vrouter.dart';
import '../components/menus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: SvgPicture.asset('assets/icons/logo_text.svg',
                height: 19, fit: BoxFit.scaleDown),
            actions: [
              GestureDetector(
                  onTap: () => context.vRouter.to(SearchScreen.routeName),
                  child: SvgPicture.asset('assets/icons/search_icon.svg')),
              SizedBox(width: 20),
              GestureDetector(
                  onTap: () => context.vRouter.to(NotificationScreen.routeName),
                  child: SvgPicture.asset('assets/icons/noti_icon.svg')),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () => context.vRouter.to(MyPageScreen.routeName),
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset('assets/images/default_image.png')),
              ),
              SizedBox(width: 16)
            ]),
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () =>
                              context.vRouter.to(PetRegisterScreen.routeName),
                          child: Image.asset("assets/images/mainbanner.png")),
                      SizedBox(height: 50),
                      Text.rich(TextSpan(
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(text: '내 주변 동물병원\n'),
                            TextSpan(text: '진료비를 검색해 보세요'),
                          ])),
                      SizedBox(height: 15),
                      Row(children: [
                        Expanded(
                            child: Container(
                                height: 44,
                                child: TextField(
                                    textAlignVertical: TextAlignVertical.center,
                                    textInputAction: TextInputAction.go,
                                    onSubmitted: (value) {
                                      if (value.trim() != '') {
                                        // context.vRouter.toNamed('/search_result',
                                        //     pathParameters: {
                                        //       'keyword': _textEditingController.text
                                        //     });
                                        _textEditingController.clear();
                                      }
                                    },
                                    autofocus: true,
                                    controller: _textEditingController,
                                    decoration: InputDecoration(
                                        isCollapsed: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: BorderSide(
                                                color: Color(0xFFDFE2E9))),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                color: Color(0xFFDFE2E9))),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: BorderSide(
                                                color: Color(0xFFDFE2E9))),
                                        hintText: '중성화 수술',
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                        suffixIcon: IconButton(
                                            icon: SvgPicture.asset(
                                                'assets/icons/search_icon.svg',
                                                color: Colors.grey),
                                            color: Colors.black,
                                            onPressed: () =>
                                                _textEditingController.clear()))))),
                        SizedBox(width: 10),
                        SizedBox(width: 10),
                        GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SearchResultScreen())),
                            child: Container(
                                alignment: Alignment.center,
                                width: 93,
                                height: 44,
                                child: Text('검색하기',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.circular(15))))
                      ]),
                      SizedBox(height: 40),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 19),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Menu(
                                  iconPath: 'assets/icons/24hour.svg',
                                  title: '24시 진료'),
                              Menu(
                                  iconPath: 'assets/icons/eye.svg',
                                  title: '안과 진료'),
                              Menu(
                                  iconPath: 'assets/icons/skin.svg',
                                  title: '피부진료'),
                              Menu(
                                  iconPath: 'assets/icons/stomache.svg',
                                  title: '소화기관'),
                            ]),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 19, vertical: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Menu(
                                  iconPath: 'assets/icons/lungs.svg',
                                  title: '호흡기'),
                              Menu(
                                  iconPath: 'assets/icons/tooth.svg',
                                  title: '치과 전문'),
                              Menu(
                                  iconPath: 'assets/icons/brain.svg',
                                  title: '정신(뇌)'),
                              Menu(
                                  iconPath: 'assets/icons/korean_hospital.svg',
                                  title: '한의원'),
                            ]),
                      ),
                      SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {},
                        child:
                            Image.asset('assets/images/home_screen_banner.png'),
                      )
                    ]))));
  }
}

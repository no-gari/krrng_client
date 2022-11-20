import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/ads_request/view/ads_request_screen.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/modules/delete_account/delete_account_screen.dart';
import 'package:krrng_client/modules/mypage/components/sub_menu.dart';
import 'package:flutter/material.dart';
import 'package:krrng_client/modules/terms_of_use/personal_info_screen.dart';
import 'package:krrng_client/modules/terms_of_use/terms_of_use_screen.dart';
import 'package:krrng_client/modules/version_info/page/version_info_screen.dart';
import 'package:vrouter/vrouter.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  late AuthenticationBloc _authenticationBloc;

  final textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: Text('설정', style: Theme.of(context).textTheme.headline2)),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          buildProfileSetting(textEditingController: textEditingController),
          Container(
              height: 0.5, width: double.maxFinite, color: Colors.black12),
          SubMenu(
              title: '제휴 및 광고 문의',
              onTap: () => context.vRouter.to(AdsRequestScreen.routeName)),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 0.5,
              width: double.maxFinite,
              color: Colors.black12),
          SubMenu(title: '서비스 문의'),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 0.5,
              width: double.maxFinite,
              color: Colors.black12),
          SubMenu(
              title: '버전 정보',
              onTap: () => context.vRouter.to(VersionInfoScreen.routeName)),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 0.5,
              width: double.maxFinite,
              color: Colors.black12),
          // SubMenu(title: '오픈 라이선스'),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 0.5,
              width: double.maxFinite,
              color: Colors.black12),
          SubMenu(
              title: '이용약관',
              onTap: () => context.vRouter.to(TermsOfUseScreen.routeName)),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 0.5,
              width: double.maxFinite,
              color: Colors.black12),
          SubMenu(
              title: '개인정보 및 취급방침',
              onTap: () => context.vRouter.to(PersonalInfoScreen.routeName)),
          // Container(
          //     margin: EdgeInsets.symmetric(horizontal: 16),
          //     height: 0.5,
          //     width: double.maxFinite,
          //     color: Colors.black12),
          // SubMenu(title: '마케팅 수신 동의'),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                GestureDetector(
                    onTap: () =>
                        context.vRouter.to(DeleteAccountScreen.routeName),
                    child: Text('회원탈퇴',
                        style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline))),
                Container(
                    width: 1,
                    color: Colors.black12,
                    height: 12,
                    margin: EdgeInsets.symmetric(horizontal: 20)),
                GestureDetector(
                    onTap: () {
                      _authenticationBloc.add(AuthenticationLogoutRequested());
                      context.vRouter.to('/');
                    },
                    child: Text('로그아웃',
                        style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline))),
              ]))
        ]))));
  }
}

class buildProfileSetting extends StatelessWidget {
  const buildProfileSetting({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('아이디', style: Theme.of(context).textTheme.headline4),
          SizedBox(height: 10),
          Text('nogariii',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 30),
          Text('비밀번호', style: Theme.of(context).textTheme.headline4),
          SizedBox(height: 10),
          Row(children: [
            Expanded(
                child: Container(
                    height: 44,
                    child: TextField(
                        onSubmitted: (value) {},
                        obscureText: true,
                        autofocus: true,
                        controller: textEditingController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide:
                                    BorderSide(color: Color(0xFFDFE2E9))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: Color(0xFFDFE2E9))),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide:
                                    BorderSide(color: Color(0xFFDFE2E9))))))),
            SizedBox(width: 10),
            GestureDetector(
                onTap: () {},
                child: Container(
                    height: 44,
                    padding: EdgeInsets.symmetric(horizontal: 17),
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(15)),
                    alignment: Alignment.center,
                    child: Text('수정',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.white))))
          ])
        ]));
  }
}

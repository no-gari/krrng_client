import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/ads_request/view/ads_request_screen.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/modules/authentication/signin/cubit/signin_cubit.dart';
import 'package:krrng_client/modules/delete_account/delete_account_screen.dart';
import 'package:krrng_client/modules/mypage/components/sub_menu.dart';
import 'package:flutter/material.dart';
import 'package:krrng_client/modules/terms_of_use/personal_info_screen.dart';
import 'package:krrng_client/modules/terms_of_use/terms_of_use_screen.dart';
import 'package:krrng_client/modules/version_info/page/version_info_screen.dart';
import 'package:krrng_client/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:vrouter/vrouter.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late AuthenticationBloc _authenticationBloc;
  late SignInCubit _signInCubit;

  final textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _signInCubit = BlocProvider.of<SignInCubit>(context);
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
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, authState) {
            if (authState.status == AuthenticationStatus.authenticated)
              return buildProfileSetting(
                  signInCubit: _signInCubit,
                  textEditingController: textEditingController,
                  authState: authState);
            return Container();
          }),
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
          // SubMenu(title: '마케팅 수신 동의'),웃
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, authState) {
            if (authState.status == AuthenticationStatus.authenticated)
              return Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () => context.vRouter
                                .to(DeleteAccountScreen.routeName),
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
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                        title: const Text("로그아웃 하시겠습니까?"),
                                        actions: [
                                          MaterialButton(
                                              onPressed: () {
                                                RepositoryProvider.of<
                                                            AuthenticationRepository>(
                                                        context)
                                                    .logOut();
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                              child: const Text("확인"))
                                        ]);
                                  });
                            },
                            child: Text('로그아웃',
                                style: TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.underline))),
                      ]));
            return Container();
          })
        ]))));
  }
}

class buildProfileSetting extends StatelessWidget {
  const buildProfileSetting(
      {Key? key,
      required this.textEditingController,
      required this.signInCubit,
      required this.authState})
      : super(key: key);

  final TextEditingController textEditingController;
  final AuthenticationState authState;
  final SignInCubit signInCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('닉네임', style: Theme.of(context).textTheme.headline4),
          SizedBox(height: 10),
          Text(authState.user.nickname.toString(),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          if (!authState.user.email!.endsWith('kakao.com') &&
              !authState.user.email!.endsWith('icloud.com'))
            SizedBox(height: 30),
          if (!authState.user.email!.endsWith('kakao.com') &&
              !authState.user.email!.endsWith('icloud.com'))
            Text('비밀번호', style: Theme.of(context).textTheme.headline4),
          if (!authState.user.email!.endsWith('kakao.com') &&
              !authState.user.email!.endsWith('icloud.com'))
            SizedBox(height: 10),
          if (!authState.user.email!.endsWith('kakao.com') &&
              !authState.user.email!.endsWith('icloud.com'))
            Row(children: [
              Expanded(
                  child: Container(
                      height: 44,
                      child: TextField(
                          // onSubmitted: (value) {},
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
                  onTap: () {
                    if (textEditingController.text.trim() == '') {
                    } else {
                      signInCubit.updatePasswordSetting(
                          password: textEditingController.text);
                      textEditingController.clear();
                      showDialog(
                          context: context,
                          barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                          builder: (BuildContext context) {
                            return AlertDialog(
                                content: Text("비밀번호가 변경되었습니다."),
                                insetPadding:
                                    const EdgeInsets.fromLTRB(0, 80, 0, 80),
                                actions: [
                                  TextButton(
                                      child: const Text('확인'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      })
                                ]);
                          });
                    }
                  },
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

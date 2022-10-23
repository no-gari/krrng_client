import 'package:flutter/material.dart';
import 'package:krrng_client/modules/main/main_screen.dart';
import 'package:vrouter/vrouter.dart';

class DeleteAccountResultScreen extends StatelessWidget {
  static const String routeName = '/delete-account-result';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
              SizedBox(height: 30),
              Text('회원탈퇴\n신청이 완료되었습니다.',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center),
              SizedBox(height: 10),
              Text('(탈퇴 신청 날짜 : 2022-11-11)', style: TextStyle(fontSize: 14)),
              SizedBox(height: 15),
              Text('14일 이내 재로그인 시 탈퇴회원복구 절차를\n진행하실 수 있습니다.',
                  style: TextStyle(fontSize: 14), textAlign: TextAlign.center),
              SizedBox(height: 70),
              Image.asset('assets/images/account_delete.png')
            ])))),
        bottomNavigationBar: GestureDetector(
            onTap: () => context.vRouter.to(MainScreen.routeName),
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black38, width: 1))),
                height: 75,
                child: Text('완료',
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Theme.of(context).accentColor)))));
  }
}

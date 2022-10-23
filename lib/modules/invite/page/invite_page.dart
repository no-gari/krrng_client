import 'package:flutter/material.dart';

class InvitePage extends StatefulWidget {
  const InvitePage({Key? key}) : super(key: key);

  @override
  State<InvitePage> createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
              Center(
                  child: Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 10),
                      child: Text('지금 크르릉이 필요한\n친구들을 초대해보세요.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w900)))),
              Text('앱을 공유하고 위치기반으로 주변 동물병원\n병원비를 저렴하게 사용할 수 있다고 알려주세요',
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
              SizedBox(height: 50),
              Image.asset('assets/images/invite.png')
            ]))));
  }
}

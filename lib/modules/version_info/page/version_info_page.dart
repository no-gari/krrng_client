import 'package:flutter/material.dart';

class VersionInfoPage extends StatefulWidget {
  const VersionInfoPage({Key? key}) : super(key: key);

  @override
  State<VersionInfoPage> createState() => _VersionInfoPageState();
}

class _VersionInfoPageState extends State<VersionInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: Text('버전 정보', style: Theme.of(context).textTheme.headline2)),
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Center(child: Image.asset('assets/images/version_info.png')),
              SizedBox(height: 60),
              Center(
                  child: Text('현재 최신 버전을 사용 중입니다.',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
              SizedBox(height: 10),
              Center(
                  child: Text('현재 버전 1.1',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w900)))
            ])));
  }
}

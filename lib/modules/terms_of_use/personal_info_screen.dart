import 'package:flutter/material.dart';

class PersonalInfoScreen extends StatelessWidget {
  static const String routeName = '/personal-info';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:
                Text('개인정보 처리방침', style: Theme.of(context).textTheme.headline2),
            centerTitle: false),
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Container())));
  }
}

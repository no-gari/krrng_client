import 'package:flutter/material.dart';

class TermsOfUseScreen extends StatelessWidget {
  static const String routeName = '/terms-of-use';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('이용 약관', style: Theme.of(context).textTheme.headline2),
            centerTitle: false),
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Container())));
  }
}

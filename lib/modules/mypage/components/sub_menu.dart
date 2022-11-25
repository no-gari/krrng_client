import 'package:flutter/material.dart';

class SubMenu extends StatelessWidget {
  SubMenu({this.onTap, this.title});

  final String? title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            alignment: Alignment.center,
            child: Row(children: [
              Text(title!, style: Theme.of(context).textTheme.headline4),
              Spacer(),
              Icon(Icons.arrow_forward_ios, size: 15)
            ])));
  }
}

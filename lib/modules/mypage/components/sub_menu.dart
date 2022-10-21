import 'package:flutter/material.dart';

class SubMenu extends StatelessWidget {
  SubMenu({this.onTap, this.title});

  final String? title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            alignment: Alignment.center,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title!, style: Theme.of(context).textTheme.headline4),
                  Icon(Icons.arrow_forward_ios, size: 15)
                ])));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Menu extends StatelessWidget {
  Menu({this.iconPath, this.title, this.onTap});

  final String? title;
  final String? iconPath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
          onTap: onTap,
          child: SvgPicture.asset(iconPath!, width: 50, height: 50)),
      Text(title!)
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainMenu extends StatelessWidget {
  MainMenu({this.iconPath, this.title, this.onTap});

  final String? iconPath;
  final String? title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Column(children: [
          SvgPicture.asset(iconPath!),
          SizedBox(height: 10),
          Text(title!, style: Theme.of(context).textTheme.headline5)
        ]));
  }
}

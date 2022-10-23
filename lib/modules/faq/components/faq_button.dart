import 'package:flutter/material.dart';

class FaqButton extends StatelessWidget {
  FaqButton({this.title, this.isSelected});

  final String? title;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
            margin: EdgeInsets.only(right: 7, bottom: 10),
            padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                    color: isSelected!
                        ? Theme.of(context).backgroundColor
                        : Colors.black12),
                color: isSelected!
                    ? Theme.of(context).backgroundColor
                    : Colors.white),
            height: 38,
            child: Text(title!,
                style: isSelected!
                    ? Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Theme.of(context).accentColor)
                    : TextStyle(fontSize: 16))),
      ],
    );
  }
}

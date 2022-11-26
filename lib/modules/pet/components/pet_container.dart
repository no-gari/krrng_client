import 'package:flutter/material.dart';

class PetContainer extends StatelessWidget {
  PetContainer({this.path, this.title, this.isSelected, this.onTap});

  final String? path;
  final String? title;
  final bool? isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: (MediaQuery.of(context).size.width - 52) / 3,
          height: 120,
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(path!),
            SizedBox(height: 10),
            Text(title!)
          ]),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: !isSelected!
                      ? Colors.black12
                      : Theme.of(context).accentColor))),
    );
  }
}

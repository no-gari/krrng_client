import 'package:flutter/material.dart';

class RecentSearchTile extends StatelessWidget {
  RecentSearchTile({this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 7),
        padding: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.black12)),
        height: 36,
        child: Wrap(children: [
          SizedBox(width: 15),
          Text(title!, style: TextStyle(fontSize: 14)),
          SizedBox(width: 6),
          GestureDetector(
              onTap: () {},
              child: Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(Icons.close, size: 13, color: Colors.grey))),
          SizedBox(width: 15)
        ]));
  }
}

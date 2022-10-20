import 'package:flutter/material.dart';

class HotSearchTile extends StatelessWidget {
  HotSearchTile({this.leading, this.title});

  final String? leading;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
              child: Text(leading!,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor)),
              radius: 12,
              backgroundColor: Color(0xFFF2EFF6)),
          SizedBox(width: 10),
          Text(title!,
              style: TextStyle(
                fontSize: 14,
              )),
        ],
      ),
    );
  }
}

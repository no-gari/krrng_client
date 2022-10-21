import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:flutter/material.dart';

class NotificationCell extends StatelessWidget {
  NotificationCell(
      {this.index, this.sort, this.title, this.time, this.content});

  final int? index;
  final String? sort;
  final String? title;
  final String? time;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
        key: ObjectKey(index),
        trailingActions: <SwipeAction>[
          SwipeAction(
              title: "삭제",
              onTap: (CompletionHandler handler) async {
                // list.removeAt(index);
                // setState(() {});
              },
              color: Theme.of(context).accentColor)
        ],
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).backgroundColor),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      alignment: Alignment.center,
                      child: Text(sort!)),
                  SizedBox(width: 10),
                  Text(title!,
                      style: Theme.of(context).textTheme.headline4,
                      overflow: TextOverflow.ellipsis)
                ]),
                Text(time!, style: TextStyle(fontSize: 14, color: Colors.grey))
              ]),
              SizedBox(height: 10),
              Text(content!, style: TextStyle(fontSize: 14))
            ])));
  }
}

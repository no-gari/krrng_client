import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:flutter/material.dart';
import 'package:krrng_client/modules/notification/cubit/notification_cubit.dart';

class NotificationCell extends StatelessWidget {
  NotificationCell(
      {this.notiCubit,
      this.index,
      this.sort,
      this.title,
      this.time,
      this.content});

  final NotificationCubit? notiCubit;
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
                notiCubit!.deleteNotification(index!);
              },
              color: Theme.of(context).accentColor)
        ],
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              Text(content!,
                  style: TextStyle(fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis)
            ])));
  }
}

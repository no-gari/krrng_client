import 'package:flutter/material.dart';
import 'package:krrng_client/modules/notification/components/notification_cell.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: Text(
              '알림함',
              style: Theme.of(context).textTheme.headline2,
            )),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          SizedBox(height: 10),
          buildNotificationHeader(context),
          NotificationCell(
              index: 1,
              sort: '공지',
              title: '크르릉 업데이트 안내',
              time: '1시간 전',
              content:
                  '20202002020년 1010100101월 까지 업데이트 어쩌구 저쩌구 할 예정입니다. 알아서 잘 피하십쇼.'),
          NotificationCell(
              index: 1,
              sort: '공지',
              title: '크르릉 업데이트 안내',
              time: '1시간 전',
              content:
                  '20202002020년 1010100101월 까지 업데이트 어쩌구 저쩌구 할 예정입니다. 알아서 잘 피하십쇼.'),
          NotificationCell(
              index: 1,
              sort: '공지',
              title: '크르릉 업데이트 안내',
              time: '1시간 전',
              content:
                  '20202002020년 1010100101월 까지 업데이트 어쩌구 저쩌구 할 예정입니다. 알아서 잘 피하십쇼.'),
        ]))));
  }

  Container buildNotificationHeader(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Image.asset('assets/images/head.png', width: 40),
                SizedBox(width: 10.5),
                Text('알림을 ON/OFF 할 수 있습니다.', style: TextStyle(fontSize: 13))
              ]),
              Switch(
                  value: _switchValue,
                  onChanged: (value) => setState(() => _switchValue = value))
            ]));
  }
}

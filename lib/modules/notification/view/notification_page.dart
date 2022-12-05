import 'package:krrng_client/modules/notification/components/notification_cell.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/modules/notification/cubit/notification_cubit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late NotificationCubit _notificationCubit;
  late AuthenticationBloc _authenticationBloc;

  bool? status;

  @override
  void initState() {
    super.initState();
    _notificationCubit = BlocProvider.of<NotificationCubit>(context);
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _notificationCubit.getNotificationList();
    checkPermission();
    Future.delayed(const Duration(milliseconds: 500),
        () => _notificationCubit.readAllNotiifications());
  }

  checkPermission() async {
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      setState(() {
        status = accepted;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: Text('알림함', style: Theme.of(context).textTheme.headline2)),
        body: BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
          if (state.isLoaded == true &&
              state.notificationList != null &&
              status != null) {
            var notiList = state.notificationList;

            return SafeArea(
                child: SingleChildScrollView(
                    child: Column(children: [
              SizedBox(height: 10),
              buildNotificationHeader(context),
              for (var noti in notiList!)
                NotificationCell(
                    notiCubit: _notificationCubit,
                    index: noti.id,
                    sort: noti.sort,
                    title: noti.title,
                    time: '${noti.timesince} 전',
                    content: noti.content)
            ])));
          }
          return Center(
              child: Image.asset('assets/images/indicator.gif',
                  width: 100, height: 100));
        }));
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
                  value: status!,
                  onChanged: (value) {
                    setState(() {
                      status = value;
                    });

                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              content: Text("권한 설정을 확인해주세요."),
                              actions: [
                                TextButton(
                                    onPressed: () => openAppSettings(),
                                    child: Text('설정하기')),
                              ]);
                        });
                  })
            ]));
  }
}

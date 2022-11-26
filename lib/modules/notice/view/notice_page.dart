import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/notice/cubit/notice_cubit.dart';
import 'package:krrng_client/repositories/notice_repository/models/notice.dart';

class NoticePage extends StatefulWidget {
  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  late NoticeCubit _noticeCubit;

  @override
  void initState() {
    super.initState();
    _noticeCubit = BlocProvider.of<NoticeCubit>(context);
    _noticeCubit.getNoticeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: Text('공지사항', style: Theme.of(context).textTheme.headline2)),
        body: SafeArea(child: BlocBuilder<NoticeCubit, NoticeState>(
            builder: (context, noticeState) {
          if (noticeState.isLoaded == true) {
            var noticeList = noticeState.noticeList!.toList();

            return SingleChildScrollView(
                child: Column(children: [
              ExpansionPanelList(
                  dividerColor: Colors.black12,
                  elevation: 0,
                  expansionCallback: (int index, bool isExpanded) =>
                      setState(() => noticeState.noticeList![index] = Notice(
                            !isExpanded,
                            noticeList[index].name,
                            noticeList[index].content,
                            noticeList[index].createdAt,
                          )),
                  children: noticeList.map<ExpansionPanel>((Notice notice) {
                    return ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                  title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Text('공지',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .accentColor)),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Theme.of(context)
                                                    .backgroundColor)),
                                        SizedBox(width: 10),
                                        Expanded(
                                            child: Text(notice.name!,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w900)))
                                      ]),
                                  subtitle: Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(notice.createdAt!,
                                          style: TextStyle(fontSize: 14)))));
                        },
                        body: Container(
                            padding: EdgeInsets.only(
                                bottom: 10, left: 16, right: 16),
                            alignment: Alignment.centerLeft,
                            child: Text(notice.content!,
                                style: TextStyle(fontSize: 14))),
                        isExpanded: notice.isExpanded!);
                  }).toList())
            ]));
          }
          return Center(
              child: Image.asset('assets/images/indicator.gif',
                  width: 100, height: 100));
        })));
  }
}

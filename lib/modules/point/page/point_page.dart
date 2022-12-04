import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/point/cubit/point_cubit.dart';
import 'package:krrng_client/repositories/point_repository/models/point.dart';
import 'package:krrng_client/support/style/format_unit.dart';
import '../components/point_button.dart';

class PointPage extends StatefulWidget {
  const PointPage({Key? key}) : super(key: key);

  @override
  State<PointPage> createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {
  late PointCubit _pointCubit;

  int _selectedIndex = 0;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _pointCubit = BlocProvider.of<PointCubit>(context);
    _pointCubit.getPointList('old');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title:
                Text('포인트 관리', style: Theme.of(context).textTheme.headline2)),
        body: SafeArea(child:
            BlocBuilder<PointCubit, PointState>(builder: (context, pointState) {
          if (pointState.isLoaded == true) {
            var pointList = pointState.pointList!.toList();

            return SingleChildScrollView(
                child: Column(children: [
              Container(
                  width: double.maxFinite,
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 40),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Color(0xFFDFE2E9), width: 1))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text('보유 포인트', style: TextStyle(fontSize: 14)),
                              SizedBox(height: 10),
                              Text('${pointState.totalPoint}P',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                      color: Theme.of(context).accentColor)),
                              SizedBox(height: 20),
                              Row(children: [
                                PointButton(
                                    title: '최신순',
                                    isSelected: _selectedIndex == 0,
                                    onTap: () => setState(() {
                                          _selectedIndex = 0;
                                          _pointCubit.getPointList('old');
                                        })),
                                PointButton(
                                    title: '과거순',
                                    isSelected: _selectedIndex == 1,
                                    onTap: () => setState(() {
                                          _selectedIndex = 1;
                                          _pointCubit.getPointList('recent');
                                        }))
                              ])
                            ])),
                        Image.asset('assets/images/point.png')
                      ])),
              ExpansionPanelList(
                  dividerColor: Colors.black12,
                  elevation: 0,
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() => pointState.pointList![index] = Point(
                          pointList[index].id,
                          pointList[index].amount,
                          !isExpanded,
                          pointList[index].title,
                          pointList[index].reason,
                          pointList[index].createdAt,
                        ));
                    print(isExpanded);
                  },
                  children: pointList.map<ExpansionPanel>((Point point) {
                    return ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Container(
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 20),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(point.title!,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(height: 8),
                                          Text(point.createdAt!,
                                              style: TextStyle(fontSize: 14))
                                        ]),
                                    Row(children: [
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: point.amount! >= 0
                                                  ? Theme.of(context)
                                                      .backgroundColor
                                                  : Color(0xFFFFF1F1)),
                                          height: 24,
                                          child: Text(
                                              point.amount! >= 0 ? '적립' : '차감',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: point.amount! >= 0
                                                      ? Theme.of(context)
                                                          .accentColor
                                                      : Color(0xFFF85757)))),
                                      SizedBox(width: 6),
                                      Text(
                                          currencyFromString(
                                              point.amount.toString()),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900,
                                              color: point.amount! >= 0
                                                  ? Theme.of(context)
                                                      .accentColor
                                                  : Color(0xFFF85757)))
                                    ])
                                  ]));
                        },
                        body: Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black12, width: 0.5),
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xFFFBFBFB)),
                            child: Text(
                              point.reason!,
                              style: TextStyle(fontSize: 14),
                            )),
                        isExpanded: point.isExpanded!);
                  }).toList())
            ]));
          }
          return Center(
              child: Image.asset('assets/images/indicator.gif',
                  width: 100, height: 100));
        })));
  }
}

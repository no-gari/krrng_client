import 'package:flutter/material.dart';

import 'search_filter_button.dart';

class SearchFilter extends StatefulWidget {
  const SearchFilter({Key? key}) : super(key: key);

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  int _selectedOrderIndex = 0;
  int _selectedHospitalIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: MediaQuery(
            data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
            child: SafeArea(
                child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('필터 설정',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2),
                                    GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Icon(Icons.close))
                                  ])),
                          Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).backgroundColor,
                                  borderRadius: BorderRadius.circular(12)),
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 10),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Image.asset('assets/images/head.png',
                                          width: 40),
                                      SizedBox(width: 10.5),
                                      Text('설정 옵션에 따라 동물병원이 노출됩니다.',
                                          style: TextStyle(fontSize: 13))
                                    ])
                                  ])),
                          SizedBox(height: 30),
                          Text('기준',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w900)),
                          Wrap(children: [
                            SearchFilterButton(
                                title: '거리순',
                                isSelected: _selectedOrderIndex == 0,
                                onTap: () =>
                                    setState(() => _selectedOrderIndex = 0)),
                            SearchFilterButton(
                                title: '가격순',
                                isSelected: _selectedOrderIndex == 1,
                                onTap: () =>
                                    setState(() => _selectedOrderIndex = 1)),
                            SearchFilterButton(
                                title: '애정온도순',
                                isSelected: _selectedOrderIndex == 2,
                                onTap: () =>
                                    setState(() => _selectedOrderIndex = 2)),
                            SearchFilterButton(
                                title: '리뷰순',
                                isSelected: _selectedOrderIndex == 3,
                                onTap: () =>
                                    setState(() => _selectedOrderIndex = 3))
                          ]),
                          SizedBox(height: 60),
                          Text('특화 분야',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w900)),
                          Wrap(children: [
                            SearchFilterButton(
                                title: '24시 진료',
                                isSelected: _selectedHospitalIndex == 0,
                                onTap: () =>
                                    setState(() => _selectedHospitalIndex = 0)),
                            SearchFilterButton(
                                title: '안과진료',
                                isSelected: _selectedHospitalIndex == 0,
                                onTap: () =>
                                    setState(() => _selectedHospitalIndex = 0)),
                            SearchFilterButton(
                                title: '피부진료',
                                isSelected: _selectedHospitalIndex == 1,
                                onTap: () =>
                                    setState(() => _selectedHospitalIndex = 1)),
                            SearchFilterButton(
                                title: '소화기관',
                                isSelected: _selectedHospitalIndex == 2,
                                onTap: () =>
                                    setState(() => _selectedHospitalIndex = 2)),
                            SearchFilterButton(
                                title: '호흡기',
                                isSelected: _selectedHospitalIndex == 3,
                                onTap: () =>
                                    setState(() => _selectedHospitalIndex = 3)),
                            SearchFilterButton(
                                title: '치과 전문',
                                isSelected: _selectedHospitalIndex == 4,
                                onTap: () =>
                                    setState(() => _selectedHospitalIndex = 4)),
                            SearchFilterButton(
                                title: '정신(뇌)',
                                isSelected: _selectedHospitalIndex == 5,
                                onTap: () =>
                                    setState(() => _selectedHospitalIndex = 5)),
                            SearchFilterButton(
                                title: '한의원',
                                isSelected: _selectedHospitalIndex == 5,
                                onTap: () =>
                                    setState(() => _selectedHospitalIndex = 5))
                          ])
                        ])))));
  }
}

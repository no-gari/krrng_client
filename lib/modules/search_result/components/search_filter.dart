import 'package:flutter/material.dart';
import 'package:krrng_client/modules/hospital/cubit/hospital_cubit.dart';
import 'package:krrng_client/repositories/hospital_repository/models/enums.dart';

import 'search_filter_button.dart';

class SearchFilter extends StatefulWidget {
  SearchFilter({this.hospitalCubit, this.keyword});

  final HospitalCubit? hospitalCubit;
  final String? keyword;

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  int _selectedOrderIndex = 0;
  int _selectedHospitalIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedOrderIndex =
        HospitalFilter.getIndex(widget.hospitalCubit!.state.selectedFilter!);
    _selectedHospitalIndex =
        HospitalPart.getIndex(widget.hospitalCubit!.state.selectedPart!);
  }

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
                          Wrap(
                              children: List.generate(
                                  HospitalFilter.values.length,
                                  (index) => SearchFilterButton(
                                      title: HospitalFilter.values[index].title,
                                      isSelected: _selectedOrderIndex == index,
                                      onTap: () {
                                        setState(
                                            () => _selectedOrderIndex = index);
                                        widget.hospitalCubit!.emit(widget
                                            .hospitalCubit!.state
                                            .copyWith(
                                                selectedFilter: HospitalFilter
                                                    .values[index]));
                                        if (widget.keyword != null) {
                                          widget.hospitalCubit!
                                              .hospitalSearch(widget.keyword!);
                                        } else {
                                          widget.hospitalCubit!
                                              .getHosipitals(0);
                                        }
                                      }))),
                          SizedBox(height: 60),
                          Text('특화 분야',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w900)),
                          Wrap(
                              children: List.generate(
                                  HospitalPart.values.length,
                                  (index) => SearchFilterButton(
                                      title: HospitalPart.values[index].title,
                                      isSelected:
                                          _selectedHospitalIndex == index,
                                      onTap: () {
                                        setState(() =>
                                            _selectedHospitalIndex = index);
                                        widget.hospitalCubit!.emit(widget
                                            .hospitalCubit!.state
                                            .copyWith(
                                                selectedPart: HospitalPart
                                                    .values[index]));
                                        if (widget.keyword != null) {
                                          widget.hospitalCubit!
                                              .hospitalSearch(widget.keyword!);
                                        } else {
                                          widget.hospitalCubit!
                                              .getHosipitals(0);
                                        }
                                      })))
                        ])))));
  }
}

import 'package:krrng_client/modules/hospital_detail/view/hospital_detail_screen.dart';
import 'package:krrng_client/modules/hospital_search/view/hospital_search_screen.dart';
import 'package:krrng_client/modules/search_result/components/hospital_tile.dart';
import 'package:krrng_client/repositories/disease_repository/models/disease.dart';
import 'package:krrng_client/repositories/hospital_repository/models/models.dart';
import 'package:krrng_client/modules/hospital/cubit/hospital_cubit.dart';
import 'package:krrng_client/modules/disease/cubit/disease_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:krrng_client/support/style/format_unit.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:krrng_client/support/style/theme.dart';
import 'package:label_marker/label_marker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';
import 'dart:async';

class HospitalSearchPage extends StatefulWidget {
  HospitalSearchPage({this.disease, this.fromMap});

  final int? disease;
  final bool? fromMap;

  static const String routeName = "/hospital/search";

  @override
  State<HospitalSearchPage> createState() => _HospitalSearchPageState();
}

class _HospitalSearchPageState extends State<HospitalSearchPage> {
  final _textEditingController = TextEditingController();

  Set<Marker> _markers = {};
  List<Disease> _diseaseList = [];

  WidgetsToImageController imageController = WidgetsToImageController();
  var _focused = false;

  late GoogleMapController _naver;
  late double height;
  late FocusNode _focusNode;

  late HospitalCubit _hospitalCubit;
  late DiseaseCubit _diseaseCubit;

  bool isLast = false;

  @override
  void initState() {
    super.initState();
    _hospitalCubit = BlocProvider.of<HospitalCubit>(context);
    _diseaseCubit = BlocProvider.of<DiseaseCubit>(context);
    _hospitalCubit.getHosipitals(widget.disease!);
    _hospitalCubit.emit(_hospitalCubit.state.copyWith(isMap: false));
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    _naver.dispose();
    super.dispose();
  }

  void startAddMarker(hospital, last) async {
    addMarker(hospital, last);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;

    return Scaffold(body:
        BlocBuilder<HospitalCubit, HospitalState>(builder: (context, state) {
      if (state.hospitals != null &&
          state.isLoaded == true &&
          state.hospitals!.length != 0) {
        var first_hospital = state.hospitals!.first;
        var last_hospital = state.hospitals!.last;
        final hospitals = state.hospitals;

        if (isLast == false) {
          for (var hospital in state.hospitals!) {
            Timer(Duration(milliseconds: 0),
                () => startAddMarker(hospital, hospital == last_hospital));
          }
        }

        return SlidingUpPanel(
            minHeight: 200,
            borderRadius: BorderRadius.circular(25),
            maxHeight: height * 0.5,
            panel: Container(
                padding: EdgeInsets.fromLTRB(20, 18, 20, 24),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(children: [
                  Container(
                      height: 24,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              SvgPicture.asset('assets/icons/positioning.svg',
                                  width: 13, height: 13, color: primaryColor),
                              SizedBox(width: 4),
                              Text("${state.realAddressDetail}",
                                  style: font_16_w700)
                            ]),
                            Text("${hospitals!.length}개 검색 결과",
                                style: font_14_w500)
                          ])),
                  Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(children: [
                        Container(
                            margin: EdgeInsets.only(right: 7, top: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 17, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: dividerColor),
                                color: Colors.white),
                            height: 38,
                            child: DropdownButton<String>(
                                borderRadius: BorderRadius.circular(18.0),
                                dropdownColor: Colors.white,
                                icon: Icon(Icons.keyboard_arrow_down_outlined,
                                    size: 14, color: Colors.black12),
                                value: state.selectedFilter?.title,
                                elevation: 8,
                                underline: SizedBox.shrink(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                items: HospitalFilter.values
                                    .map((e) => e.title)
                                    .toList()
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    _hospitalCubit.selectedFilter(value);
                                    _hospitalCubit
                                        .getHosipitals(widget.disease!);
                                  }
                                })),
                        Container(
                            margin: EdgeInsets.only(right: 7, top: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 17, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: dividerColor),
                                color: Colors.white),
                            height: 38,
                            child: DropdownButton<String>(
                                borderRadius: BorderRadius.circular(18.0),
                                dropdownColor: Colors.white,
                                value: state.selectedPart?.title,
                                elevation: 8,
                                icon: Icon(Icons.keyboard_arrow_down_outlined,
                                    size: 14, color: Colors.black12),
                                underline: SizedBox.shrink(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                items: HospitalPart.values
                                    .map((e) => e.title)
                                    .toList()
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    _hospitalCubit.selectedPart(value);
                                    _hospitalCubit
                                        .getHosipitals(widget.disease!);
                                  }
                                }))
                      ])),
                  Expanded(
                      child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemCount: hospitals.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  final latitude = double.parse(
                                      hospitals[index].latitude ?? "0");
                                  final longitude = double.parse(
                                      hospitals[index].longitude ?? "0");

                                  _naver.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                              target:
                                                  LatLng(latitude, longitude),
                                              zoom: 17)));
                                },
                                child: HospitalTile(
                                    name: hospitals[index].name,
                                    location:
                                        "${hospitals[index].address} ${hospitals[index].addressDetail}",
                                    price: hospitals[index].price,
                                    image: hospitals[index].image,
                                    temperature:
                                        hospitals[index].recommend!.toDouble(),
                                    reviews: hospitals[index].reviewCount,
                                    howFar: hospitals[index].distance));
                          },
                          separatorBuilder: (BuildContext ctx, int idx) =>
                              Divider(height: 15, color: dividerColor)))
                ])),
            body: Column(children: [
              Container(
                  height: height,
                  child: Stack(children: [
                    Container(
                        height: height - 190,
                        child: GoogleMap(
                            myLocationButtonEnabled: false,
                            markers: _markers,
                            onTap: (latlng) => disableFocus(),
                            onMapCreated: (controller) {
                              this._naver = controller;
                            },
                            initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    double.parse(first_hospital.latitude!),
                                    double.parse(first_hospital.longitude!)),
                                zoom: 15))),
                    SafeArea(
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18),
                            child: Container(
                                child: TextField(
                                    focusNode: _focusNode,
                                    textInputAction: TextInputAction.go,
                                    onSubmitted: (value) => disableFocus(),
                                    onTap: () => requestFocus(),
                                    autofocus: true,
                                    onChanged: (value) {
                                      _diseaseCubit
                                          .getDiseaseList(value)
                                          .then((_) => setState(() {
                                                _diseaseList = _diseaseCubit
                                                    .state.disease!;
                                              }));
                                    },
                                    controller: _textEditingController,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        icon: GestureDetector(
                                            onTap: () {
                                              if (widget.fromMap == true) {
                                                _hospitalCubit.emit(
                                                    _hospitalCubit.state
                                                        .copyWith(isMap: true));
                                              }
                                              Navigator.of(context).pop();
                                            },
                                            child: Icon(Icons.arrow_back_ios,
                                                color: Colors.black)),
                                        isCollapsed: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: BorderSide(
                                                color: Color(0xFFDFE2E9))),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                color: Color(0xFFDFE2E9))),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: BorderSide(
                                                color: Color(0xFFDFE2E9))),
                                        hintText: '검색어를 입력하세요.',
                                        suffixIcon: Container(
                                            width: 66,
                                            child: Row(children: [
                                              GestureDetector(
                                                  onTap: () =>
                                                      _textEditingController
                                                          .clear(),
                                                  child: CircleAvatar(
                                                      radius: 9,
                                                      backgroundColor:
                                                          Colors.black12,
                                                      child: Icon(Icons.close,
                                                          color: Colors.white,
                                                          size: 12))),
                                              IconButton(
                                                  icon: SvgPicture.asset(
                                                      'assets/icons/search_icon.svg',
                                                      width: 20),
                                                  color: Colors.black,
                                                  onPressed: () {
                                                    requestFocus();
                                                    _diseaseCubit
                                                        .getDiseaseList(
                                                            _textEditingController
                                                                .text)
                                                        .then(
                                                            (_) => setState(() {
                                                                  _diseaseList =
                                                                      _diseaseCubit
                                                                          .state
                                                                          .disease!;
                                                                }));
                                                  })
                                            ]))))))),
                    SafeArea(
                        child: Padding(
                            padding:
                                EdgeInsets.only(left: 16, right: 16, top: 50),
                            child: Column(children: [
                              SizedBox(height: 10),
                              if (_focused == true)
                                buildDiseaseList(context, state)
                            ]))),
                  ]))
            ]));
      } else if (state.hospitals != null &&
          state.isLoaded == true &&
          state.hospitals!.length == 0) {
        return Scaffold(
            appBar: AppBar(automaticallyImplyLeading: true),
            body: Center(child: Text('검색 결과가 없습니다.')));
      }
      return Center(
          child: Image.asset('assets/images/indicator.gif',
              width: 100, height: 100));
    }));
  }

  void addMarker(Hospital hospital, bool last) async {
    setState(() {
      _markers.addLabelMarker(LabelMarker(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => HospitalDetailScreen(id: hospital.id))),
          markerId: MarkerId(hospital.id.toString()),
          position: LatLng(double.parse(hospital.latitude!),
              double.parse(hospital.longitude!)),
          label: hospital.name.toString() +
              '\n' +
              currencyFromStringWon(hospital.price.toString()),
          backgroundColor: Theme.of(context).primaryColor,
          textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white),
          anchor: Offset(0.5, 0.7)));
    });
    if (last == true) {
      setState(() {
        isLast = true;
      });
    }
  }

  void disableFocus() {
    _focusNode.unfocus();
    setState(() {
      _focused = false;
    });
  }

  void requestFocus() {
    _focusNode.requestFocus();
    setState(() {
      _focused = true;
    });
  }

  Container buildDiseaseList(BuildContext context, HospitalState state) {
    return Container(
        constraints: BoxConstraints(maxHeight: 100),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
            child: Column(children: [
          for (var disease in _diseaseList)
            ListTile(
                title: Text(disease.name!),
                dense: true,
                onTap: () => context.vRouter.toNamed(
                        HospitalSearchScreen.routeName,
                        pathParameters: {
                          'disease': disease.id.toString(),
                          'fromMap': 'false'
                        }))
        ])));
  }
}

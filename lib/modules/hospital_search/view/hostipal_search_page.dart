import 'package:krrng_client/modules/hospital_detail/view/hospital_detail_screen.dart';
import 'package:krrng_client/modules/search_result/components/hospital_tile.dart';
import 'package:krrng_client/repositories/hospital_repository/models/models.dart';
import 'package:krrng_client/modules/search_result/components/search_bar.dart';
import 'package:krrng_client/modules/hospital/cubit/hospital_cubit.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:krrng_client/support/style/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HospitalSearchPage extends StatefulWidget {
  HospitalSearchPage({this.disease});

  final int? disease;

  static const String routeName = "/hospital/search";

  @override
  State<HospitalSearchPage> createState() => _HospitalSearchPageState();
}

class _HospitalSearchPageState extends State<HospitalSearchPage> {
  final _textEditingController = TextEditingController();

  List<Marker> _markers = [];
  List<Widget> _markersForByte = [];
  WidgetsToImageController imageController = WidgetsToImageController();
  late NaverMapController _naver;
  late double height;

  late HospitalCubit _hospitalCubit;

  @override
  void initState() {
    super.initState();
    _hospitalCubit = BlocProvider.of<HospitalCubit>(context);
    _hospitalCubit.getHosipitals(widget.disease!);
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: BlocBuilder<HospitalCubit, HospitalState>(
            buildWhen: (previous, current) {
      return current.hospitals != null;
    }, builder: (context, state) {
      final hospitals = state.hospitals;
      if (hospitals == null) {
        return Center(
            child: Image.asset('assets/images/indicator.gif',
                width: 100, height: 100));
      } else {
        for (var hospital in state.hospitals!) {
          addMarker(hospital);
        }

        return Column(children: [
          Container(
              height: height / 2,
              child: Stack(children: [
                NaverMap(
                    markers: _markers,
                    locationButtonEnable: false,
                    onMapCreated: (controller) {
                      var first_hospital = state.hospitals!.first;

                      this._naver = controller;
                      _naver.moveCamera(
                          CameraUpdate.toCameraPosition(CameraPosition(
                              target: LatLng(
                                  double.parse(first_hospital.latitude!),
                                  double.parse(first_hospital.longitude!)))),
                          animationDuration: 1000);
                    },
                    onCameraChange: (latLng, reason, isAnimated) {
                      // print("${latLng} ${reason} ${isAnimated}");
                    }),
                SafeArea(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Container(
                            child: SearchBar(
                                textEditingController:
                                    _textEditingController))))
              ])),
          Container(
              height: height / 2,
              padding: EdgeInsets.fromLTRB(20, 18, 20, 24),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
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
                            Text("${state.addressDetail}", style: font_16_w700)
                          ]),
                          Text("${hospitals.length}개 검색 결과",
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
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

                                _naver.moveCamera(
                                    CameraUpdate.toCameraPosition(
                                        CameraPosition(
                                            target:
                                                LatLng(latitude, longitude))),
                                    animationDuration: 1000);
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
              ]))
        ]);
      }
    }));
  }

  void addMarker(Hospital hospital) async {
    var overlayImage =
        await OverlayImage.fromAssetImage(assetName: 'assets/images/head.png');

    _markers.add(Marker(
      onMarkerTab: (marker, value) => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => HospitalDetailScreen(id: hospital.id))),
      markerId: DateTime.now().toIso8601String() + hospital.id.toString(),
      position: LatLng(
          double.parse(hospital.latitude!), double.parse(hospital.longitude!)),
      captionText: hospital.name,
      captionColor: Colors.indigo,
      captionTextSize: 12.0,
      alpha: 0.8,
      captionOffset: -30,
      icon: overlayImage,
      anchor: AnchorPoint(0.5, 1),
      width: 100,
      height: 100,
      // infoWindow: hospital.name,
    ));
  }
}

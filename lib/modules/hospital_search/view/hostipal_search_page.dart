import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krrng_client/modules/hospital/cubit/hospital_cubit.dart';
import 'package:krrng_client/modules/hospital_search/hospital_marker_widget.dart';
import 'package:krrng_client/modules/search_result/components/hospital_tile.dart';
import 'package:krrng_client/modules/search_result/components/search_bar.dart';
import 'package:krrng_client/modules/search_result/components/search_filter_button.dart';
import 'package:krrng_client/repositories/hospital_repository/models/models.dart';
import 'package:krrng_client/support/style/theme.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class HospitalSearchPage extends StatefulWidget {
  const HospitalSearchPage({Key? key}) : super(key: key);

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
    _hospitalCubit.getHosipitals();
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
        },
        builder: (context, state) {
          final hospitals = state.hospitals;
          if (hospitals == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            test(hospitals);
            print("(_markers.isEmpty ${_markers.isEmpty} hospital ${hospitals.isEmpty}");
            return Column(
              children: [
                Container(
                  height: height/2,
                  child: Stack(
                    children: [
                      NaverMap(
                        markers: _markers,
                        locationButtonEnable: false,
                        onMapCreated: (controller) {
                          this._naver = controller;
                        },
                        onCameraChange: (latLng, reason, isAnimated) {
                          print("${latLng} ${reason} ${isAnimated}");
                        },
                      ),
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: Container(
                              child: SearchBar(textEditingController: _textEditingController)
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    height: height/2,
                    padding: EdgeInsets.fromLTRB(20, 18, 20, 24),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child:
                    Column(
                      children: [
                        Container(height: 24, child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset('assets/icons/positioning.svg', width: 13, height: 13, color: primaryColor),
                                  SizedBox(width: 4),
                                  Text("${state.addressDetail}", style: font_16_w700),
                                ],
                              ),
                              Text("${hospitals.length+1}개 검색 결과", style: font_16_w700)
                            ])),
                        Container(padding: EdgeInsets.only(top: 20),
                          // color: Colors.red,
                          child: Row(
                            children: [
                            Container(
                            margin: EdgeInsets.only(right: 7, top: 10),
                            padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: dividerColor),
                                color: Colors.white
                            ),
                            height: 38,
                            child: DropdownButton<String>(
                                borderRadius: BorderRadius.circular(18.0),
                                dropdownColor: Colors.white,
                                value: state.selectedFilter?.title,
                                elevation: 8,
                                underline: SizedBox.shrink(),
                                style: TextStyle(color: Colors.black),
                                items: HospitalFilter.values.map((e) => e.title).toList().map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    _hospitalCubit.selectedFilter(value);
                                  }
                                },
                              ),
                            ),
                              Container(
                                margin: EdgeInsets.only(right: 7, top: 10),
                                padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(color: dividerColor),
                                    color: Colors.white
                                ),
                                height: 38,
                                child: DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(18.0),
                                  dropdownColor: Colors.white,
                                  value: state.selectedPart?.title,
                                  elevation: 8,
                                  underline: SizedBox.shrink(),
                                  style: TextStyle(color: Colors.black),
                                  items: HospitalPart.values.map((e) => e.title).toList().map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      _hospitalCubit.selectedPart(value);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: ListView.separated(
                          padding: EdgeInsets.zero,
                            itemCount: hospitals.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  final latitude = double.parse(hospitals[index].latitude ?? "0");
                                  final longitude = double.parse(hospitals[index].longitude ?? "0");

                                  _naver.moveCamera(CameraUpdate.toCameraPosition(
                                      CameraPosition(target: LatLng(latitude, longitude))),
                                      animationDuration: 1000
                                  );
                                },
                                child: HospitalTile(
                                    name: hospitals[index].name,
                                    location: "${hospitals[index].address} ${hospitals[index].addressDetail}",
                                    price: hospitals[index].price,
                                    image: hospitals[index].image,
                                    temperature: hospitals[index].recommend!.toDouble(),
                                    reviews: hospitals[index].reviewCount,
                                    howFar: hospitals[index].distance),
                              );
                            },
                            separatorBuilder: (BuildContext ctx, int idx) => Divider(height: 15, color: dividerColor)
                        )),
                      ],
                    )
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<void> test(List<Hospital> hospitals) async {
    this._markersForByte = List.generate(hospitals.length,
            (index) => WidgetsToImage(
          controller: imageController,
          child: HospitalMarker(hospital: hospitals[index]),
        )).toList();

    final bytes = await imageController.capture();
    var overlayImage = OverlayImage.fromByteArray(bytes!);

    final transform = hospitals.map((e) {
      final latitude = double.parse(e.latitude ?? "0");
      final longitude = double.parse(e.longitude ?? "0");

      return Marker(
        markerId: e.id.toString(),
        position: LatLng(latitude, longitude),
        icon: overlayImage,
      );
    }).toList();

    setState(() {
      _markers = transform;
    });

    print(transform);

    print("_markers.isNotEmpty && _naver != null");
    this._naver.moveCamera(CameraUpdate.toCameraPosition(
        CameraPosition(target: _markers.first.position!)),
        animationDuration: 1000
    );
  }
}
import 'package:flutter_svg/svg.dart';
import 'package:krrng_client/modules/disease/cubit/disease_cubit.dart';
import 'package:krrng_client/modules/hospital_search/view/hostipal_search_page.dart';
import 'package:krrng_client/modules/search/cubit/recent_search_cubit.dart';
import 'package:krrng_client/modules/hospital/cubit/hospital_cubit.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:krrng_client/repositories/disease_repository/models/disease.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:krrng_client/support/style/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class HospitalPage extends StatefulWidget {
  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  List<Marker> _markers = [];
  List<Disease> _diseaseList = [];
  WidgetsToImageController imageController = WidgetsToImageController();
  NaverMapController? _naver;
  LatLng? latlng;

  String? place;

  final _textEditingController = TextEditingController();
  bool _focused = false;

  late FocusNode _focusNode;
  late HospitalCubit _hospitalCubit;
  late RecentSearchCubit _recentSearchCubit;
  late DiseaseCubit _diseaseCubit;

  @override
  void initState() {
    super.initState();
    _diseaseCubit = BlocProvider.of<DiseaseCubit>(context);
    _hospitalCubit = BlocProvider.of<HospitalCubit>(context);
    _recentSearchCubit = BlocProvider.of<RecentSearchCubit>(context);
    _hospitalCubit.currentPosition();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<HospitalCubit, HospitalState>(
            listenWhen: ((previous, current) =>
                previous.location != current.location),
            listener: (context, state) {
              final location = state.location;
              if (location != null) {
                _onDrawMarket(location);
              }
            },
            builder: (context, state) {
              if (state.isLoaded ?? false) {
                place = state.currentPlace;

                return Stack(children: [
                  WidgetsToImage(
                      controller: imageController,
                      child: Container(
                        height: (place!.length / 10).round() * 38,
                        child: Column(
                          children: [
                            Container(
                              width: 175,
                              height: (place!.length / 10).round() * 38 - 24,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 9, horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                        width: 13,
                                        height: 13,
                                        alignment: Alignment.topCenter,
                                        child: SvgPicture.asset(
                                            'assets/icons/positioning.svg')),
                                    SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        place!,
                                        style: font_14_w700.copyWith(
                                            color: Colors.white),
                                        softWrap: true,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_drop_down, color: primaryColor)
                          ],
                        ),
                      )),
                  NaverMap(
                      markers: _markers,
                      initLocationTrackingMode: LocationTrackingMode.Follow,
                      onMapCreated: (controller) {
                        this._naver = controller;
                      },
                      onCameraChange: (latLng, reason, isAnimated) {
                        if (latLng != null) {
                          latlng = latLng;
                        }
                        print("${latLng} ${reason} ${isAnimated}");
                      },
                      onCameraIdle: () {
                        if (latlng != null) {
                          _hospitalCubit.updatePosition(latlng!);
                          _hospitalCubit
                              .currentLocation(_hospitalCubit.state.location!);
                          _onDrawMarket(latlng!);
                          setState(() => place = state.currentPlace);
                        }
                      },
                      onMapTap: (latlng) => disableFocus()),
                  SafeArea(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(children: [
                            buildMainTextField(),
                            SizedBox(height: 10),
                            if (_focused == true)
                              buildDiseaseList(context, state)
                          ]))),
                  if (_focused == false) buildBottomBarWidget(context)
                ]);
              } else {
                return Center(
                    child:
                        Image.asset('assets/images/indicator.gif', width: 120));
              }
            }));
  }

  Positioned buildBottomBarWidget(BuildContext context) {
    return Positioned(
        bottom: 0,
        child: GestureDetector(
            onTap: () {
              _hospitalCubit.currentLocation(_hospitalCubit.state.location!);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("현재 위치가 설정되었습니다.")));
            },
            child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black12)),
                child: Text("현재 위치 재 설정",
                    style: font_17_w900.copyWith(color: primaryColor)))));
  }

  Container buildDiseaseList(BuildContext context, HospitalState state) {
    return Container(
        constraints: BoxConstraints(maxHeight: 215),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
            child: Column(children: [
          for (var disease in _diseaseList)
            ListTile(
                title: Text(disease.name!),
                dense: true,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                            value: _hospitalCubit,
                            child: HospitalSearchPage(disease: disease.id)))))
        ])));
  }

  TextField buildMainTextField() {
    return TextField(
        focusNode: _focusNode,
        textInputAction: TextInputAction.search,
        onChanged: (value) {
          _diseaseCubit.getDiseaseList(value).then((_) => setState(() {
                _diseaseList = _diseaseCubit.state.disease!;
              }));
        },
        onSubmitted: (value) => disableFocus(),
        onTap: () => requestFocus(),
        autofocus: false,
        controller: _textEditingController,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            icon: null,
            isCollapsed: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: Color(0xFFDFE2E9))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Color(0xFFDFE2E9))),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: Color(0xFFDFE2E9))),
            fillColor: Colors.white,
            filled: true,
            hintText: '증상을 검색하세요.',
            suffixIcon: Container(
                width: 66,
                child: Row(children: [
                  GestureDetector(
                      onTap: () => _textEditingController.clear(),
                      child: CircleAvatar(
                          radius: 9,
                          backgroundColor: Colors.black12,
                          child: Icon(Icons.close,
                              color: Colors.white, size: 12))),
                  IconButton(
                      icon: SvgPicture.asset('assets/icons/search_icon.svg',
                          width: 20),
                      color: Colors.black,
                      onPressed: () {
                        requestFocus();
                        _diseaseCubit
                            .getDiseaseList(_textEditingController.text)
                            .then((_) => setState(() {
                                  _diseaseList = _diseaseCubit.state.disease!;
                                }));
                      })
                ]))));
  }

  Future<void> _onDrawMarket(LatLng latLng) async {
    final bytes = await imageController.capture();
    var overlayImage = OverlayImage.fromByteArray(bytes!);
    final place = _hospitalCubit.state.currentPlace ?? "";

    setState(() {
      _markers = [];
    });

    _markers.add(Marker(
        markerId: DateTime.now().toIso8601String(),
        position: latLng,
        icon: overlayImage,
        anchor: AnchorPoint(0.5, 1),
        width: 175,
        height: (place.length / 10).round() * 38));

    setState(() {});
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
}

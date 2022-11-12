import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:krrng_client/modules/hospital/cubit/hospital_cubit.dart';

class HospitalPage extends StatefulWidget {
  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  List<Marker> _markers = [];

  NaverMapController? _naver;
  late HospitalCubit _hospitalCubit;

  @override
  void initState() {
    super.initState();
    _hospitalCubit = BlocProvider.of<HospitalCubit>(context);
    _hospitalCubit.setPosition();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HospitalCubit, HospitalState>( builder: (context, state) {
      if (state.isLoaded ?? false) {
        return NaverMap(
          markers: [
            Marker(
                markerId: DateTime.now().toIso8601String(),
                position: state.location!,
                captionText: "현재 위치",
                captionColor: Colors.indigo,
                captionTextSize: 20.0,
                alpha: 0.8,
                captionOffset: 30,
                anchor: AnchorPoint(0.5, 1),
                // icon: OverlayImage.fromAssetImage(assetName: 'assets/icons/marker.png')
                width: 45,
                height: 45,
                infoWindow: state.currentPlace,
                onMarkerTab: _onMarkerTap)
          ],
          initLocationTrackingMode: LocationTrackingMode.Follow,
          onMapCreated: (controller) {
            this._naver = controller;
          },
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }

  // ================== method ==========================
  void _onMarkerTap(Marker? marker, Map<String, int?> iconSize) {
    int pos = _markers.indexWhere((m) => m.markerId == marker?.markerId);
    setState(() {
      this._markers[pos].captionText = '선택됨';
      var position = this._markers[pos].position;
      this._naver?.moveCamera(CameraUpdate.scrollTo(position!));
    });
  }

}

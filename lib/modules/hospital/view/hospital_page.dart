import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:krrng_client/modules/hospital/cubit/hospital_cubit.dart';
import 'package:krrng_client/modules/hospital_search/view/hostipal_search_page.dart';
import 'package:krrng_client/support/style/theme.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../widget_marker.dart';

class HospitalPage extends StatefulWidget {
  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  List<Marker> _markers = [];
  WidgetsToImageController imageController = WidgetsToImageController();
  NaverMapController? _naver;

  late HospitalCubit _hospitalCubit;

  @override
  void initState() {
    super.initState();
    _hospitalCubit = BlocProvider.of<HospitalCubit>(context);
    _hospitalCubit.currentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: GestureDetector(
        onTap: ()  {
          _hospitalCubit.currentLocation(_hospitalCubit.state.location!);
          _hospitalCubit.getHosipitals();
          Navigator.push(context,
            MaterialPageRoute(
                builder: (_) => BlocProvider.value(value: _hospitalCubit, child: HospitalSearchPage(),)
            ),
          );
        },
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black12)),
          child: Text("현재 위치 재 설정", style: font_17_w900.copyWith(color: primaryColor)),
        ),
      ),
      body: BlocConsumer<HospitalCubit, HospitalState>(
        listenWhen: ((previous, current) => previous.location != current.location),
        listener: (context, state) {
          final location = state.location;
          if (location != null) {
            _onDrawMarket(location);
          }
        },
          builder: (context, state) {
        if (state.isLoaded ?? false) {
          return Stack(
            children: [
              WidgetsToImage(
                controller: imageController,
                child: WidgetMarker(place: state.currentPlace!),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
              ),
              NaverMap(
                  markers: _markers,
                  initLocationTrackingMode: LocationTrackingMode.Follow,
                  onMapCreated: (controller) {
                    this._naver = controller;
                  },
                  onCameraChange: (latLng, reason, isAnimated) {
                    if (latLng != null) {
                      _hospitalCubit.updatePosition(latLng);
                    }
                    print("${latLng} ${reason} ${isAnimated}");
                  },
              ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
    );
  }

  Future<void> _onDrawMarket(LatLng latLng) async {
    final bytes = await imageController.capture();
    var overlayImage = OverlayImage.fromByteArray(bytes!);
    final place = _hospitalCubit.state.currentPlace ?? "";

    _markers = [];
    _markers.add(Marker(
      markerId: DateTime.now().toIso8601String(),
      position: latLng,
      icon: overlayImage,
      anchor: AnchorPoint(0.5, 1),
      width: 175,
      height: (place.length/10).round() * 38 ,
    ));

    setState(() {});
  }

}
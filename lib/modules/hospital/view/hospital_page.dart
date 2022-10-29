import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class HospitalPage extends StatefulWidget {
  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final sampleList =
        "이 예제는 지도를 리스트뷰 위에서 사용할 때, Gesture를 Map에 우선적으로 전달하기 위한 경우를 위해 제공되는 예제입니다."
            .split(" ");

    return Scaffold(
        body: NaverMap(
      onCameraChange: (l, _, __) {
        print(l);
      },
      initialCameraPosition:
          CameraPosition(target: LatLng(37.5425, 126.9669), zoom: 17),
      initLocationTrackingMode: LocationTrackingMode.None,
      // forceGesture: true,
    ));
    ;
  }
}

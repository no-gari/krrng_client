import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krrng_client/support/style/theme.dart';

class WidgetMarker extends StatefulWidget {
  const WidgetMarker({Key? key, required this.place}) : super(key: key);
  final String place;

  @override
  State<WidgetMarker> createState() => _WidgetMarkerState(this.place);
}

class _WidgetMarkerState extends State<WidgetMarker> {
  _WidgetMarkerState(this.place);
  final String place;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (place.length/10).toInt() * 30 + 15,
      child: Column(
        children: [
          Container(
            width: 175,
            height: (place.length/10).toInt() * 25,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(width: 13, height: 13,
                      alignment: Alignment.topCenter,
                      child: SvgPicture.asset('assets/icons/positioning.svg')),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text('${this.place}',
                      style: font_14_w700.copyWith(color: Colors.white),
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
    );
  }
}
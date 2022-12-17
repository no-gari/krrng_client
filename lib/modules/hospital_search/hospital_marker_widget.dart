import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krrng_client/repositories/hospital_repository/models/models.dart';
import 'package:krrng_client/support/style/theme.dart';

class HospitalMarker extends StatefulWidget {
  const HospitalMarker({Key? key, required this.hospital}) : super(key: key);
  final Hospital hospital;

  @override
  State<HospitalMarker> createState() => _HospitalMarkerState(this.hospital);
}

class _HospitalMarkerState extends State<HospitalMarker> {
  _HospitalMarkerState(this.hospital);
  final Hospital hospital;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,// (hospital.address!.length/10).toInt() * 30 + 15,
      child: Column(
        children: [
          Container(
            width: 175,
            height: 200, //(hospital.address!.length/10).toInt() * 25,
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
                    child: Text('${this.hospital.address}',
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
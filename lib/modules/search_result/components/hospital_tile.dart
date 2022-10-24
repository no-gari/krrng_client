import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krrng_client/support/style/format_unit.dart';
import 'package:krrng_client/support/style/theme.dart';

class HospitalTile extends StatelessWidget {
  HospitalTile(
      {this.name,
      this.location,
      this.image,
      this.price,
      this.temperature,
      this.reviews,
      this.howFar});

  final String? name;
  final String? location;
  final String? image;
  final int? price;
  final int? temperature;
  final int? reviews;
  final int? howFar;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 155,
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name!,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      SizedBox(height: 6),
                      Text(location!,
                          style: TextStyle(fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      SizedBox(height: 8),
                      Text(currencyFromStringWon(price.toString()),
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: theme.accentColor)),
                      SizedBox(height: 8),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset('assets/icons/pet.svg'),
                            SizedBox(width: 4),
                            Text(
                                temperature.toString() +
                                    '°' +
                                    '(' +
                                    reviews.toString() +
                                    ')',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: theme.accentColor,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(width: 20),
                            SvgPicture.asset('assets/icons/pin_s.svg'),
                            Text(howFar!.toString() + 'm',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF999999)))
                          ])
                    ])),
                SizedBox(width: 20),
                Container(
                    height: 76,
                    width: 76,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(image!),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black12)))
              ])
        ]));
  }
}

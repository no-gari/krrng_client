import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../repositories/hospital_repository/models/image.dart'
    as LocalImage;
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';

class HospitalSwiper extends StatefulWidget {
  HospitalSwiper({this.imageList});

  final List<LocalImage.Image>? imageList;

  @override
  State<HospitalSwiper> createState() => _HospitalSwiperState();
}

class _HospitalSwiperState extends State<HospitalSwiper> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        width: double.maxFinite,
        child: Swiper(
            autoplay: false,
            pagination: SwiperPagination(
                alignment: Alignment.bottomRight,
                builder: HospitalDetailPaginationBuilder(
                    color: Colors.white,
                    activeColor: Colors.white,
                    fontSize: 12,
                    activeFontSize: 12)),
            scrollDirection: Axis.horizontal,
            onTap: (int index) {},
            itemBuilder: (BuildContext context, int index) =>
                CachedNetworkImage(
                    imageUrl: widget.imageList![index].image ?? '',
                    fit: BoxFit.cover),
            itemCount: widget.imageList!.length));
  }
}

class HospitalDetailPaginationBuilder extends SwiperPlugin {
  final Color? color;
  final Color? activeColor;
  final double fontSize;
  final double activeFontSize;
  final Key? key;

  const HospitalDetailPaginationBuilder(
      {this.color,
      this.fontSize: 20.0,
      this.key,
      this.activeColor,
      this.activeFontSize: 35.0});

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    ThemeData themeData = Theme.of(context);
    Color activeColor = this.activeColor ?? themeData.primaryColor;
    Color color = this.color ?? themeData.scaffoldBackgroundColor;

    if (Axis.vertical == config.scrollDirection) {
      return Column(
          key: key,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("${config.activeIndex + 1}",
                style: TextStyle(color: activeColor, fontSize: activeFontSize)),
            Text("/", style: TextStyle(color: color, fontSize: fontSize)),
            Text("${config.itemCount}",
                style: TextStyle(color: color, fontSize: fontSize))
          ]);
    } else {
      return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.black54),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child:
              Row(key: key, mainAxisSize: MainAxisSize.min, children: <Widget>[
            Text("${config.activeIndex + 1}",
                style: TextStyle(color: activeColor, fontSize: activeFontSize)),
            Text(" / ${config.itemCount}",
                style: TextStyle(color: color, fontSize: fontSize))
          ]));
    }
  }
}

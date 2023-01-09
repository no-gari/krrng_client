import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReviewTile extends StatefulWidget {
  ReviewTile(
      {this.name,
      this.rate,
      this.diagnosis,
      this.date,
      this.imageList,
      this.content,
      this.likes,
      this.isLike,
      required this.onTap});

  final String? name;
  final double? rate;
  final String? diagnosis;
  final String? date;
  final List<String?>? imageList;
  final String? content;
  final int? likes;
  final bool? isLike;
  final void Function() onTap;

  @override
  State<ReviewTile> createState() => _ReviewTileState();
}

class _ReviewTileState extends State<ReviewTile> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.name!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                Icon(Icons.favorite,
                    color: Theme.of(context).accentColor, size: 16),
                SizedBox(width: 8),
                Text(widget.rate!.toString(),
                    style: TextStyle(
                        fontSize: 16, color: Theme.of(context).accentColor)),
                Container(
                    height: 12,
                    width: 1,
                    color: Colors.black12,
                    margin: EdgeInsets.symmetric(horizontal: 10)),
                Text(widget.diagnosis!, style: TextStyle(fontSize: 15))
              ]),
              Padding(
                padding: EdgeInsets.only(right: 24.0),
                child: Text(widget.date!,
                    style: TextStyle(fontSize: 15, color: Colors.grey)),
              ),
            ]),
            SizedBox(height: 20),
            Container(
                height: 130,
                width: double.maxFinite,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.imageList!.length,
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      return Container(
                          height: 130,
                          width: 130,
                          margin: EdgeInsets.only(right: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      widget.imageList![index]!),
                                  fit: BoxFit.cover)));
                    })),
            SizedBox(height: 20),
            Text(widget.content!, style: TextStyle(fontSize: 15)),
            SizedBox(height: 20),
            Row(children: [
              SvgPicture.asset(widget.isLike == true
                  ? 'assets/icons/like_on.svg'
                  : 'assets/icons/like_off.svg'),
              SizedBox(width: 10),
              Text.rich(TextSpan(style: TextStyle(fontSize: 15), children: [
                TextSpan(
                    text: widget.likes!.toString() + '명이 ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor)),
                TextSpan(text: '이 리뷰를 좋아합니다.')
              ]))
            ])
          ])),
    );
  }
}

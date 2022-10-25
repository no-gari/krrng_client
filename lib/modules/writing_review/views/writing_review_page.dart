import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krrng_client/support/style/theme.dart';

class WritingReviewPage extends StatefulWidget {
  const WritingReviewPage({Key? key}) : super(key: key);

  @override
  State<WritingReviewPage> createState() => _WritingReviewPageState();
}

class _WritingReviewPageState extends State<WritingReviewPage> {


  @override
  Widget build(BuildContext context) {

    // TODO: state 값 주입
    return ListView(
      children: <Widget>[
        _HospitalProfileTile(),
        _Divier,
        _ReceivedMedical(),
        _Receipt(),
        _PostReview()
      ],
    );
  }

  Widget _HospitalProfileTile() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 127,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(flex: 2, child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("하늘 동물병원", style: font_22_w900),
              Text("서울 강남구 강남대로 117길 24 하늘빌딩 5층", style: font_15_w500),
            ],
          )),
          Flexible(child: Container(
              height: 76,
              width: 76,
              margin: EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png"
                      ),
                      fit: BoxFit.cover))))
        ],
      ),
    );
  }

  Widget _Divier = Container(color: listViewDividerColor, height: 12);

  Widget _ReceivedMedical() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("진료 항목", style: font_18_w900.copyWith(height: 1.5)),
          Text("해당 병원에서 진료 받으신 항목명을 입력해 주세요.", style: font_14_w500.copyWith(height: 1.5)),
          const SizedBox(height: 14),
          TextFormField(
              // controller: passwordController,
              obscureText: true,
              textAlignVertical: TextAlignVertical.center,
              decoration: baseInputDecoration('Ex : 내시경, 반려견 건강검진'))
        ],
      ),
    );
  }

  Widget _Receipt() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("영수증 첨부", style: font_18_w900.copyWith(height: 1.5)),
              const SizedBox(width: 6),
              GestureDetector(onTap: () => {}, child: SvgPicture.asset("assets/icons/report.svg", width: 20))
            ],
          ),
          Text("해당 병원에서 진료 받으신 영수증을 첨부해 주세요.", style: font_14_w500.copyWith(height: 1.5)),
          // 영수증 썸네일 리스트 뷰
          Container(
            margin: EdgeInsets.only(top: 14, bottom: 30),
            height: 85,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () => {},
                  child: Container(
                    width: 85,
                    decoration: thumbnailDecoration,
                    child: Icon(Icons.add, color: dividerColor),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _PostReview() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("리뷰 등록", style: font_18_w900.copyWith(height: 1.5)),
                  const SizedBox(width: 6),
                  GestureDetector(onTap: () => {}, child: SvgPicture.asset("assets/icons/report.svg", width: 20))
                ],
              ),
              Wrap(
                children: [
                  IconButton(onPressed: () => {}, icon: SvgPicture.asset("assets/icons/reviewOn.svg"), padding: EdgeInsets.zero, constraints: BoxConstraints(), iconSize: 30),
                  IconButton(onPressed: () => {}, icon: SvgPicture.asset("assets/icons/reviewOff.svg"), padding: EdgeInsets.zero, constraints: BoxConstraints(), iconSize: 30),
                  IconButton(onPressed: () => {}, icon: SvgPicture.asset("assets/icons/reviewOff.svg"), padding: EdgeInsets.zero, constraints: BoxConstraints(), iconSize: 30),
                  IconButton(onPressed: () => {}, icon: SvgPicture.asset("assets/icons/reviewOff.svg"), padding: EdgeInsets.zero, constraints: BoxConstraints(), iconSize: 30),
                  IconButton(onPressed: () => {}, icon: SvgPicture.asset("assets/icons/reviewOff.svg"), padding: EdgeInsets.zero, constraints: BoxConstraints(), iconSize: 30),
                ],
              )
            ],
          ),
          const SizedBox(height: 17),
          Container(
            child: Stack(
              children: [
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: baseInputDecoration("병원리뷰를 10자이상 입력해 주세요.\n(최대 500자)").copyWith(
                    contentPadding: EdgeInsets.fromLTRB(15, 14, 15, 44),
                    constraints: BoxConstraints(minHeight: 127), isCollapsed: false,
                  ),
                ),
                Positioned(bottom: 0, left: 0,
                    child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset("assets/icons/photo.svg")),
                      ],
                    )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
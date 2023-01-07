import 'package:flutter/material.dart';
import 'package:krrng_client/support/style/theme.dart';

enum ReviewNotice {
  receipt('영수증 첨부 안내'),
  hospital('병원 리뷰 등록 안내사항');

  const ReviewNotice(this.title);

  final String title;
}

class ReviewNoticePage extends StatelessWidget {
  const ReviewNoticePage({super.key, required this.code});

  final ReviewNotice code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            code == ReviewNotice.hospital ? Colors.white : listViewDividerColor,
        appBar: AppBar(
          title: Text(code.title, style: Theme.of(context).textTheme.headline2),
          centerTitle: false,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: code == ReviewNotice.hospital
                ? ReviewByHospital(context)
                : ReceiptGuide(context),
          ),
        ));
  }

  Widget ReviewByHospital(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: roundDecoration.copyWith(color: Color(0xfff2eff6)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/head.png', width: 38, height: 32),
                SizedBox(width: 10),
                Text("설정한 옵션에 따라 동물병원이 노출됩니다"),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
              "크르릉을 이용하는 이용자들에게 보다 정확한 정보를 안내하고 싶기 때문 리뷰 등록 후 관리자 검수가 진행됩니다.\n간혹 가격 정보가 정확하지 않거나 브로커 작성으로 "
              "의심되는 내용들로 인해 실제로 필요한 정보들을 찾기 어려운 경우가 있으셨을 거에요. \n\n"
              "따라서 크르릉은 후기에 입력한 병원에서 실제로 진료를 받았는지 안내한 비용과 청구받은 비용이 일치하는지 검수를 통해 확인 할 수 있습니다.\n\n"
              "여러분이 등록해주신 소중한 후기를 통해 보다 정확하고 신뢰있는 정보를 제공하겠습니다."),
        ],
      ),
    );
  }

  Widget ReceiptGuide(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(top: 35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              padding: EdgeInsets.only(bottom: 30),
              child: Image.asset('assets/images/receipt_guide.png',
                  width: 150,
                  height: MediaQuery.of(context).size.height * 0.7)),
          Text("직접 병원을 방문하지 않았거나, 내용을 확인할 수 없는 경우 포인트가 지급되지 않습니다.",
              style: font_14_w500.copyWith(color: primaryColor))
        ],
      ),
    );
  }
}

import 'package:flutter_svg/flutter_svg.dart';
import 'package:krrng_client/modules/hospital_detail/components/hospital_swiper.dart';
import 'package:flutter/material.dart';
import 'package:krrng_client/modules/hospital_detail/components/review_tile.dart';

import '../../../support/style/format_unit.dart';
import '../components/hospital_detail_button.dart';

class HospitalDetailPage extends StatefulWidget {
  const HospitalDetailPage({Key? key}) : super(key: key);

  @override
  State<HospitalDetailPage> createState() => _HospitalDetailPageState();
}

class _HospitalDetailPageState extends State<HospitalDetailPage> {
  final imageList = [
    'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png',
    'https://media.istockphoto.com/photos/canadian-rockies-banff-national-park-dramatic-landscape-picture-id1342152935?b=1&k=20&m=1342152935&s=170667a&w=0&h=q9-vhO5MC7zwaxX8_zFUiqMnQJ5udMjEBf0npeCCAGs=',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png',
    'https://media.istockphoto.com/photos/canadian-rockies-banff-national-park-dramatic-landscape-picture-id1342152935?b=1&k=20&m=1342152935&s=170667a&w=0&h=q9-vhO5MC7zwaxX8_zFUiqMnQJ5udMjEBf0npeCCAGs='
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              HospitalSwiper(imageList: imageList),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('하늘 동물 병원',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w900)),
                        SizedBox(height: 10),
                        Text('서울 강남구 강남대로 117길 24 하늘빌딩 5층',
                            style: TextStyle(fontSize: 15)),
                        SizedBox(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.favorite,
                                  color: Theme.of(context).accentColor,
                                  size: 16),
                              SizedBox(width: 5),
                              Text('4.2' + '(' + '100' + ')',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 10),
                              SvgPicture.asset('assets/icons/pin_s.svg',
                                  color: Theme.of(context).accentColor),
                              SizedBox(width: 5),
                              Text('31' + 'm',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).accentColor))
                            ]),
                        SizedBox(height: 16),
                        Row(children: [
                          Container(
                              width: 56,
                              child:
                                  Text('휴무일', style: TextStyle(fontSize: 15))),
                          Container(
                              height: 8,
                              width: 0.5,
                              color: Colors.black26,
                              margin: EdgeInsets.symmetric(horizontal: 8)),
                          Text('매주 월요일',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).accentColor))
                        ]),
                        SizedBox(height: 8),
                        Row(children: [
                          Container(
                              width: 56,
                              child:
                                  Text('영업시간', style: TextStyle(fontSize: 15))),
                          Container(
                              height: 8,
                              width: 0.5,
                              color: Colors.black26,
                              margin: EdgeInsets.symmetric(horizontal: 8)),
                          Text('매일 오전 10시 ~ 오후 8시 까지',
                              style: TextStyle(fontSize: 15))
                        ]),
                        SizedBox(height: 8),
                        Row(children: [
                          Container(
                              width: 56,
                              child:
                                  Text('전화번호', style: TextStyle(fontSize: 15))),
                          Container(
                              height: 8,
                              width: 0.5,
                              color: Colors.black26,
                              margin: EdgeInsets.symmetric(horizontal: 8)),
                          Text('02-1234-1234', style: TextStyle(fontSize: 15))
                        ]),
                        SizedBox(height: 20),
                        GestureDetector(
                            child: Container(
                                alignment: Alignment.center,
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Colors.black12)),
                                child: Text('병원 리뷰 등록하기',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).accentColor))))
                      ])),
              Container(
                  margin: EdgeInsets.only(bottom: 30),
                  width: double.maxFinite,
                  height: 12,
                  color: Color(0xFFF3F3F3)),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(width: 24),
                  HospitalDetailButton(
                      title: '병원 정보',
                      isSelected: _selectedIndex == 0,
                      onTap: () => setState(() => _selectedIndex = 0)),
                  HospitalDetailButton(
                      title: '진료비',
                      isSelected: _selectedIndex == 1,
                      onTap: () => setState(() => _selectedIndex = 1)),
                  HospitalDetailButton(
                      title: '리뷰 ' + '116',
                      isSelected: _selectedIndex == 2,
                      onTap: () => setState(() => _selectedIndex = 2)),
                ]),
                if (_selectedIndex == 0)
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: buildFirstPage(context)),
                if (_selectedIndex == 1)
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: buildSecondPage()),
                if (_selectedIndex == 2)
                  Padding(
                      padding: EdgeInsets.only(left: 24),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 5,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      right: 24, top: 10, bottom: 10),
                                  width: double.maxFinite,
                                  height: 1,
                                  color: index == 0
                                      ? Colors.white
                                      : Colors.black12),
                              ReviewTile(
                                  name: '하이하이하이',
                                  rate: 4.0,
                                  diagnosis: '내시경',
                                  date: '2022.09.13 12:55',
                                  imageList: imageList,
                                  content:
                                      '강아지가 아플때마다 자주 가는데 항상 친절하고 과잉진료 없이 잘 치료했습니다. 앞으로도 자주 방문 어쩌구',
                                  likes: 15,
                                  isLike: true)
                            ]);
                          })),
              ])
            ]))));
  }

  Container buildFirstPage(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('특화 분야',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Wrap(spacing: 20, children: [
            Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Wrap(children: [
                  CircleAvatar(
                      child: SvgPicture.asset('assets/icons/tooth.svg'),
                      backgroundColor: Theme.of(context).backgroundColor,
                      radius: 13),
                  SizedBox(width: 8),
                  Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text('치과 진료 특화', style: TextStyle(fontSize: 15)))
                ])),
            Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Wrap(children: [
                  CircleAvatar(
                      child: SvgPicture.asset('assets/icons/tooth.svg'),
                      backgroundColor: Theme.of(context).backgroundColor,
                      radius: 13),
                  SizedBox(width: 8),
                  Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text('치과 진료 특화', style: TextStyle(fontSize: 15)))
                ])),
            Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Wrap(children: [
                  CircleAvatar(
                      child: SvgPicture.asset('assets/icons/tooth.svg'),
                      backgroundColor: Theme.of(context).backgroundColor,
                      radius: 13),
                  SizedBox(width: 8),
                  Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text('치과 진료 특화', style: TextStyle(fontSize: 15)))
                ])),
          ]),
          SizedBox(height: 30),
          Text('진료 반려 동물',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('강아지, 고양이, 파충류', style: TextStyle(fontSize: 15)),
          SizedBox(height: 30),
          Text('소개글',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(
              '동물을 사랑하는 전 직원의 따뜻한 마음 하나하나가 모여 더 나은 지료 결과를 낳는다고 생각합니다. 최첨단 시스템과 의료진의 쉼 없는 노력으로 최고의 진료를 실현할 수 있도록 최손을 다하겠습니다.',
              style: TextStyle(fontSize: 15))
        ]));
  }

  Container buildSecondPage() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('진료 항목',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('노령 / 중증 질환 검사', style: TextStyle(fontSize: 15)),
                  Text(currencyFromStringWon(150000.toString()) + '~',
                      style: TextStyle(fontSize: 15))
                ]),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('노령 / 중증 질환 검사', style: TextStyle(fontSize: 15)),
                  Text(currencyFromStringWon(150000.toString()) + '~',
                      style: TextStyle(fontSize: 15))
                ]),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('노령 / 중증 질환 검사', style: TextStyle(fontSize: 15)),
                  Text(currencyFromStringWon(150000.toString()) + '~',
                      style: TextStyle(fontSize: 15))
                ]),
          ),
        ]));
  }
}

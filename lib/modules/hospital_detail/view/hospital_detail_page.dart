import 'package:krrng_client/repositories/hospital_repository/models/review_image.dart';
import 'package:krrng_client/modules/hospital_detail/components/hospital_swiper.dart';
import 'package:krrng_client/repositories/hospital_repository/models/best_part.dart';
import 'package:krrng_client/modules/hospital_detail/components/review_tile.dart';
import 'package:krrng_client/repositories/hospital_repository/models/review.dart';
import 'package:krrng_client/repositories/hospital_repository/models/price.dart';
import '../../../repositories/hospital_repository/models/available_animal.dart';
import 'package:krrng_client/modules/hospital/cubit/hospital_cubit.dart';
import 'package:krrng_client/modules/writing_review/views/views.dart';
import 'package:krrng_client/modules/review/review_detail_page.dart';
import '../components/hospital_detail_button.dart';
import '../../../support/style/format_unit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class HospitalDetailPage extends StatefulWidget {
  HospitalDetailPage({this.id});

  final int? id;

  @override
  State<HospitalDetailPage> createState() => _HospitalDetailPageState();
}

class _HospitalDetailPageState extends State<HospitalDetailPage> {
  late HospitalCubit _hospitalCubit;

  @override
  void initState() {
    super.initState();
    _hospitalCubit = BlocProvider.of<HospitalCubit>(context);
    _hospitalCubit.getHospitalDetail(widget.id!);
  }

  final imageList = [
    'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png',
    'https://media.istockphoto.com/photos/canadian-rockies-banff-national-park-dramatic-landscape-picture-id1342152935?b=1&k=20&m=1342152935&s=170667a&w=0&h=q9-vhO5MC7zwaxX8_zFUiqMnQJ5udMjEBf0npeCCAGs=',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png',
    'https://media.istockphoto.com/photos/canadian-rockies-banff-national-park-dramatic-landscape-picture-id1342152935?b=1&k=20&m=1342152935&s=170667a&w=0&h=q9-vhO5MC7zwaxX8_zFUiqMnQJ5udMjEBf0npeCCAGs='
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Review> testReivew = [
      Review(
        nickname: '하이하이하이',
        rates: 4,
        diagnosis: '내시경',
        createdAt: '2022.09.13 12:55',
        reviewImage: List<ReviewImage>.generate(imageList.length,
            (index) => ReviewImage(id: index + 1, image: imageList[index])),
        content: '강아지가 아플때마다 자주 가는데 항상 친절하고 과잉진료 없이 잘 치료했습니다. 앞으로도 자주 방문 어쩌구',
        likes: 15,
      )
    ];

    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(child: BlocBuilder<HospitalCubit, HospitalState>(
            builder: (context, state) {
          if (state.isLoaded == true) {
            var hospitalDetail = state.hospitalDetail;

            return SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  HospitalSwiper(imageList: hospitalDetail!.images),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(hospitalDetail!.name ?? '',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w900)),
                            SizedBox(height: 10),
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                    children: [
                                  TextSpan(text: hospitalDetail.address),
                                  TextSpan(text: ' '),
                                  TextSpan(text: hospitalDetail.addressDetail)
                                ])),
                            SizedBox(height: 20),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.favorite,
                                      color: Theme.of(context).accentColor,
                                      size: 16),
                                  SizedBox(width: 5),
                                  Text(
                                      hospitalDetail.rate.toString() +
                                          '(' +
                                          '${hospitalDetail.hospitalReview!.length.toString()}' +
                                          ')',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context).accentColor,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(width: 10),
                                  SvgPicture.asset('assets/icons/pin_s.svg',
                                      color: Theme.of(context).accentColor),
                                  SizedBox(width: 5),
                                  Text(hospitalDetail.distance.toString() + 'm',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).accentColor))
                                ]),
                            SizedBox(height: 16),
                            Row(children: [
                              Container(
                                  width: 56,
                                  child: Text('휴무일',
                                      style: TextStyle(fontSize: 15))),
                              Container(
                                  height: 8,
                                  width: 0.5,
                                  color: Colors.black26,
                                  margin: EdgeInsets.symmetric(horizontal: 8)),
                              Text(hospitalDetail.restDate ?? '',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Theme.of(context).accentColor))
                            ]),
                            SizedBox(height: 8),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: 56,
                                      child: Text('영업시간',
                                          style: TextStyle(fontSize: 15))),
                                  Container(
                                      height: 8,
                                      width: 0.5,
                                      color: Colors.black26,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8)),
                                  Flexible(
                                    child: Text(
                                        hospitalDetail.availableTime ?? '',
                                        style: TextStyle(fontSize: 15)),
                                  )
                                ]),
                            SizedBox(height: 8),
                            Row(children: [
                              Container(
                                  width: 56,
                                  child: Text('전화번호',
                                      style: TextStyle(fontSize: 15))),
                              Container(
                                  height: 8,
                                  width: 0.5,
                                  color: Colors.black26,
                                  margin: EdgeInsets.symmetric(horizontal: 8)),
                              Text(hospitalDetail.number ?? '',
                                  style: TextStyle(fontSize: 15))
                            ]),
                            SizedBox(height: 20),
                            GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => WritingReviewScreen())),
                                child: Container(
                                    alignment: Alignment.center,
                                    width: double.maxFinite,
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border:
                                            Border.all(color: Colors.black12)),
                                    child: Text('병원 리뷰 등록하기',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .accentColor))))
                          ])),
                  Container(
                      margin: EdgeInsets.only(bottom: 30),
                      width: double.maxFinite,
                      height: 12,
                      color: Color(0xFFF3F3F3)),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 24),
                              HospitalDetailButton(
                                  title: '병원 정보',
                                  isSelected: _selectedIndex == 0,
                                  onTap: () =>
                                      setState(() => _selectedIndex = 0)),
                              HospitalDetailButton(
                                  title: '진료비',
                                  isSelected: _selectedIndex == 1,
                                  onTap: () =>
                                      setState(() => _selectedIndex = 1)),
                              HospitalDetailButton(
                                  title: '리뷰 ' +
                                      '${hospitalDetail.hospitalReview!.length.toString()}',
                                  isSelected: _selectedIndex == 2,
                                  onTap: () =>
                                      setState(() => _selectedIndex = 2)),
                            ]),
                        if (_selectedIndex == 0)
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: buildFirstPage(
                                  context,
                                  hospitalDetail.bestPart,
                                  hospitalDetail.availableAnimal,
                                  hospitalDetail.intro)),
                        if (_selectedIndex == 1)
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: buildSecondPage(hospitalDetail.priceList)),
                        if (_selectedIndex == 2)
                          Padding(
                              padding: EdgeInsets.only(left: 24),
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      hospitalDetail.hospitalReview!.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final review =
                                        hospitalDetail.hospitalReview![index];

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
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReviewDetailPage(
                                                          review))),
                                          name: review.nickname,
                                          rate: review.rates,
                                          diagnosis: review.diagnosis,
                                          date: review.createdAt,
                                          imageList: review.reviewImage
                                              ?.map((e) => e.image)
                                              .toList(),
                                          content: review.content,
                                          likes: review.likes,
                                          isLike: true)
                                    ]);
                                  }))
                      ])
                ]));
          }
          return Center(
              child: Image.asset('assets/images/indicator.gif',
                  width: 100, height: 100));
        })));
  }

  Container buildFirstPage(BuildContext context, List<BestPart>? bestParts,
      List<AvailableAnimal>? availableAnimals, String? intro) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('특화 분야',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Wrap(spacing: 20, children: [
            for (var bestPart in bestParts!)
              Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Wrap(children: [
                    CircleAvatar(
                        child: SvgPicture.network(bestPart.image.toString()),
                        backgroundColor: Theme.of(context).backgroundColor,
                        radius: 13),
                    SizedBox(width: 8),
                    Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(bestPart.name!,
                            style: TextStyle(fontSize: 15)))
                  ])),
          ]),
          SizedBox(height: 30),
          Text('진료 반려 동물',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Row(children: [
            for (var availableAnimal in availableAnimals!)
              availableAnimals.last != availableAnimal
                  ? Text(availableAnimal.name! + ', ',
                      style: TextStyle(fontSize: 15))
                  : Text(availableAnimal.name ?? '',
                      style: TextStyle(fontSize: 15))
          ]),
          SizedBox(height: 30),
          Text('소개글',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(intro ?? '', style: TextStyle(fontSize: 15))
        ]));
  }

  Container buildSecondPage(List<Price>? priceList) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('진료 항목',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          for (var price in priceList!)
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(price.name!, style: TextStyle(fontSize: 15)),
                    Text(currencyFromStringWon(price.price.toString()) + '~',
                        style: TextStyle(fontSize: 15))
                  ]),
            ),
        ]));
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krrng_client/modules/writing_review/cubit/writing_review_cubit.dart';
import 'package:krrng_client/modules/writing_review/views/review_notice_page.dart';
import 'package:krrng_client/repositories/hospital_repository/models/hospital_detail.dart';
import 'package:krrng_client/support/style/theme.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:vrouter/vrouter.dart';

class WritingReviewPage extends StatefulWidget {
  const WritingReviewPage({Key? key}) : super(key: key);

  @override
  State<WritingReviewPage> createState() => _WritingReviewPageState();
}

class _WritingReviewPageState extends State<WritingReviewPage> {

  List<Asset> _images = <Asset>[];
  List<Asset> _reviewImages = <Asset>[];
  List<bool> terms = [false, false];
  late WritingReviewCubit _writingReviewCubit;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController diseaseController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();
  var rates = 0;

  @override
  void initState() {
    super.initState();
    _writingReviewCubit = BlocProvider.of<WritingReviewCubit>(context);
  }

  void dispose() {
    super.dispose();
    diseaseController.dispose();
    reviewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: state 값 주입
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          _HospitalProfileTile(),
          _Divier,
          _ReceivedMedical(),
          _Receipt(),
          _PostReview(),
          GestureDetector(
            onTap: () => {},
            child: Container (
                height: 105, width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/mainbanner.png"), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(25)))
          ),
          _Information(),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              final termsValidate = !terms.contains(false);

              if (_formKey.currentState!.validate()) {

                _writingReviewCubit.emit(_writingReviewCubit.state.copyWith(
                    rates: rates,
                    reviewContent: reviewController.text,
                    disease: diseaseController.text
                ));
                if (termsValidate == false) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("약관을 동의해주세요.")));
                } else {


                  _writingReviewCubit.createReview();
                }
              }
            },
            child: Container(
              height: 60,
              decoration: BoxDecoration(border: Border.all(color: dividerColor), color: Color(0xfffbfbfb)),
              alignment: Alignment.center,
              child: Text("병원 리뷰 등록하기", style: font_17_w900.copyWith(color: primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _HospitalProfileTile() {
    final hospital = _writingReviewCubit.hospitalDetail;

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
              Text("${hospital.name}", style: font_22_w900),
              Text("${hospital.address} ${hospital.addressDetail}", style: font_15_w500),
            ],
          )),
          Flexible(child: Container(
              height: 76,
              width: 76,
              margin: EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(hospital.images!.first.image!),
                      fit: BoxFit.cover))
          )
          )
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
              controller: diseaseController,
              validator: (text) => (text ?? "").length == 0 ? '진료 항목을 입력해주세요.' : null,
              obscureText: false,
              keyboardType: TextInputType.text,
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
              GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ReviewNoticePage(code: ReviewNotice.receipt))),
                  child: SvgPicture.asset("assets/icons/report.svg", width: 20))
            ],
          ),
          Text("해당 병원에서 진료 받으신 영수증을 첨부해 주세요.", style: font_14_w500.copyWith(height: 1.5)),
          // 영수증 썸네일 리스트 뷰
          Container(
            margin: EdgeInsets.only(top: 14, bottom: 30),
            height: 85,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _images.length == 0 ? 1 : _images.length+1,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (index == 0) {
                      _writingReviewCubit.getImages(_images);
                    }
                  },
                  child: Container(
                    width: 85,
                    margin: EdgeInsets.only(right: 8),
                    decoration: index == 0 ? thumbnailDecoration : thumbnailDecoration.copyWith(
                      image: DecorationImage(image: AssetThumbImageProvider(_images[index-1], height: 85, width: 85), fit: BoxFit.cover)
                    ),
                    child: index == 0 ? Icon(Icons.add, color: dividerColor)
                        : IconButton(onPressed: () {
                          setState(() {
                            _images.removeAt(index-1);
                          })
                          ;}, icon: Icon(Icons.close), alignment: Alignment.topRight,)
                  )
                  );
                })
                )
        ]),
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
                  GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ReviewNoticePage(code: ReviewNotice.hospital))),
                          child: SvgPicture.asset("assets/icons/report.svg", width: 20)
                  )
                ],
              ),
              RatesWidgets()
            ],
          ),
          const SizedBox(height: 17),
          Container(
            child: Stack(
              children: [
                TextFormField(
                  controller: reviewController,
                  validator: (text) {
                    final inputString = text ?? "";
                    if (inputString.length < 10  || inputString.length > 500) {
                      return '병원리뷰를 10자이상 입력해 주세요. (최대 500자)';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: baseInputDecoration("병원리뷰를 10자이상 입력해 주세요.\n(최대 500자)").copyWith(
                    contentPadding: _reviewImages.length == 0 ? EdgeInsets.fromLTRB(15, 14, 15, 44) : EdgeInsets.fromLTRB(15, 14, 15, 160),
                  ),
                ),
                _reviewImages.length > 0 ? Positioned(bottom: 20, left: 0,
                    child: Container(
                        margin: EdgeInsets.only(top: 14, bottom: 30),
                        height: 85,
                        width: MediaQuery.of(context).size.width-40,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _reviewImages.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    if (index == 0) {
                                      _writingReviewCubit.getReviewImages(_reviewImages);
                                    }
                                  },
                                  child: Container(
                                      width: 85,
                                      margin: index == 0? EdgeInsets.only(left: 15, right: 8) : EdgeInsets.only(right: 8),
                                      decoration: thumbnailDecoration.copyWith(image: DecorationImage(image: AssetThumbImageProvider(_reviewImages[index], height: 85, width: 85), fit: BoxFit.cover)),
                                      child: IconButton(onPressed: () { setState(() { _reviewImages.removeAt(index); }); }, icon: Icon(Icons.close), alignment: Alignment.topRight)
                                  )
                              );
                            })
                    )
                ) : SizedBox(height: 0),
                Positioned(bottom: 0, left: 0,
                    child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              _writingReviewCubit.getReviewImages(_reviewImages);
                            },
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

  Widget _Information() {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text("검수가 완료되면, 작성일 기준 차주 화요일에 포인트가 일괄 적립됩니다. (공휴일인 경우, 익일 적립)", style: font_14_w500.copyWith(height: 1.5)),
          const SizedBox(height: 10),
          Text("정보가 일치하지 않거나, 부적할 리뷰인 경우 포인트가 지급되지 않으며, 리뷰가 블라인드 처리될 수 있습니다.", style: font_14_w500.copyWith(height: 1.5, color: primaryColor)),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () => setState(() { terms[0] = !terms[0]; }),
                      icon: terms[0]
                          ? SvgPicture.asset(
                          'assets/images/checkBox_on.svg')
                          : SvgPicture.asset(
                          'assets/images/checkBox_off.svg'),
                      padding: EdgeInsets.zero, constraints: BoxConstraints(minWidth: 30), iconSize: 22),
                  Text('개인정보 수집 이용 동의(필수)', style: font_14_w500)
                ],
              ),
              GestureDetector(onTap: () => {}, child: Text("내용", style: font_14_w500.copyWith(color: subtitleColor, decoration: TextDecoration.underline)))
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () => setState(() { terms[1] = !terms[1]; }),
                      icon: terms[1]
                          ? SvgPicture.asset(
                          'assets/images/checkBox_on.svg')
                          : SvgPicture.asset(
                          'assets/images/checkBox_off.svg'),
                      padding: EdgeInsets.zero, constraints: BoxConstraints(minWidth: 30), iconSize: 22),
                  Text('민감정보 수집 이용 동의(필수)', style: font_14_w500),
                ],
              ),
              GestureDetector(onTap: () => {}, child: Text("내용", style: font_14_w500.copyWith(color: subtitleColor, decoration: TextDecoration.underline)))
            ],
          ),
        ],
      ),
    );
  }

  Widget RatesWidgets() {
    return Wrap(
      children: [
        IconButton(onPressed: () => setState(() { rates = 1; }),
            icon: rates >= 1 ? SvgPicture.asset("assets/icons/reviewOn.svg") : SvgPicture.asset("assets/icons/reviewOff.svg"),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            iconSize: 30
        ),
        IconButton(onPressed: () => setState(() { rates = 2; }),
            icon: rates >= 2 ? SvgPicture.asset("assets/icons/reviewOn.svg") : SvgPicture.asset("assets/icons/reviewOff.svg"),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            iconSize: 30
        ),
        IconButton(onPressed: () => setState(() { rates = 3; }),
            icon: rates >= 3 ? SvgPicture.asset("assets/icons/reviewOn.svg") : SvgPicture.asset("assets/icons/reviewOff.svg"),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            iconSize: 30
        ),
        IconButton(onPressed: () => setState(() { rates = 4; }),
            icon: rates >= 4 ? SvgPicture.asset("assets/icons/reviewOn.svg") : SvgPicture.asset("assets/icons/reviewOff.svg"),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            iconSize: 30
        ),
        IconButton(onPressed: () => setState(() { rates = 5; }),
            icon: rates >= 5 ? SvgPicture.asset("assets/icons/reviewOn.svg") : SvgPicture.asset("assets/icons/reviewOff.svg"),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            iconSize: 30
        ),
      ],
    );
  }
}
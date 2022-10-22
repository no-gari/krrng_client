import 'package:flutter/material.dart';

class AdsRequestPage extends StatefulWidget {
  const AdsRequestPage({Key? key}) : super(key: key);

  @override
  State<AdsRequestPage> createState() => _AdsRequestPageState();
}

class _AdsRequestPageState extends State<AdsRequestPage> {
  final _hospitalInfoController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _hospitalController = TextEditingController();
  final _roleController = TextEditingController();

  bool magazineChecked = false;
  bool phoneChecked = false;
  bool mailChecked = false;
  bool onlineSearchChecked = false;
  bool onlineAdsChecked = false;
  bool offlineChecked = false;
  bool recommendChecked = false;

  @override
  void dispose() {
    _hospitalInfoController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _hospitalController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: Text('제휴 및 광고문의',
                style: Theme.of(context).textTheme.headline2)),
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Text('업체 정보',
                          style: Theme.of(context).textTheme.headline3),
                      SizedBox(height: 10),
                      TextField(
                          autofocus: true,
                          controller: _hospitalInfoController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      BorderSide(color: Color(0xFFDFE2E9))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Color(0xFFDFE2E9))),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      BorderSide(color: Color(0xFFDFE2E9))),
                              hintText: '업체(병원) 명을 입력하세요.')),
                      SizedBox(height: 30),
                      Text('업체 주소',
                          style: Theme.of(context).textTheme.headline3),
                      SizedBox(height: 10),
                      TextField(
                          readOnly: true,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      BorderSide(color: Color(0xFFDFE2E9))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Color(0xFFDFE2E9))),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      BorderSide(color: Color(0xFFDFE2E9))),
                              hintText: '시, 군, 구를 입력하세요.')),
                      Container(
                          height: 0.5,
                          width: double.maxFinite,
                          color: Colors.black12,
                          margin: EdgeInsets.symmetric(vertical: 30)),
                      Text('신청자 명',
                          style: Theme.of(context).textTheme.headline3),
                      SizedBox(height: 10),
                      TextField(
                          controller: _nameController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      BorderSide(color: Color(0xFFDFE2E9))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Color(0xFFDFE2E9))),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      BorderSide(color: Color(0xFFDFE2E9))),
                              hintText: '신청자 이름을 입력하세요.')),
                      SizedBox(height: 30),
                      Text('이메일', style: Theme.of(context).textTheme.headline3),
                      SizedBox(height: 10),
                      TextField(
                          controller: _emailController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      BorderSide(color: Color(0xFFDFE2E9))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Color(0xFFDFE2E9))),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      BorderSide(color: Color(0xFFDFE2E9))),
                              hintText: '연락 가능한 이메일을 입력하세요.')),
                      SizedBox(height: 30),
                      Text('소속', style: Theme.of(context).textTheme.headline3),
                      SizedBox(height: 10),
                      TextField(
                          autofocus: true,
                          controller: _hospitalController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      BorderSide(color: Color(0xFFDFE2E9))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Color(0xFFDFE2E9))),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      BorderSide(color: Color(0xFFDFE2E9))),
                              hintText: '신청자 소속을 입력하세요(업체명 등)')),
                      SizedBox(height: 30),
                      Text('직책', style: Theme.of(context).textTheme.headline3),
                      SizedBox(height: 10),
                      TextField(
                          autofocus: true,
                          controller: _roleController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      BorderSide(color: Color(0xFFDFE2E9))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Color(0xFFDFE2E9))),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      BorderSide(color: Color(0xFFDFE2E9))),
                              hintText: '신청자 직책을 입력하세요.')),
                      Container(
                          height: 0.5,
                          width: double.maxFinite,
                          color: Colors.black12,
                          margin: EdgeInsets.symmetric(vertical: 30)),
                      Text('제휴 문의 및 경로',
                          style: Theme.of(context).textTheme.headline3),
                      SizedBox(height: 30),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('잡지 광고', style: TextStyle(fontSize: 16)),
                            Checkbox(
                                shape: CircleBorder(),
                                checkColor: Colors.white,
                                activeColor: Theme.of(context).accentColor,
                                value: magazineChecked,
                                onChanged: (bool? value) =>
                                    setState(() => magazineChecked = value!))
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('전화 영업', style: TextStyle(fontSize: 16)),
                            Checkbox(
                                shape: CircleBorder(),
                                checkColor: Colors.white,
                                activeColor: Theme.of(context).accentColor,
                                value: phoneChecked,
                                onChanged: (bool? value) =>
                                    setState(() => phoneChecked = value!))
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('우편물 수령', style: TextStyle(fontSize: 16)),
                            Checkbox(
                                shape: CircleBorder(),
                                checkColor: Colors.white,
                                activeColor: Theme.of(context).accentColor,
                                value: mailChecked,
                                onChanged: (bool? value) =>
                                    setState(() => mailChecked = value!))
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('온라인 검색', style: TextStyle(fontSize: 16)),
                            Checkbox(
                                shape: CircleBorder(),
                                checkColor: Colors.white,
                                activeColor: Theme.of(context).accentColor,
                                value: onlineSearchChecked,
                                onChanged: (bool? value) => setState(
                                    () => onlineSearchChecked = value!))
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('온라인 광고', style: TextStyle(fontSize: 16)),
                            Checkbox(
                                shape: CircleBorder(),
                                checkColor: Colors.white,
                                activeColor: Theme.of(context).accentColor,
                                value: onlineAdsChecked,
                                onChanged: (bool? value) =>
                                    setState(() => onlineAdsChecked = value!))
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('오프라인 (학회 / 전시 박람회 등)',
                                style: TextStyle(fontSize: 16)),
                            Checkbox(
                                shape: CircleBorder(),
                                checkColor: Colors.white,
                                activeColor: Theme.of(context).accentColor,
                                value: offlineChecked,
                                onChanged: (bool? value) =>
                                    setState(() => offlineChecked = value!))
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('특정 병원 추천 - 추천 프로그램',
                                style: TextStyle(fontSize: 16)),
                            Checkbox(
                                shape: CircleBorder(),
                                checkColor: Colors.white,
                                activeColor: Theme.of(context).accentColor,
                                value: recommendChecked,
                                onChanged: (bool? value) =>
                                    setState(() => recommendChecked = value!))
                          ]),
                      SizedBox(height: 50)
                    ]))),
        bottomNavigationBar: GestureDetector(
          onTap: () {},
          child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.black38, width: 1))),
              height: 75,
              child: Text('문의 하기',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Theme.of(context).accentColor))),
        ));
  }
}

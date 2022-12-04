import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpostal/kpostal.dart';
import 'package:krrng_client/modules/ads_request/cubit/ads_request_cubit.dart';
import 'package:krrng_client/modules/settings/view/setting_screen.dart';
import 'package:krrng_client/support/base_component/required_text.dart';
import 'package:vrouter/vrouter.dart';

class AdsRequestPage extends StatefulWidget {
  const AdsRequestPage({Key? key}) : super(key: key);

  @override
  State<AdsRequestPage> createState() => _AdsRequestPageState();
}

class _AdsRequestPageState extends State<AdsRequestPage> {
  late AdsRequestCubit _adsRequestCubit;

  final _hospitalInfoController = TextEditingController();
  final _hospitalAddressController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _hospitalController = TextEditingController();
  final _roleController = TextEditingController();
  final _phoneController = TextEditingController();

  bool magazineChecked = false;
  bool phoneChecked = false;
  bool mailChecked = false;
  bool onlineSearchChecked = false;
  bool onlineAdsChecked = false;
  bool offlineChecked = false;
  bool recommendChecked = false;

  var checked_list = [];

  @override
  void initState() {
    super.initState();
    _adsRequestCubit = BlocProvider.of<AdsRequestCubit>(context);
  }

  @override
  void dispose() {
    _hospitalInfoController.dispose();
    _hospitalAddressController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _hospitalController.dispose();
    _roleController.dispose();
    _phoneController.dispose();
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
                      RequiredText(
                          child: Text('업체 정보',
                              style: Theme.of(context).textTheme.headline3)),
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
                      RequiredText(
                          child: Text('업체 주소',
                              style: Theme.of(context).textTheme.headline3)),
                      SizedBox(height: 10),
                      TextField(
                          controller: _hospitalAddressController,
                          onTap: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => KpostalView(
                                        useLocalServer: false,
                                        callback: (Kpostal result) {
                                          setState(() {
                                            _hospitalAddressController.text =
                                                result.address;
                                          });
                                        })));
                          },
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
                      RequiredText(
                          child: Text('신청자 명',
                              style: Theme.of(context).textTheme.headline3)),
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
                      RequiredText(
                          child: Text('이메일',
                              style: Theme.of(context).textTheme.headline3)),
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
                      RequiredText(
                          child: Text('휴대폰 번호',
                              style: Theme.of(context).textTheme.headline3)),
                      SizedBox(height: 10),
                      TextField(
                          controller: _phoneController,
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
                              hintText: '연락 가능한 번호를 입력하세요.')),
                      SizedBox(height: 30),
                      RequiredText(
                          child: Text('소속',
                              style: Theme.of(context).textTheme.headline3)),
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
                      RequiredText(
                          child: Text('직책',
                              style: Theme.of(context).textTheme.headline3)),
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
                      RequiredText(
                          child: Text('제휴 문의 및 경로',
                              style: Theme.of(context).textTheme.headline3)),
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
                                onChanged: (bool? value) {
                                  setState(() {
                                    magazineChecked = value!;
                                    if (value == false) {
                                      checked_list.remove('잡지 광고, ');
                                    } else {
                                      checked_list.add('잡지 광고, ');
                                    }
                                  });
                                })
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
                                onChanged: (bool? value) {
                                  setState(() {
                                    phoneChecked = value!;
                                    if (value == false) {
                                      checked_list.remove('전화 영업, ');
                                    } else {
                                      checked_list.add('전화 영업, ');
                                    }
                                  });
                                })
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
                                onChanged: (bool? value) {
                                  setState(() {
                                    mailChecked = value!;
                                    if (value == false) {
                                      checked_list.remove('우편물 수령, ');
                                    } else {
                                      checked_list.add('우편물 수령, ');
                                    }
                                  });
                                })
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
                                onChanged: (bool? value) {
                                  setState(() {
                                    onlineSearchChecked = value!;
                                    if (value == false) {
                                      checked_list.remove('온라인 검색, ');
                                    } else {
                                      checked_list.add('온라인 검색, ');
                                    }
                                  });
                                })
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
                                onChanged: (bool? value) {
                                  setState(() {
                                    onlineAdsChecked = value!;
                                    if (value == false) {
                                      checked_list.remove('온라인 광고, ');
                                    } else {
                                      checked_list.add('온라인 광고, ');
                                    }
                                  });
                                })
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
                                onChanged: (bool? value) {
                                  setState(() {
                                    offlineChecked = value!;
                                    if (value == false) {
                                      checked_list
                                          .remove('오프라인 (학회 / 전시 박람회 등), ');
                                    } else {
                                      checked_list
                                          .add('오프라인 (학회 / 전시 박람회 등), ');
                                    }
                                  });
                                })
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
                                onChanged: (bool? value) {
                                  setState(() {
                                    recommendChecked = value!;
                                    if (value == false) {
                                      checked_list
                                          .remove('특정 병원 추천 - 추천 프로그램, ');
                                    } else {
                                      checked_list.add('특정 병원 추천 - 추천 프로그램, ');
                                    }
                                  });
                                })
                          ]),
                      SizedBox(height: 50)
                    ]))),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            if (_hospitalController.text.trim() == '' ||
                _roleController.text.trim() == '' ||
                _emailController.text.trim() == '' ||
                _nameController.text.trim() == '' ||
                _phoneController.text.trim() == '' ||
                _hospitalAddressController.text.trim() == '' ||
                _hospitalInfoController.text.trim() == '') {
              showDialog(
                  context: context,
                  barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                  builder: (BuildContext context) {
                    return AlertDialog(
                        content: Text("모든 항목을 채워주세요."),
                        insetPadding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
                        actions: [
                          TextButton(
                              child: const Text('확인'),
                              onPressed: () => Navigator.of(context).pop())
                        ]);
                  });
            } else {
              _adsRequestCubit.createOffer(
                  _hospitalController.text,
                  _hospitalAddressController.text,
                  _nameController.text,
                  _emailController.text,
                  _phoneController.text,
                  _hospitalController.text,
                  checked_list.toString());
            }
            showDialog(
                context: context,
                barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                builder: (BuildContext context) {
                  return AlertDialog(
                      content: Text("접수 되었습니다."),
                      insetPadding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
                      actions: [
                        TextButton(
                            child: const Text('확인'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              context.vRouter.to(SettingScreen.routeName);
                            })
                      ]);
                });
          },
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

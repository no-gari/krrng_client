import 'dart:async';
import 'package:flutter_html/flutter_html.dart';
import 'package:vrouter/vrouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/support/style/theme.dart';
import 'package:krrng_client/modules/main/main_screen.dart';
import 'package:krrng_client/support/style/format_unit.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:krrng_client/repositories/user_repository/models/user.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/repositories/user_repository/src/user_repository.dart';
import 'package:krrng_client/modules/authentication/signup/cubit/signup_cubit.dart';

class SnsPhonePage extends StatefulWidget {
  @override
  _SignupSecondStepState createState() => _SignupSecondStepState();
}

class _SignupSecondStepState extends State<SnsPhonePage> {
  late SignupCubit _signupCubit;
  late AuthenticationBloc _authBloc;

  List<bool> terms = [false, false];

  final phoneController = TextEditingController();
  final codeController = TextEditingController();

  late Timer _timer;
  int _timeCount = 180;
  String? _timerText;

  FocusNode codeFocusNode = FocusNode();

  @override
  void initState() {
    _signupCubit = BlocProvider.of<SignupCubit>(context);
    _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    codeController.dispose();
    _timer.cancel();
    codeFocusNode.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(
        Duration(seconds: 1),
        (Timer timer) => {
              setState(() {
                if (_timeCount <= 0) {
                  _timer.cancel();
                  _timeCount = 180;
                  _timerText = null;
                } else {
                  if (_timer.isActive) {
                    int minute = (_timeCount / 60.floor()).toInt();
                    String minuteString = minute > 0 ? "${minute}분" : "";
                    String secondString = "${_timeCount - (minute * 60)}초";
                    _timerText = minuteString + secondString;
                    _timeCount -= 1;
                  }
                }
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            bottomSheet: MaterialButton(
                height: 75,
                onPressed: () {
                  if (_signupCubit.state.inputCode == null) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              content: Text("인증코드 및 약관을 확인해주세요."),
                              insetPadding:
                                  const EdgeInsets.fromLTRB(0, 80, 0, 80),
                              actions: [
                                TextButton(
                                    child: const Text('확인'),
                                    onPressed: () =>
                                        Navigator.of(context).pop())
                              ]);
                        });
                  } else if (_signupCubit.state.isCompleteCode != true) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              content: Text("인증코드를 확인해주세요."),
                              insetPadding:
                                  const EdgeInsets.fromLTRB(0, 80, 0, 80),
                              actions: [
                                TextButton(
                                    child: const Text('확인'),
                                    onPressed: () =>
                                        Navigator.of(context).pop())
                              ]);
                        });
                  } else if (_signupCubit.state.term != true) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              content: Text("약관을 확인해주세요."),
                              insetPadding:
                                  const EdgeInsets.fromLTRB(0, 80, 0, 80),
                              actions: [
                                TextButton(
                                    child: const Text('확인'),
                                    onPressed: () =>
                                        Navigator.of(context).pop())
                              ]);
                        });
                  } else {
                    _signupCubit.emit(_signupCubit.state.copyWith(
                        phoneNumber: phoneController.text,
                        inputId: _authBloc.state.user.email,
                        inputPassword: '123456'));
                    _signupCubit.signup().then((value) {
                      getUser().then((_) {
                        if (_authBloc.state.user.phone != null) {
                          context.vRouter.to(MainScreen.routeName);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("오류가 발생했습니다. 관리자에게 문의하세요.")));
                        }
                      });
                    });
                  }
                },
                minWidth: MediaQuery.of(context).size.width,
                child: Text("확인",
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: primaryColor)),
                elevation: 10,
                color: Colors.white),
            body: SafeArea(
                child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("휴대폰 인증",
                                    style:
                                        Theme.of(context).textTheme.headline3!),
                                const SizedBox(height: 10),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: TextFormField(
                                              controller: phoneController,
                                              keyboardType: TextInputType.phone,
                                              decoration: InputDecoration(
                                                  isCollapsed: true,
                                                  contentPadding:
                                                      InsetSymmetric15,
                                                  enabledBorder: outline,
                                                  focusedBorder: outline_focus,
                                                  border: outline,
                                                  hintText: '휴대폰 번호를 입력하세요.'))),
                                      SizedBox(width: 10),
                                      Container(
                                          width: 93,
                                          height: 48,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                final phoneNumber =
                                                    phoneController.text.trim();

                                                if (isValidPhoneNumberFormat(
                                                    phoneNumber)) {
                                                  if (_timerText == null) {
                                                    _signupCubit.requestCode(
                                                        phoneNumber);
                                                    _startTimer();
                                                    codeFocusNode
                                                        .requestFocus();
                                                  }
                                                } else {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                            content: Text(
                                                                "핸드폰 번호를 확인해주세요."),
                                                            insetPadding: EdgeInsets.fromLTRB(0, 80, 0, 80),
                                                            actions: [
                                                              TextButton(
                                                                  child: Text(
                                                                      '확인'),
                                                                  onPressed: () =>
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop())
                                                            ]);
                                                      });
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      _timerText == null
                                                          ? primaryColor
                                                          : dividerColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12))),
                                              child: Text("인증요청",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16))))
                                    ]),
                                const SizedBox(height: 10),
                                Row(children: [
                                  Expanded(
                                      child: TextFormField(
                                          controller: codeController,
                                          focusNode: codeFocusNode,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) =>
                                              _signupCubit.setInputCode(value),
                                          decoration: InputDecoration(
                                              isCollapsed: true,
                                              contentPadding: InsetSymmetric15,
                                              enabledBorder: outline,
                                              focusedBorder: outline_focus,
                                              border: outline,
                                              suffix: Text(_timerText ?? "",
                                                  style: font_16_w700.copyWith(
                                                      color: primaryColor)),
                                              hintText: '인증 번호를 입력하세요.'))),
                                  SizedBox(width: 10),
                                  Container(
                                      width: 75,
                                      height: 48,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            _signupCubit
                                                .confirmCode(_signupCubit
                                                        .state.inputCode ??
                                                    "")
                                                .then((value) {
                                              if (_signupCubit.state.error !=
                                                      null &&
                                                  _signupCubit.state
                                                          .isCompleteCode !=
                                                      true) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "인증 번호를 확인해 주세요.")));
                                              }
                                              if (_signupCubit
                                                      .state.isCompleteCode ==
                                                  true) {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                          content:
                                                              Text("인증 되었습니다."),
                                                          insetPadding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 80, 0, 80),
                                                          actions: [
                                                            TextButton(
                                                                child:
                                                                    const Text(
                                                                        '확인'),
                                                                onPressed: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop())
                                                          ]);
                                                    });
                                              }
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: primaryColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12))),
                                          child: Text("확인",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16))))
                                ]),
                                SizedBox(height: 30),
                                GestureDetector(
                                    onTap: () {
                                      if (_signupCubit.state.phoneNumber !=
                                          null) {
                                        var phoneNumber =
                                            _signupCubit.state.phoneNumber ??
                                                "";
                                        _signupCubit.requestCode(phoneNumber);
                                        setState(() {
                                          _timer.cancel();
                                          _timeCount = 180;
                                          _timerText = null;
                                        });
                                        _startTimer();
                                        codeFocusNode.requestFocus();
                                      }
                                    },
                                    child: Container(
                                        width: size.width,
                                        alignment: Alignment.center,
                                        child: Text("인증번호 재전송",
                                            style: TextStyle(
                                                color: primaryColor,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w900))))
                              ]),
                          SizedBox(height: (size.height - 350) * 0.6),
                          Container(
                              width: size.width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 20),
                              decoration: BoxDecoration(
                                  color: Color(0xFFfbfbfb),
                                  border:
                                      Border.all(color: dividerColor, width: 1),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(children: <Widget>[
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Transform.scale(
                                          scale: 1.2,
                                          child: SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: Checkbox(
                                                  shape: CircleBorder(),
                                                  checkColor: Colors.white,
                                                  activeColor: Theme.of(context)
                                                      .accentColor,
                                                  value: terms[0] && terms[1],
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      if (value == true) {
                                                        terms = [true, true];
                                                      } else {
                                                        terms = [false, false];
                                                      }
                                                    });
                                                    _signupCubit.setTerms(
                                                        terms[0] && terms[1]);
                                                  }))),
                                      Text('    전체 동의',
                                          style: TextStyle(fontSize: 16))
                                    ]),
                                SizedBox(height: 15),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        Transform.scale(
                                            scale: 1.2,
                                            child: SizedBox(
                                                width: 16,
                                                height: 16,
                                                child: Checkbox(
                                                    shape: CircleBorder(),
                                                    checkColor: Colors.white,
                                                    activeColor:
                                                        Theme.of(context)
                                                            .accentColor,
                                                    value: terms[0],
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        terms[0] =
                                                            value ?? false;
                                                      });
                                                      _signupCubit.setTerms(
                                                          terms[0] && terms[1]);
                                                    }))),
                                        Text('    이용 약관(필수)',
                                            style: TextStyle(fontSize: 16))
                                      ]),
                                      GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                                context: context,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        25),
                                                                topRight: Radius
                                                                    .circular(
                                                                        25))),
                                                builder: (context) => Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.7,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Html(
                                                          data: '''
                  <div class="modal-body">
	제1조 (목적)<br>
<br>
이 약관은 OO 회사(전자상거래 사업자)가 운영하는 OO 사이버 몰(이하 “몰”이라 한다)에서 제공하는 인터넷 관련 서비스(이하 “서비스”라 한다)를 이용함에 있어 사이버 몰과 이용자의 권리․의무 및 책임 사항을 규정함을 목적으로 합니다.<br>
<br>
제2조 (정의)<br>
<br>
① “몰”이란 OO 회사가 재화 또는 용역(이하 “재화 등”이라 함)을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이버몰을 운영하는 사업자의 의미로도 사용합니다.<br>
② “이용자”란 “몰”에 접속하여 이 약관에 따라 “몰”이 제공하는 서비스를 받는 회원 및 비회원을 말합니다.<br>
③ ‘회원’이라 함은 “몰”에 회원등록을 한 자로서, 계속적으로 “몰”이 제공하는 서비스를 이용할 수 있는 자를 말합니다.<br>
④ ‘비회원’이라 함은 회원에 가입하지 않고 “몰”이 제공하는 서비스를 이용하는 자를 말합니다.<br>
<br>
제3조 (약관 등의 명시와 설명 및 개정)<br>
<br>
① “몰”은 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호․모사전송번호․전자우편주소, 사업자등록번호, 통신<br>
판매업 신고번호, 개인정보 관리 책임자 등을 이용자가 쉽게 알 수 있도록 “몰”의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.<br>
② “몰은 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약 철회, 배송책임, 환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.<br>
③ “몰”은 「전자상거래 등에서의 소비자보호에 관한 법률」, 「약관의 규제에 관한 법률」, 「전자문서 및 전자거래 기본법」, 「전자금융거래법」, 「전자서명법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」, 「방문판매 등에 관한 법률」, 「소비자기본법」 등 관련 법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.<br>
④ “몰”이 약관을 개정할 경우에는 적용 일자 및 개정 사유를 명시하여 현행약관과 함께 몰의 초기화면에 그 적용 일자 7일 이전부터 적용 일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관 내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 "몰“은 개정 전 내용과 개정 후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.<br>
⑤ “몰”이 약관을 개정할 경우에는 그 개정약관은 그 적용 일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정 전의 약관조항이 그대로 적용됩니다. 다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지 기간 내에 “몰”에 송신하여 “몰”의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.<br>
⑥ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제 등에 관한 법률, 공정거래위원회가 정하는 전자상거래 등에서의 소비자 보호지침 및 관계법령 또는 상관례에 따릅니다.<br>
<br>
제4조 (서비스의 제공 및 변경)<br>
<br>
① “몰”은 다음과 같은 업무를 수행합니다.<br>
 1. 재화 또는 용역에 대한 정보 제공 및 구매계약의 체결<br>
 2. 구매계약이 체결된 재화 또는 용역의 배송<br>
 3. 기타 “몰”이 정하는 업무<br>
② “몰”은 재화 또는 용역의 품절 또는 기술적 사양의 변경 등의 경우에는 장차 체결되는 계약에 의해 제공할 재화 또는 용역의 내용을 변경할 수 있습니다. 이 경우에는 변경된 재화 또는 용역의 내용 및 제공 일자를 명시하여 현재의 재화 또는 용역의 내용을 게시한 곳에 즉시 공지합니다.<br>
③ “몰”이 제공하기로 이용자와 계약을 체결한 서비스의 내용을 재화등의 품절 또는 기술적 사양의 변경 등의 사유로 변경할 경우에는 그 사유를 이용자에게 통지 가능한 주소로 즉시 통지합니다.<br>
④ 전항의 경우 “몰”은 이로 인하여 이용자가 입은 손해를 배상합니다. 다만, “몰”이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.<br>
<br>
제5조 (서비스의 중단)<br>
<br>
① “몰”은 컴퓨터 등 정보통신 설비의 보수점검․교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.<br>
② “몰”은 제1항의 사유로 서비스의 제공이 일시적으로 중단됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단, “몰”이 고의 또는 과실이 없음을 입증하는 경우에는<br>
그러하지 아니합니다.<br>
③ 사업 종목의 전환, 사업의 포기, 업체 간의 통합 등의 이유로 서비스를 제공할 수 없게 되는 경우에는 “몰”은 제8조에 정한 방법으로 이용자에게 통지하고 당초 “몰”에서 제시한 조건에 따라 소비자에게 보상합니다. 다만, “몰”이 보상기준 등을 고지하지 아니한 경우에는 이용자들의 마일리지 또는 적립금 등을 “몰”에서 통용되는 통화가치에 상응하는 현물 또는 현금으로 이용자에게 지급합니다.<br>
<br>
제6조 (회원가입)<br>
<br>
① 이용자는 “몰”이 정한 가입 양식에 따라 회원 정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로써 회원가입을 신청합니다.<br>
② “몰”은 제1항과 같이 회원으로 가입할 것을 신청한 이용자 중 다음 각호에 해당하지 않는 한 회원으로 등록합니다.<br>
 1. 가입 신청자가 이 약관 제7조 제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우, 다만 제7조제3항에 의한 회원자격 상실 후 3년이 경과한 자로서 “몰”의 회원 재가입 승낙을 얻은 경우에는 예외로 한다.<br>
 2. 등록 내용에 허위, 기재누락, 오기가 있는 경우<br>
 3. 기타 회원으로 등록하는 것이 “몰”의 기술상 현저히 지장이 있다고 판단되는 경우<br>
③ 회원가입 계약의 성립 시기는 “몰”의 승낙이 회원에게 도달한 시점으로 합니다.<br>
④ 회원은 회원가입 시 등록한 사항에 변경이 있는 경우, 상당한 기간 이내에 “몰”에 대하여 회원 정보 수정 등의 방법으로 그 변경사항을 알려야 합니다.<br>
<br>
제7조 (회원 탈퇴 및 자격 상실 등)<br>
<br>
① 회원은 “몰”에 언제든지 탈퇴를 요청할 수 있으며 “몰”은 즉시 회원탈퇴를 처리합니다.<br>
② 회원이 다음 각호의 사유에 해당하는 경우, “몰”은 회원자격을 제한 및 정지시킬 수 있습니다.<br>
 1. 가입 신청 시에 허위 내용을 등록한 경우<br>
 2. “몰”을 이용하여 구입한 재화 등의 대금, 기타 “몰”이용에 관련하여 회원이 부담하는 채무를 기일에 지급하지 않는 경우<br>
 3. 다른 사람의 “몰” 이용을 방해하거나 그 정보를 도용하는 등 전자상거래 질서를 위협하는 경우<br>
 4. “몰”을 이용하여 법령 또는 이 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우<br>
③ “몰”이 회원 자격을 제한, 정지시킨 후, 동일한 행위가 2회 이상 반복되거나 30일 이내에 그 사유가 시정되지 아니하는 경우 “몰”은 회원자격을 상실시킬 수 있습니다.<br>
④ “몰”이 회원자격을 상실시키는 경우에는 회원등록을 말소합니다. 이 경우 회원에게 이를 통지하고, 회원등록 말소 전에 최소한 30일 이상의 기간을 정하여 소명할 기회를 부여합니다.<br>
<br>
제8조(회원에 대한 통지)<br>
<br>
① “몰”이 회원에 대해 통지를 하는 경우, 회원이 “몰”과 미리 약정하여 지정한 전자우편 주소로 할 수 있습니다.<br>
② “몰”은 불특정 다수 회원에 대한 통지의 경우 1주일 이상 “몰” 게시판에 게시함으로써 개별 통지에 갈음할 수 있습니다. 다만, 회원 본인의 거래와 관련하여 중대한 영향을 미치는 사항에 대하여는 개별통지를 합니다.<br>
<br>
제9조(구매신청 및 개인정보 제공 동의 등)<br>
<br>
① “몰”이용자는 “몰”상에서 다음 또는 이와 유사한 방법에 의하여 구매를 신청하며, “몰”은 이용자가 구매신청을 함에 있어 다음의 각 내용을 알기 쉽게 제공하여야 합니다.<br>
 1. 재화 등의 검색 및 선택<br>
 2. 받는 사람의 성명, 주소, 전화번호, 전자우편주소(또는 이동전화번호) 등의 입력<br>
 3. 약관 내용, 청약 철회권이 제한되는 서비스, 배송료․설치비 등의 비용부담과 관련한 내용에 대한 확인<br>
 4. 이 약관에 동의하고 위 3.호의 사항을 확인하거나 거부하는 표시 (예, 마우스 클릭)<br>
 5. 재화 등의 구매신청 및 이에 관한 확인 또는 “몰”의 확인에 대한 동의<br>
 6. 결제 방법의 선택<br>
② “몰”이 제3자에게 구매자 개인정보를 제공할 필요가 있는 경우 1) 개인정보를 제공받는 자, 2) 개인정보를 제공받는 자의 개인정보 이용목적, 3) 제공하는 개인정보의 항목, 4) 개인정보를 제공받는 자의 개인정보 보유 및 이용 기간을 구매자에게 알리고 동의를 받아야 합니다.(동의를 받은 사항이 변경되는 경우에도 같습니다.)<br>
③ “몰”이 제3자에게 구매자의 개인정보를 취급할 수 있도록 업무를 위탁하는 경우에는 1) 개인정보 취급위탁을 받는 자, 2) 개인정보 취급위탁을 하는 업무의 내용을 구매자에게 알리고 동의를 받아야 합니다.(동의를 받은 사항이 변경되는 경우에도 같습니다.) 다만, 서비스 제공에 관한 계약이행을 위해 필요하고 구매자의 편의 증진과 관련된 경우에는 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」에서 정하고 있는 방법으로 개인정보 취급방침을 통해 알림으로써 고지 절차와 동의 절차를 거치지 않아도 됩니다.<br>
<br>
제10조 (계약의 성립)<br>
<br>
① “몰”은 제9조와 같은 구매신청에 대하여 다음 각호에 해당하면 승낙하지 않을 수 있습니다. 다만, 미성년자와 계약을 체결하는 경우에는 법정대리인의 동의를 얻지 못하면 미성년자 본인 또는 법정대리인이 계약을 취소할 수 있다는 내용을 고지하여야 합니다.<br>
 1. 신청 내용에 허위, 기재누락, 오기가 있는 경우<br>
 2. 미성년자가 담배, 주류 등 청소년보호법에서 금지하는 재화 및 용역을 구매하는 경우<br>
 3. 기타 구매신청에 승낙하는 것이 “몰” 기술상 현저히 지장이 있다고 판단하는 경우<br>
② “몰”의 승낙이 제12조 제1항의 수신확인통지 형태로 이용자에게 도달한 시점에 계약이 성립한 것으로 봅니다.<br>
③ “몰”의 승낙의 의사표시에는 이용자의 구매 신청에 대한 확인 및 판매 가능 여부, 구매신청의 정정 취소 등에 관한 정보 등을 포함하여야 합니다.<br>
<br>
제11조 (지급 방법)<br>
<br>
“몰”에서 구매한 재화 또는 용역에 대한 대금 지급방법은 다음 각호의 방법 중 가용한 방법으로 할 수 있습니다. 단, “몰”은 이용자의 지급 방법에 대하여 재화 등의 대금에 어떠한 명목의 수수료도 추가하여 징수할 수 없습니다.<br>
 1. 폰뱅킹, 인터넷뱅킹, 메일 뱅킹 등의 각종 계좌이체<br>
 2. 선불카드, 직불카드, 신용카드 등의 각종 카드 결제<br>
 3. 온라인무통장입금<br>
 4. 전자화폐에 의한 결제<br>
 5. 수령 시 대금 지급<br>
 6. 마일리지 등 “몰”이 지급한 포인트에 의한 결제<br>
 7. “몰”과 계약을 맺었거나 “몰”이 인정한 상품권에 의한 결제<br>
 8. 기타 전자적 지급 방법에 의한 대금 지급 등<br>
<br>
제12조 (수신확인통지․구매신청 변경 및 취소)<br>
<br>
① “몰”은 이용자의 구매신청이 있는 경우 이용자에게 수신확인통지를 합니다.<br>
② 수신확인통지를 받은 이용자는 의사표시의 불일치 등이 있는 경우에는 수신확인통지를 받은 후 즉시 구매신청 변경 및 취소를 요청할 수 있고 “몰”은 배송 전에 이용자의 요청이 있는 경우에는 지체 없이 그 요청에 따라 처리하여야 합니다. 다만 이미 대금을 지불한 경우에는 제15조의 청약 철회 등에 관한 규정에 따릅니다.<br>
<br>
제13조 (재화 등의 공급)<br>
<br>
① “몰”은 이용자와 재화 등의 공급시기에 관하여 별도의 약정이 없는 이상, 이용자가 청약을 한 날부터 7일 이내에 재화 등을 배송할 수 있도록 주문 제작, 포장 등 기타의 필요한 조치를 합니다. 다만, “몰”이 이미 재화 등의 대금의 전부 또는 일부를 받은 경우에는 대금의 전부 또는 일부를 받은 날부터 3영업일 이내에 조치를 합니다. 이때 “몰”은 이용자가 재화 등의 공급 절차 및 진행 사항을 확인할 수 있도록 적절한 조치를 합니다.<br>
② “몰”은 이용자가 구매한 재화에 대해 배송수단, 수단별 배송비용 부담자, 수단별 배송기간 등을 명시합니다. 만약 “몰”이 약정 배송기간을 초과한 경우에는 그로 인한 이용자의 손해를 배상하여야 합니다. 다만 “몰”이 고의, 과실이 없음을 입증한 경우에는 그러하지 아니합니다.<br>
<br>
제14조 (환급)<br>
<br>
“몰”은 이용자가 구매 신청한 재화 등이 품절 등의 사유로 인도 또는 제공을 할 수 없을 때는 지체 없이 그 사유를 이용자에게 통지하고 사전에 재화 등의 대금을 받은 경우에는 대금을 받은 날부터 3영업일 이내에 환급하거나 환급에 필요한 조치를 합니다.<br>
<br>
제15조 (청약 철회 등)<br>
<br>
① “몰”과 재화 등의 구매에 관한 계약을 체결한 이용자는 「전자상거래 등에서의 소비자보호에 관한 법률」 제13조 제2항에 따른 계약 내용에 관한 서면을 받은 날(그 서면을 받은 때보다 재화 등의 공급이 늦게 이루어진 경우에는 재화 등을 공급받거나 재화 등의 공급이 시작된 날을 말합니다)부터 7일 이내에는 청약의 철회를 할 수 있습니다. 다만, 청약 철회에 관하여 「전자상거래 등에서의 소비자보호에 관한 법률」에 달리 정함이 있는 경우에는 동 법 규정에 따릅니다.<br>
② 이용자는 재화 등을 배송받은 경우 다음 각호의 1에 해당하는 경우에는 반품 및 교환을 할 수 없습니다.<br>
 1. 이용자에게 책임 있는 사유로 재화 등이 멸실 또는 훼손된 경우(다만, 재화 등의 내용을 확인하기 위하여 포장 등을 훼손한 경우에는 청약 철회를 할 수 있습니다)<br>
 2. 이용자의 사용 또는 일부 소비에 의하여 재화 등의 가치가 현저히 감소한 경우<br>
 3. 시간의 경과에 의하여 재판매가 곤란할 정도로 재화 등의 가치가 현저히 감소한 경우<br>
 4. 같은 성능을 지닌 재화 등으로 복제가 가능한 경우 그 원본인 재화 등의 포장을 훼손한 경우<br>
③ 제2항 제2호 내지 제4호의 경우에 “몰”이 사전에 청약철회 등이 제한되는 사실을 소비자가 쉽게 알 수 있는 곳에 명기하거나 시용상품을 제공하는 등의 조치를 하지 않았다면 이용자의 청약 철회 등이 제한되지 않습니다.<br>
④ 이용자는 제1항 및 제2항의 규정에도 불구하고 재화 등의 내용이 표시·광고 내용과 다르거나 계약 내용과 다르게 이행된 때에는 당해 재화 등을 공급받은 날부터 3월 이내, 그 사실을 안 날 또는 알 수 있었던 날부터 30일 이내에 청약 철회 등을 할 수 있습니다.<br>
<br>
제16조 (청약 철회 등의 효과)<br>
<br>
① “몰”은 이용자로부터 재화 등을 반환받은 경우 3영업일 이내에 이미 지급받은 재화 등의 대금을 환급합니다. 이 경우 “몰”이 이용자에게 재화 등의 환급을 지연할 때에는 그 지연기간에 대하여 「전자상거래 등에서의 소비자보호에 관한 법률 시행령」 제21조의 3에서 정하는 지연 이자율을 곱하여 산정한 지연이자를 지급합니다.<br>
② “몰”은 위 대금을 환급함에 있어서 이용자가 신용카드 또는 전자화폐 등의 결제수단으로 재화 등의 대금을 지급한 때에는 지체 없이 당해 결제수단을 제공한 사업자가 재화 등의 대금 청구를 정지 또는 취소하도록 요청합니다.<br>
③ 청약 철회 등의 경우 공급받은 재화 등의 반환에 필요한 비용은 이용자가 부담합니다. “몰”은 이용자에게 청약 철회 등을 이유로 위약금 또는 손해배상을 청구하지 않습니다. 다만 재화 등의 내용이 표시·광고 내용과 다르거나 계약 내용과 다르게 이행되어 청약 철회 등을 하는 경우 재화 등의 반환에 필요한 비용은 “몰”이 부담합니다.<br>
④ 이용자가 재화 등을 제공받을 때 발송비를 부담한 경우에 “몰”은 청약 철회 시 그 비용을 누가 부담하는지를 이용자가 알기 쉽도록 명확하게 표시합니다.<br>
<br>
제17조 (개인정보보호)<br>
<br>
① “몰”은 이용자의 개인정보 수집시 서비스 제공을 위하여 필요한 범위에서 최소한의 개인정보를 수집합니다.<br>
② “몰”은 회원가입 시 구매계약이행에 필요한 정보를 미리 수집하지 않습니다. 다만, 관련 법령상 의무이행을 위하여 구매계약 이전에 본인확인이 필요한 경우로서 최소한의 특정 개인정보를 수집하는 경우에는 그러하지 아니합니다.<br>
③ “몰”은 이용자의 개인정보를 수집·이용하는 때에는 당해 이용자에게 그 목적을 고지하고 동의를 받습니다.<br>
④ “몰”은 수집된 개인정보를 목적 외의 용도로 이용할 수 없으며, 새로운 이용목적이 발생한 경우 또는 제3자에게 제공하는 경우에는 이용·제공단계에서 당해 이용자에게 그 목적을 고지하고 동의를 받습니다. 다만, 관련 법령에 달리 정함이 있는 경우에는 예외로 합니다.<br>
⑤ “몰”이 제2항과 제3항에 의해 이용자의 동의를 받아야 하는 경우에는 개인정보관리 책임자의 신원(소속, 성명 및 전화번호, 기타 연락처), 정보의 수집목적 및 이용목적, 제3자에 대한 정보 제공 관련사항(제공받은자, 제공목적 및 제공할 정보의 내용) 등 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」 제22조 제2항이 규정한 사항을 미리 명시하거나 고지해야 하며 이용자는 언제든지 이 동의를 철회할 수 있습니다.<br>
⑥ 이용자는 언제든지 “몰”이 가지고 있는 자신의 개인정보에 대해 열람 및 오류정정을 요구할 수 있으며 “몰”은 이에 대해 지체 없이 필요한 조치를 할 의무를 집니다. 이용자가 오류의 정정을 요구한 경우에는 “몰”은 그 오류를 정정할 때까지 당해 개인정보를 이용하지 않습니다.<br>
⑦ “몰”은 개인정보 보호를 위하여 이용자의 개인정보를 취급하는 자를 최소한으로 제한하여야 하며 신용카드, 은행 계좌 등을 포함한 이용자의 개인정보의 분실, 도난, 유출, 동의 없는 제3자 제공, 변조 등으로 인한 이용자의 손해에 대하여 모든 책임을 집니다.<br>
⑧ “몰” 또는 그로부터 개인정보를 제공받은 제3자는 개인정보의 수집목적 또는 제공받은 목적을 달성한 때에는 당해 개인정보를 지체 없이 파기합니다.<br>
⑨ “몰”은 개인정보의 수집·이용·제공에 관한 동의 란을 미리 선택한 것으로 설정해두지 않습니다. 또한 개인정보의 수집·이용·제공에 관한 이용자의 동의 거절 시 제한되는 서비스를 구체적으로 명시하고, 필수수집항목이 아닌 개인정보의 수집·이용·제공에 관한 이용자의 동의 거절을 이유로 회원가입 등 서비스 제공을 제한하거나 거절하지 않습니다.<br>
<br>
제18조 (“몰“의 의무)<br>
<br>
① “몰”은 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 이 약관이 정하는 바에 따라 지속적이고, 안정적으로 재화․용역을 제공하는 데 최선을 다하여야 합니다.<br>
② “몰”은 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 이용자의 개인정보(신용정보 포함)보호를 위한 보안 시스템을 갖추어야 합니다.<br>
③ “몰”이 상품이나 용역에 대하여 「표시․광고의 공정화에 관한 법률」 제3조 소정의 부당한 표시․광고행위를 함으로써 이용자가 손해를 입은 때에는 이를 배상할 책임을 집니다.<br>
④ “몰”은 이용자가 원하지 않는 영리 목적의 광고성 전자우편을 발송하지 않습니다.<br>
<br>
제19조 (회원의 ID 및 비밀번호에 대한 의무)<br>
<br>
① 제17조의 경우를 제외한 ID와 비밀번호에 관한 관리책임은 회원에게 있습니다.<br>
② 회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안 됩니다.<br>
③ 회원이 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 “몰”에 통보하고 “몰”의 안내가 있는 경우에는 그에 따라야 합니다.<br>
<br>
제20조 (이용자의 의무)<br>
<br>
이용자는 다음 행위를 하여서는 안 됩니다.<br>
 1. 신청 또는 변경 시 허위 내용의 등록<br>
 2. 타인의 정보 도용<br>
 3. “몰”에 게시된 정보의 변경<br>
 4. “몰”이 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시<br>
 5. “몰” 기타 제3자의 저작권 등 지적재산권에 대한 침해<br>
 6. “몰” 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위<br>
 7. 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 몰에 공개 또는 게시하는 행위<br>
<br>
제21조 (저작권의 귀속 및 이용 제한)<br>
<br>
① “몰“이 작성한 저작물에 대한 저작권 기타 지적재산권은 ”몰“에 귀속합니다.<br>
② 이용자는 “몰”을 이용함으로써 얻은 정보 중 “몰”에게 지적재산권이 귀속된 정보를 “몰”의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리 목적으로 이용하거나 제3자에게 이용하게 하여서는 안 됩니다.<br>
③ “몰”은 약정에 따라 이용자에게 귀속된 저작권을 사용하는 경우 당해 이용자에게 통보하여야 합니다.<br>
<br>
제22조 (분쟁 해결)<br>
<br>
① “몰”은 이용자가 제기하는 정당한 의견이나 불만을 반영하고 그 피해를 보상 처리하기 위하여 피해 보상처리기구를 설치․운영합니다.<br>
② “몰”은 이용자로부터 제출되는 불만 사항 및 의견은 우선적으로 그 사항을 처리합니다. 다만, 신속한 처리가 곤란한 경우에는 이용자에게 그 사유와 처리 일정을 즉시 통보해 드립니다.<br>
③ “몰”과 이용자 간에 발생한 전자상거래 분쟁과 관련하여 이용자의 피해구제신청이 있는 경우에는 공정거래위원회 또는 시·도지사가 의뢰하는 분쟁 조정기관의 조정에 따를 수 있습니다.<br>
<br>
제23조 (재판권 및 준거법)<br>
<br>
① “몰”과 이용자 간에 발생한 전자상거래 분쟁에 관한 소송은 제소 당시 이용자의 주소에 의하고, 주소가 없는 경우에는 거소를 관할하는 지방법원의 전속관할로 합니다. 다만, 제소 당시 이용자의 주소 또는 거소가 분명하지 않거나 외국 거주자의 경우에는 민사소송법상의 관할법원에 제기합니다.<br>
② “몰”과 이용자 간에 제기된 전자상거래 소송에는 한국법을 적용합니다.<br>
<br>
부칙<br>
<br>
이 약관은 &lt;사이트 개설일&gt;부터 시행합니다.</div>
                  ''',
                                                        ),
                                                      ),
                                                    ),
                                                isScrollControlled: true);
                                          },
                                          child: Text('내용',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .underline)))
                                    ]),
                                SizedBox(height: 15),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        Transform.scale(
                                            scale: 1.2,
                                            child: SizedBox(
                                                height: 16,
                                                width: 16,
                                                child: Checkbox(
                                                    shape: CircleBorder(),
                                                    checkColor: Colors.white,
                                                    activeColor:
                                                        Theme.of(context)
                                                            .accentColor,
                                                    value: terms[1],
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        terms[1] =
                                                            value ?? false;
                                                      });
                                                      _signupCubit.setTerms(
                                                          terms[0] && terms[1]);
                                                    }))),
                                        Text('    개인 정보 취급 방침 (필수)',
                                            style: TextStyle(fontSize: 16))
                                      ]),
                                      GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                                context: context,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        25),
                                                                topRight: Radius
                                                                    .circular(
                                                                        25))),
                                                builder: (context) => Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.7,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Html(data: '''
                  <div class="modal-body">
	회사명(이하 ‘회사’라 한다)는 개인정보 보호법 제30조에 따라 정보 주체의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리지침을 수립, 공개합니다.<br>
<br>
<strong>제1조 (개인정보의 처리목적)</strong><br>
회사는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보보호법 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.<br>
<br>
1. 홈페이지 회원 가입 및 관리<br>
회원 가입 의사 확인, 회원제 서비스 제공에 따른 본인 식별․인증, 회원자격 유지․관리, 제한적 본인확인제 시행에 따른 본인확인, 서비스 부정 이용 방지, 만 14세 미만 아동의 개인정보처리 시 법정대리인의 동의 여부 확인, 각종 고지․통지, 고충 처리 등을 목적으로 개인정보를 처리합니다.<br>
<br>
2. 재화 또는 서비스 제공<br>
물품 배송, 서비스 제공, 계약서 및 청구서 발송, 콘텐츠 제공, 맞춤서비스 제공, 본인인증, 연령인증, 요금 결제 및 정산, 채권추심 등을 목적으로 개인정보를 처리합니다.<br>
<br>
3. 고충 처리<br>
민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락․통지, 처리 결과 통보 등의 목적으로 개인정보를 처리합니다.<br>
<br>
<strong>제2조 (개인정보의 처리 및 보유기간)</strong><br>
① 회사는 법령에 따른 개인정보 보유, 이용 기간 또는 정보주체로부터 개인정보를 수집 시에 동의 받은 개인정보 보유, 이용 기간 내에서 개인정보를 처리, 보유합니다.<br>
② 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다.<br>
<br>
1. 홈페이지 회원 가입 및 관리 : 사업자/단체 홈페이지 탈퇴 시까지<br>
다만, 다음의 사유에 해당하는 경우에는 해당 사유 종료 시까지<br>
1) 관계 법령 위반에 따른 수사, 조사 등이 진행 중인 경우에는 해당 수사, 조사 종료 시까지<br>
2) 홈페이지 이용에 따른 채권 및 채무관계 잔존 시에는 해당 채권, 채무 관계 정산 시까지<br>
<br>
<!-- 쇼핑몰 또는 예약 결제를 받지 않는다면 삭제 --><br>
2. 재화 또는 서비스 제공 : 재화․서비스 공급완료 및 요금결제․정산 완료 시까지<br>
다만, 다음의 사유에 해당하는 경우에는 해당 기간 종료 시까지<br>
1) 「전자상거래 등에서의 소비자 보호에 관한 법률」에 따른 표시․광고, 계약내용 및 이행 등 거래에 관한 기록<br>
- 표시․광고에 관한 기록 : 6월<br>
- 계약 또는 청약 철회, 대금결제, 재화 등의 공급기록 : 5년<br>
- 소비자 불만 또는 분쟁 처리에 관한 기록 : 3년<br>
2) 「통신비밀보호법」 제41조에 따른 통신사실확인자료 보관<br>
- 가입자 전기통신일시, 개시․종료 시간, 상대방 가입자 번호, 사용도수, 발신기지국 위치추적자료 : 1년<br>
- 컴퓨터 통신, 인터넷 로그 기록자료, 접속지 추적자료 : 3개월<br>
<br>
<!-- 수정 필요. 개인정보 제3자 제공 사용하지 않는다면 삭제 --><br>
<strong>제3조 (개인정보의 제3자 제공)</strong><br>
① 회사는 정보주체의 개인정보를 제1조(개인정보의 처리목적)에서 명시한 범위 내에서만 처리하며, 정보주체의 동의, 법률의 특별한 규정 등 개인정보 보호법 제17조에 해당하는 경우에만 개인정보를 제3자에게 제공합니다.<br>
② 회사는 다음과 같이 개인정보를 제3자에게 제공하고 있습니다.<br>
- 개인정보를 제공받는 자 : &lt;예) (주) OOO 카드&gt;<br>
- 제공받는 자의 개인정보 이용목적 : &lt;예) 이벤트 공동개최 등 업무제휴 및 제휴 신용카드 발급&gt;<br>
- 제공하는 개인정보 항목 : &lt;예) 성명, 주소, 전화번호, 이메일주소, 카드결제계좌정보&gt;<br>
- 제공받는 자의 보유, 이용기간 : &lt;예) 신용카드 발급계약에 따른 거래기간동안&gt;<br>
<br>
<!-- 수정 필요. 개인정보처리 위탁 사용하지 않는다면 삭제 --><br>
<strong>제4조(개인정보처리의 위탁)</strong><br>
① 회사는 원활한 개인정보 업무처리를 위하여 다음과 같이 개인정보 처리업무를 위탁하고 있습니다.<br>
<br>
1. 전화 상담 센터 운영<br>
- 위탁받는 자 (수탁자) : OOO CS센터<br>
- 위탁하는 업무의 내용 : 전화상담 응대, 부서 및 직원 안내 등<br>
<br>
2. A/S 센터 운영<br>
- 위탁받는 자 (수탁자) : OOO 전자<br>
- 위탁하는 업무의 내용 : 고객 대상 제품 A/S 제공<br>
<br>
② 회사는 위탁계약 체결 시 개인정보 보호법 제25조에 따라 위탁업무 수행목적 외 개인정보 처리금지, 기술적․관리적 보호조치, 재위탁 제한, 수탁자에 대한 관리․감독, 손해배상 등 책임에 관한 사항을 계약서 등 문서에 명시하고, 수탁자가 개인정보를 안전하게 처리하는지를 감독하고 있습니다.<br>
③ 위탁업무의 내용이나 수탁자가 변경될 경우에는 지체없이 본 개인정보 처리방침을 통하여 공개하도록 하겠습니다.<br>
<br>
<strong>제5조(이용자 및 법정대리인의 권리와 그 행사 방법)</strong><br>
<br>
① 정보주체는 회사에 대해 언제든지 다음 각 호의 개인정보 보호 관련 권리를 행사할 수 있습니다.<br>
1. 개인정보 열람 요구<br>
2. 오류 등이 있을 경우 정정 요구<br>
3. 삭제요구<br>
4. 처리정지 요구<br>
② 제1항에 따른 권리 행사는 회사에 대해 서면, 전화, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며 회사는 이에 대해 지체없이 조치하겠습니다.<br>
③ 정보주체가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우에는 회사는 정정 또는 삭제를 완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다.<br>
④ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다. 이 경우 개인정보 보호법 시행규칙 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.<br>
⑤ 정보주체는 개인정보 보호법 등 관계 법령을 위반하여 회사가 처리하고 있는 정보주체 본인이나 타인의 개인정보 및 사생활을 침해하여서는 아니 됩니다.<br>
<br>
<!-- 사이트 운영 환경에 맞게 1항, 2항 수정 필요 --><br>
<strong>제6조(처리하는 개인정보 항목)</strong><br>
회사는 다음의 개인정보 항목을 처리하고 있습니다.<br>
<br>
1. 홈페이지 회원 가입 및 관리<br>
필수항목 : &lt;예) 성명, 생년월일, 아이디, 비밀번호, 주소, 전화번호, 성별, 이메일주소, 아이핀번호&gt;<br>
선택항목 : &lt;예) 결혼 여부, 관심 분야&gt;<br>
<br>
2. 재화 또는 서비스 제공<br>
필수항목 : &lt;예) 성명, 생년월일, 아이디, 비밀번호, 주소, 전화번호, 이메일주소, 아이핀번호, 신용카드번호, 은행계좌정보 등 결제정보&gt;<br>
선택항목 : &lt;관심분야, 과거 구매내역&gt;<br>
<br>
3. 인터넷 서비스 이용과정에서 아래 개인정보 항목이 자동으로 생성되어 수집될 수 있습니다.<br>
IP주소, 쿠키, MAC주소, 서비스 이용기록, 방문기록, 불량 이용기록 등<br>
<br>
<strong>제7조(개인정보의 파기)</strong><br>
① 회사는 개인정보 보유 기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다.<br>
② 정보주체로부터 동의받은 개인정보 보유 기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른 법령에 따라 개인정보를 계속 보존하여야 하는 경우에는, 해당 개인정보를 별도의 데이터베이스(DB)로 옮기거나 보관장소를 달리하여 보존합니다.<br>
③ 개인정보 파기의 절차 및 방법은 다음과 같습니다.<br>
1. 파기 절차<br>
회사는 파기 사유가 발생한 개인정보를 선정하고, 회사의 개인정보 보호책임자의 승인을 받아 개인정보를 파기합니다.<br>
2. 파기 방법<br>
회사는 전자적 파일 형태로 기록․저장된 개인정보는 기록을 재생할 수 없도록 로우레밸포멧(Low Level Format) 등의 방법을 이용하여 파기하며, 종이 문서에 기록․저장된 개인정보는 분쇄기로 분쇄하거나 소각하여 파기합니다.<br>
<br>
<strong>제8조(개인정보의 안전성 확보조치)</strong><br>
회사는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 하고 있습니다.<br>
1. 관리적 조치 : 내부관리계획 수립 및 시행, 정기적 직원 교육 등<br>
2. 기술적 조치 : 개인정보처리시스템 등의 접근 권한 관리, 접근통제시스템 설치, 고유 식별정보<br>
등의 암호화, 보안프로그램 설치<br>
3. 물리적 조치 : 전산실, 자료보관실 등의 접근통제<br>
<br>
<strong>제9조(개인정보 자동 수집 장치의 설치∙운영 및 거부에 관한 사항)</strong><br>
① 회사는 이용자에게 개별적인 맞춤 서비스를 제공하기 위해 이용정보를 저장하고 수시로 불러오는 ‘쿠키(cookie)’를 사용합니다.<br>
② 쿠키는 웹사이트를 운영하는데 이용되는 서버(http)가 이용자의 컴퓨터 브라우저에 보내는 소량의 정보이며 이용자들의 컴퓨터 내의 하드디스크에 저장되기도 합니다.<br>
가. 쿠키의 사용 목적: 이용자가 방문한 각 서비스와 웹 사이트들에 대한 방문 및 이용형태, 인기 검색어, 보안접속 여부, 등을 파악하여 이용자에게 최적화된 정보 제공을 위해 사용됩니다.<br>
나. 쿠키의 설치∙운영 및 거부 : 웹브라우저 상단의 도구&gt;인터넷 옵션&gt;개인정보 메뉴의 옵션 설정을 통해 쿠키 저장을 거부 할 수 있습니다.<br>
다. 쿠키 저장을 거부할 경우 맞춤형 서비스 이용에 어려움이 발생할 수 있습니다.<br>
<br>
<!-- 사이트 운영 환경에 맞게 수정 필요 --><br>
<strong>제10조(개인정보 보호책임자)</strong><br>
① 회사는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만 처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.<br>
<br>
▶ 개인정보 보호책임자<br>
성명 : OOO<br>
직책 : OOO<br>
연락처 : &lt;전화번호&gt;, &lt;이메일&gt;, &lt;팩스번호&gt;<br>
※ 개인정보 보호 담당부서로 연결됩니다.<br>
<br>
▶ 개인정보 보호 담당부서<br>
부서명 : OOO 팀<br>
담당자 : OOO<br>
연락처 : &lt;전화번호&gt;, &lt;이메일&gt;, &lt;팩스번호&gt;<br>
<br>
② 정보주체께서는 회사의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만 처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의하실 수 있습니다. 회사는 정보주체의 문의에 대해 지체없이 답변 및 처리해드릴 것입니다.<br>
<br>
<!-- 사이트 운영 환경에 맞게 수정 필요 --><br>
<strong>제11조(개인정보 열람청구)</strong><br>
정보주체는 개인정보 보호법 제35조에 따른 개인정보의 열람 청구를 아래의 부서에 할 수 있습니다. 회사는 정보주체의 개인정보 열람 청구가 신속하게 처리되도록 노력하겠습니다.<br>
<br>
▶ 개인정보 열람청구 접수․처리 부서<br>
부서명 : OOO<br>
담당자 : OOO<br>
연락처 : &lt;전화번호&gt;, &lt;이메일&gt;, &lt;팩스번호&gt;<br>
<br>
<strong>제12조(권익침해 구제 방법)</strong><br>
정보주체는 아래의 기관에 대해 개인정보 침해에 대한 피해구제, 상담 등을 문의하실 수 있습니다.<br>
<br>
▶ 개인정보 침해신고센터 (한국인터넷진흥원 운영)<br>
- 소관 업무 : 개인정보 침해사실 신고, 상담 신청<br>
- 홈페이지 : privacy.kisa.or.kr<br>
- 전화 : (국번없이) 118<br>
- 주소 : (58324) 전남 나주시 진흥길 9(빛가람동 301-2) 3층 개인정보침해신고센터<br>
<br>
▶ 개인정보 분쟁조정위원회<br>
- 소관업무 : 개인정보 분쟁조정신청, 집단분쟁조정 (민사적 해결)<br>
- 홈페이지 : www.kopico.go.kr<br>
- 전화 : (국번없이) 1833-6972<br>
- 주소 : (03171)서울특별시 종로구 세종대로 209 정부서울청사 4층<br>
<br>
▶ 대검찰청 사이버범죄수사단 : 02-3480-3573 (www.spo.go.kr)<br>
▶ 경찰청 사이버안전국 : 182 (http://cyberbureau.police.go.kr)<br>
<br>
<!-- 사이트 오픈일에 맞게 수정 필요 --><br>
<strong>제13조(개인정보 처리방침 시행 및 변경)</strong><br>
이 개인정보 처리방침은 20XX. X. X부터 적용됩니다.</div>
                  '''),
                                                      ),
                                                    ),
                                                isScrollControlled: true);
                                          },
                                          child: Text('내용',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .underline)))
                                    ])
                              ])),
                          SizedBox(height: 90)
                        ])))));
  }

  getUser() async {
    ApiResult<User> apiResult =
        await RepositoryProvider.of<UserRepository>(context).getUser();
    apiResult.when(
        success: (User? user) {
          _authBloc.emit(AuthenticationState.authenticated(user!));
        },
        failure: (NetworkExceptions? error) {});
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:krrng_client/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:krrng_client/support/style/format_unit.dart';
import 'package:krrng_client/support/style/theme.dart';

class SignupSecondStepPage extends StatefulWidget {
  @override
  _SignupSecondStepState createState() => _SignupSecondStepState();
}

class _SignupSecondStepState extends State<SignupSecondStepPage> {
  late SignupCubit _signupCubit;

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
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) => {
      setState(() {
        if(_timeCount <= 0){
          _timer.cancel();
          _timeCount = 180;
          _timerText = null;
        }else {
          if (_timer.isActive) {
            int minute = (_timeCount/60.floor()).toInt();
            String minuteString = minute > 0 ? "${minute}분" : "";
            String secondString = "${_timeCount - (minute *60)}초";
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

    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("휴대폰 인증", style: Theme.of(context).textTheme.headline3!),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
              child: TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                isCollapsed: true,
                contentPadding: InsetSymmetric15,
                enabledBorder: outline,
                focusedBorder: outline_focus,
                border: outline,
                hintText: '휴대폰 번호 입력하세요.'),
          )),
          SizedBox(width: 10),
          Container(
              width: 93,
              height: 44,
              child: ElevatedButton(
                  onPressed: () {
                    final phoneNumber = phoneController.text.trim();

                    if (isValidPhoneNumberFormat(phoneNumber)) {
                      if (_timerText == null) {
                        _signupCubit.requestCode(phoneNumber);
                        _startTimer();
                        codeFocusNode.requestFocus();
                      }
                    } else {
                      showDialog(
                          context: context,
                          barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text("핸드폰 번호를 확인해주세요."),
                              insetPadding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
                              actions: [
                                TextButton(
                                  child: const Text('확인'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    }

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _timerText == null ? primaryColor : dividerColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                  child: Text("인증요청",
                      style: TextStyle(color: Colors.white, fontSize: 16))))
        ]),
        const SizedBox(height: 10),
        TextFormField(
            controller: codeController,
            focusNode: codeFocusNode,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              _signupCubit.setInputCode(value);
            },
            decoration: InputDecoration(
                isCollapsed: true,
                contentPadding: InsetSymmetric15,
                enabledBorder: outline,
                focusedBorder: outline_focus,
                border: outline,
                suffix: Text(_timerText ?? "", style: font_16_w700.copyWith(color: primaryColor)),
                hintText: '인증 번호를 입력하세요.')),
        SizedBox(height: 30),
        GestureDetector(
            onTap: () {
              if (_signupCubit.state.phoneNumber != null) {
                var phoneNumber = _signupCubit.state.phoneNumber ?? "";
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
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                        fontWeight: FontWeight.w900))))
      ]),
      SizedBox(height: (size.height - 350) * 0.6),
      Container(
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
          decoration: BoxDecoration(
              color: Color(0xFFfbfbfb),
              border: Border.all(color: dividerColor, width: 1),
              borderRadius: BorderRadius.circular(12)),
          child: Column(children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Transform.scale(
                scale: 1.2,
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: Checkbox(
                      shape: CircleBorder(),
                      checkColor: Colors.white,
                      activeColor: Theme.of(context).accentColor,
                      value: terms[0] && terms[1],
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            terms = [true, true];
                          } else {
                            terms = [false, false];
                          }
                        });
                        _signupCubit.setTerms(terms[0] && terms[1]);
                      }
                  ),
                ),
              ),
              Text('    전체 동의', style: TextStyle(fontSize: 16)),
            ]),
            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                Transform.scale(
                    scale: 1.2,
                    child: SizedBox(
                        width: 16,
                        height: 16,
                        child: Checkbox(
                            shape: CircleBorder(),
                            checkColor: Colors.white,
                            activeColor: Theme.of(context).accentColor,
                            value: terms[0],
                            onChanged: (bool? value) {
                              setState(() {
                                terms[0] = value ?? false;
                              });
                              _signupCubit.setTerms(terms[0] && terms[1]);
                            }
                        ),
                    )),
                Text('    이용 약관(필수)', style: TextStyle(fontSize: 16))
              ]),
              GestureDetector(
                  onTap: () {},
                  child: Text('내용',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          decoration: TextDecoration.underline)))
            ]),
            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                Transform.scale(
                  scale: 1.2,
                  child: SizedBox(
                    height: 16,
                    width: 16,
                    child: Checkbox(
                        shape: CircleBorder(),
                        checkColor: Colors.white,
                        activeColor: Theme.of(context).accentColor,
                        value: terms[1],
                        onChanged: (bool? value) {
                          setState(() {
                            terms[1] = value ?? false;
                          });
                          _signupCubit.setTerms(terms[0] && terms[1]);
                        }
                    )
                  ),
                ),
                Text('    개인 정보 취급 방침 (필수)', style: TextStyle(fontSize: 16))
              ]),
              GestureDetector(
                  onTap: () {},
                  child: Text('내용',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          decoration: TextDecoration.underline)))
            ])
          ])),
      SizedBox(height: 90)
    ]);
  }
}

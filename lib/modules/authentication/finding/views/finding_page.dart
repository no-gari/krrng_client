import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/authentication/finding/cubit/finding_cubit.dart';
import 'package:krrng_client/modules/authentication/finding/views/finding_password_page.dart';
import 'package:krrng_client/support/style/format_unit.dart';
import 'package:krrng_client/support/style/theme.dart';
import 'package:vrouter/vrouter.dart';

import 'views.dart';

class FindingPage extends StatefulWidget {
  @override
  _FindingPageState createState() => _FindingPageState();
}

class _FindingPageState extends State<FindingPage> {

  final phoneController = TextEditingController();
  final idController = TextEditingController();
  FocusNode codeFocusNode = FocusNode();

  late FindingCubit _findingCubit;
  late String pageName;
  late Timer _timer;

  int _timeCount = 180;
  String? _timerText;

  @override
  void initState() {
    super.initState();
    _findingCubit = BlocProvider.of<FindingCubit>(context);
    pageName = _findingCubit.state.key == "id" ? "아이디" : "비밀번호";
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    idController.dispose();
    _timer.cancel();
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
    return BlocConsumer<FindingCubit, FindingState>(
        listenWhen: (previous, current) {
          return previous.isCompleteCode != current.isCompleteCode;
        },
        listener: (context, state) {
          if ((state.isCompleteCode ?? false) && state.error == null) {
            final key = _findingCubit.state.key;
            if (key == "id") {
              context.vRouter.to(FindingResultPage.routeName, queryParameters: {"userId": "${state.userId}"});
            } else {
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (_) => BlocProvider.value(value: _findingCubit, child: FindingPasswordPage())
                  ),
              );
            }
          } else {
            showDialog(
                context: context,
                barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("인증 번호를 확인해주세요."),
                    insetPadding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
                    actions: [
                      TextButton(
                        child: const Text('확인'),
                        onPressed: () {
                          _findingCubit.confirmError();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          }
        },
        builder: (context, state) {
          return Scaffold(
              bottomSheet: MaterialButton(
                  height: 75,
                  color: Colors.white,
                  elevation: 10,
                  onPressed: () {
                    if (state.code == null) {
                      showDialog(
                          context: context,
                          barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text("인증 번호를 확인해주세요."),
                              insetPadding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
                              actions: [
                                TextButton(
                                  child: const Text('확인'),
                                  onPressed: () {
                                    _findingCubit.confirmError();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    } else {
                      if (state.key == "id") {
                        _findingCubit.confirmCodeById();
                      } else if (state.key == "password") {
                        _findingCubit.confirmCodeByPassword();
                      }
                    }
                  },
                  minWidth: MediaQuery.of(context).size.width,
                  child: Text("확인", style: Theme.of(context).textTheme.headline3!.copyWith(color: primaryColor))),
              body: SafeArea(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      alignment: Alignment.centerRight,
                                      height: 54,
                                      child: IconButton(
                                          onPressed: () => {context.vRouter.pop()},
                                          icon: Icon(Icons.close))),
                                  Text("${pageName}를 찾기 위해 회원 가입 시\n사용하신 휴대폰 번호를 인증해 주세요",
                                      style: Theme.of(context).textTheme.headline3!.copyWith(height: 1.5)),
                                  const SizedBox(height: 10),
                                  state.key == "id" ? SizedBox() : Column(
                                    children: [
                                      Container(
                                          height: 44,
                                          child: TextFormField(
                                              controller: idController,
                                              decoration: InputDecoration(
                                                isCollapsed: true,
                                                contentPadding: InsetSymmetric15,
                                                enabledBorder: outline,
                                                focusedBorder: outline_focus,
                                                border: outline,
                                                hintText: '아이디를 입력하세요.',
                                              ))),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                              height: 44,
                                              child: TextFormField(
                                                  controller: phoneController,
                                                  keyboardType: TextInputType.phone,
                                                  decoration: InputDecoration(
                                                      isCollapsed: true,
                                                      contentPadding: InsetSymmetric15,
                                                      enabledBorder: outline,
                                                      focusedBorder: outline_focus,
                                                      border: outline,
                                                      hintText: '휴대폰 번호 입력하세요.'))),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Container(
                                              height: 44,
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    final phoneNumber = phoneController.text.trim();

                                                    if (isValidPhoneNumberFormat(phoneNumber)) {
                                                      final password = phoneNumber;

                                                      if (_timerText == null) {
                                                        if (state.key == "id") {
                                                          _findingCubit.requestCodeById(password);
                                                        } else if (state.key == "password") {
                                                          _findingCubit.requestCodeByPassword(idController.text.trim(), password);
                                                        }
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
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                                                  child: Text("인증요청", style: TextStyle(color: Colors.white)))),
                                        )
                                      ]),
                                  const SizedBox(height: 10),
                                  Container(
                                      height: 44,
                                      child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          focusNode: codeFocusNode,
                                          onChanged: (text) => _findingCubit.setCode(text),
                                          decoration: InputDecoration(
                                              isCollapsed: true,
                                              contentPadding: InsetSymmetric15,
                                              enabledBorder: outline,
                                              focusedBorder: outline_focus,
                                              border: outline,
                                              hintText: '인증 번호를 입력하세요.',
                                              suffix: Text(_timerText ?? "", style: font_16_w700.copyWith(color: primaryColor)),
                                          ))),
                                  SizedBox(height: 30),
                                  GestureDetector(
                                      onTap: () {
                                        final phoneNumber = state.phoneNumber;
                                        final userId = state.userId;

                                        if (phoneNumber != null) {
                                          if (state.key == "id") {
                                            _findingCubit.requestCodeById(phoneNumber);
                                          } else if (state.key == "password" && userId != null) {
                                            _findingCubit.requestCodeByPassword(userId, phoneNumber);
                                          }

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
                                          width: MediaQuery.of(context).size.width,
                                          alignment: Alignment.center,
                                          child: Text("인증번호 재전송",
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  decoration:
                                                  TextDecoration.underline,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold))))
                                ])
                          ]))));
        });
  }
}

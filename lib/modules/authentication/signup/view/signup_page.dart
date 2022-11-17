import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krrng_client/modules/authentication/signin/view/signin_screen.dart';
import 'package:krrng_client/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:krrng_client/support/style/theme.dart';
import 'package:vrouter/vrouter.dart';

import 'views.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late SignupCubit _signupCubit;

  List<Widget> _taps = [SignupFirstStepPage(), SignupSecondStepPage()];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _signupCubit = BlocProvider.of<SignupCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
        listenWhen: (previous, current) {
          return previous.isCompleteCode != current.isCompleteCode;
        },
        listener: (context, state) {
          final isCompletePassword = state.isCompletePassword ?? false;
          final isCompleteCode = state.isCompletePassword ?? false;

          if (isCompletePassword && isCompleteCode) {
            showDialog(
                context: context,
                barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("입력하신 정보로 회원가입을 하시겠습니까?"),
                    insetPadding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
                    actions: [
                      TextButton(
                        child: const Text('확인'),
                        onPressed: () {
                          _signupCubit.signup();
                          Navigator.of(context).pop();
                          context.vRouter.to(SigninScreen.routeName);
                        },
                      ),
                      TextButton(
                        child: const Text('취소'),
                        onPressed: () {
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
            onPressed: () {
              _formKey.currentState!.validate();
              if (state.selectedTap == 0) {
                if ((state.isCompletePassword ?? false) && (state.isNotDuplicateId ?? false)) {
                  _signupCubit.selectedTap(1);
                } else {
                  showDialog(
                      context: context,
                      barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("아이디, 비빌번호를 설정해주세요."),
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
              }

              if (state.selectedTap == 1) {
                if (state.inputCode == null) {
                  showDialog(
                      context: context,
                      barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("인증코드 및 약관을 확인해주세요."),
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
                } else {
                  _signupCubit.confirmCode(state.inputCode ?? "");
                }

              }
            },
            minWidth: MediaQuery.of(context).size.width,
            child: Text(state.selectedTap == 0 ? "다음" : "확인",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: primaryColor)),
            elevation: 10,
            color: Colors.white,
          ),
          body: SafeArea(
              child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(children: [
                    Stack(children: [
                      Align(
                          alignment: Alignment.center,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () =>
                                        _signupCubit.selectedTap(0),
                                    icon: state.selectedTap == 0
                                        ? SvgPicture.asset(
                                            'assets/icons/property1On.svg')
                                        : SvgPicture.asset(
                                            'assets/icons/property1Off.svg')),
                                IconButton(
                                    onPressed: () {
                                      if (state.selectedTap == 0 && (state.isCompletePassword ?? false) && (state.isNotDuplicateId ?? false)) {
                                        _signupCubit.selectedTap(1);
                                      } else {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: Text("아이디, 비빌번호를 설정해주세요."),
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
                                    icon: state.selectedTap == 1
                                        ? SvgPicture.asset(
                                            'assets/icons/property2On.svg')
                                        : SvgPicture.asset(
                                            'assets/icons/property2Off.svg'))
                              ])),
                      Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                              onPressed: () => {context.vRouter.pop()},
                              icon: Icon(Icons.close)))
                    ]),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: BlocProvider.value(
                          value: _signupCubit, child: _taps[state.selectedTap!]),
                    )
                  ]))));
    });
  }
}

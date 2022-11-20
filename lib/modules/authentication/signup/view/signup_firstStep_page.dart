import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:krrng_client/support/style/theme.dart';

class SignupFirstStepPage extends StatefulWidget {
  @override
  _SignupFirstStepPageState createState() => _SignupFirstStepPageState();
}

class _SignupFirstStepPageState extends State<SignupFirstStepPage> {
  late SignupCubit _signupCubit;

  final idController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _signupCubit = BlocProvider.of<SignupCubit>(context);

    if (_signupCubit.state.inputId != null) {
      idController.text = _signupCubit.state.inputId ?? "";
    }

    if (_signupCubit.state.inputPassword != null) {
      passwordController.text = _signupCubit.state.inputPassword ?? "";
      passwordConfirmController.text = _signupCubit.state.inputPassword ?? "";
    }
  }

  @override
  void dispose() {
    idController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listenWhen: (previous, current) {
         return previous.isNotDuplicateId != current.isNotDuplicateId;
      },
        listener: (context, state) {
          if (state.selectedTap == 0) {
          if (state.isNotDuplicateId ?? false) {
            showDialog(
                context: context,
                barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("사용 가능한 아이디입니다."),
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
            showDialog(
                context: context,
                barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("중복"),
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
     },
        builder: (context, state) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("아이디", style: font_18_w900),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 44,
                child: TextFormField(
                    controller: idController,
                    maxLength: 20,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    /* flutter TextInputFormatter 버그로 인해 주석
                    * (https://github.com/flutter/flutter/issues/96277)
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp('[a-z A-Z 0-9]'))
                    ],
                     */
                    decoration: InputDecoration(
                        isCollapsed: true,
                        contentPadding: InsetSymmetric15,
                        enabledBorder: outline,
                        focusedBorder: outline_focus,
                        border: outline,
                        hintText: '입력하세요. (4자~20자)',
                        counterText: "",
                    )),
              ),
            ),
            SizedBox(width: 10),
            Expanded(child: GestureDetector(
              onTap: () {
                if (idController.text.length >= 4) {
                  _signupCubit.duplicateId(idController.text);
                } else {
                  showDialog(
                      context: context,
                      barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("아이디는 최소 4자 이상 입력해주세요."),
                          insetPadding: const  EdgeInsets.fromLTRB(0,80,0, 80),
                          actions: [
                            TextButton(
                              child: const Text('확인'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      }
                  );
                }
              },
                child: Container(
                    height: 44,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                        color:   primaryColor
                    ),
                    alignment: Alignment.center,
                    child: Text("중복 확인", style: font_16_w700.copyWith(color: Colors.white)))
            )
            ),
          ],
        ),
        const SizedBox(height: 30),
        Text("비밀번호", style: font_18_w900),
        const SizedBox(height: 10),
        Container(
          height: 66,
          child: TextFormField(
              controller: passwordController,
              maxLength: 20,
              obscureText: true,
              validator: (value) {
                final text = value ?? "";
                if (text.length >= 6 && text.length <= 20) {
                  return null;
                } else {
                  return '비밀번호를 입력해 주세요. (6자~20자)';
                }
              },
              decoration: InputDecoration(
                  isCollapsed: true,
                  contentPadding: InsetSymmetric15,
                  enabledBorder: outline,
                  focusedBorder: outline_focus,
                  border: outline,
                  hintText: '비밀번호를 입력 해주세요.',
                  counterText: "",
              )),
        ),
        const SizedBox(height: 10),
        Text("비밀번호 확인", style: Theme.of(context).textTheme.headline3!),
        const SizedBox(height: 10),
        Container(
            height: 66,
            child: TextFormField(
                controller: passwordConfirmController,
                maxLength: 20,
                obscureText: true,
                validator: (value) {
                  final confirm = (value ?? "");
                  final password = (passwordController.text ?? "");

                  if (confirm == password) {
                    return null;
                  } else {
                    return '비밀번호를 확인해주세요.';
                  }
                  },
                onChanged: (text) {
                  print(text);
                  if (text == passwordController.text) {
                    _signupCubit.completePassword(true, text);
                  } else {
                    _signupCubit.completePassword(false, text);
                  }
                },
                decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding: InsetSymmetric15,
                    enabledBorder: outline,
                    focusedBorder: outline_focus,
                    border: outline,
                    hintText: '비밀번호를 확인 해주세요.',
                    counterText: ""
                )))
      ]);
    });
  }
}

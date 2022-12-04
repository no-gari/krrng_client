import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/authentication/finding/cubit/finding_cubit.dart';
import 'package:krrng_client/modules/authentication/signin/view/signin_screen.dart';
import 'package:krrng_client/support/style/theme.dart';
import 'package:vrouter/vrouter.dart';

import 'views.dart';

class FindingPasswordPage extends StatefulWidget {

  @override
  _FindingNewPasswordState createState() => _FindingNewPasswordState();
}

class _FindingNewPasswordState extends State<FindingPasswordPage> {

  final _formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  late FindingCubit _findingCubit;

  @override
  void initState() {
    super.initState();
    _findingCubit = BlocProvider.of<FindingCubit>(context);
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FindingCubit, FindingState>(
      listener: (context, state) {
        if (state.isCompletePassword ?? false) {
          context.vRouter.to(SigninScreen.routeName, isReplacement: true);
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        height: 44,
                        child: IconButton(
                            onPressed: () => context.vRouter.to(SigninScreen.routeName, isReplacement: true),
                            icon: Icon(Icons.close)
                        ),
                      ),
                      Text("새로운 비밀번호", style: Theme.of(context).textTheme.headline3!),
                      const SizedBox(height: 10),
                      Container(
                          height: 66,
                          child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              maxLength: 20,
                              validator: (value) {
                                final text = value ?? "";
                                if (text.length >= 6 && text.length <= 20) {
                                  return null;
                                } else {
                                  return '비밀번호를 입력해 주세요. (6자~20자)';
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: InsetSymmetric15,
                                enabledBorder: outline,
                                focusedBorder: outline_focus,
                                border: outline,
                                hintText: '새로운 비밀번호를 입력하세요',
                                counterText: ""
                              ))
                      ),
                      const SizedBox(height: 30),
                      Text("새로운 비밀번호 확인", style: Theme.of(context).textTheme.headline3!),
                      const SizedBox(height: 10),
                      Container(
                          height: 66,
                          child: TextFormField(
                              controller: passwordConfirmController,
                              obscureText: true,
                              maxLength: 20,
                              validator: (value) {
                                final text = value ?? "";
                                if (text.trim() == passwordController.text.trim()) {
                                  return null;
                                } else {
                                  return '동일하게 비밀번호를 입력해 주세요. (6자~20자)';
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: InsetSymmetric15,
                                enabledBorder: outline,
                                focusedBorder: outline_focus,
                                border: outline,
                                hintText: '새로운 비밀번호를 동일하게 입력하세요',
                                counterText: ""
                              ))
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomSheet: MaterialButton(
                onPressed: () {
                  final password = passwordController.text.trim();
                  final passwordConfirm = passwordConfirmController.text.trim();

                  if (( _formKey.currentState?.validate() ?? false) && (password == passwordConfirm)) {
                    _findingCubit.changePasswordPassword(password);
                  } else {
                    showDialog(
                        context: context,
                        barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text("비밀번호를 확인해주세요."),
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
                minWidth: MediaQuery.of(context).size.width,
                child: Text("완료", style: Theme.of(context).textTheme.headline3!.copyWith(color: primaryColor))
            ),
          );
      }
    );
  }
}
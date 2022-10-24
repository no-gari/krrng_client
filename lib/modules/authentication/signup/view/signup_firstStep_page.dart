import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:krrng_client/support/style/theme.dart';

class SignupFirstStepPage extends StatefulWidget {
  @override
  _SignupFirstStepPageState createState() => _SignupFirstStepPageState();
}

class _SignupFirstStepPageState extends State<SignupFirstStepPage> {
  late SignupCubit _signupCubit;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  @override
  void initState() {
    _signupCubit = BlocProvider.of<SignupCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(builder: (context, state) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("이메일", style: Theme.of(context).textTheme.headline3!),
        const SizedBox(height: 10),
        Container(
          height: 44,
          child: TextFormField(
              controller: emailController,
              autofocus: true,
              decoration: InputDecoration(
                  isCollapsed: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: dividerColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: primaryColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: dividerColor)),
                  hintText: '이메일을 입력 해주세요.')),
        ),
        const SizedBox(height: 30),
        Text("비밀번호", style: Theme.of(context).textTheme.headline3!),
        const SizedBox(height: 10),
        Container(
          height: 44,
          child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  isCollapsed: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: dividerColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: primaryColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: dividerColor)),
                  hintText: '비밀번호를 입력 해주세요.')),
        ),
        const SizedBox(height: 30),
        Text("비밀번호 확인", style: Theme.of(context).textTheme.headline3!),
        const SizedBox(height: 10),
        Container(
            height: 44,
            child: TextFormField(
                controller: passwordConfirmController,
                obscureText: true,
                decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: dividerColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: primaryColor)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: dividerColor)),
                    hintText: '비밀번호를 확인 해주세요.')))
      ]);
    });
  }
}

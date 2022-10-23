import 'package:flutter_svg/flutter_svg.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/modules/authentication/finding/views/views.dart';
import 'package:krrng_client/modules/authentication/signin/cubit/signin_cubit.dart';
import 'package:krrng_client/modules/authentication/signup/view/signup_screen.dart';
import 'package:krrng_client/modules/main/main_screen.dart';
import 'package:krrng_client/repositories/authentication_repository/authentication_repository.dart';
import 'package:krrng_client/support/style/format_unit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:krrng_client/support/style/theme.dart';
import 'package:vrouter/vrouter.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late SignInCubit _signInCubit;
  bool selectedAutoLogin = true;

  @override
  void initState() {
    super.initState();
    _signInCubit = BlocProvider.of<SignInCubit>(context);
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) async {
            if (state.status == AuthenticationStatus.authenticated) {
              context.vRouter.to(MainScreen.routeName, isReplacement: true);
            }
          },
          child: BlocListener<SignInCubit, SignInState>(
              listener: (context, state) async {
                if (state.errorMessage != null &&
                    state.errorMessage!.length > 0) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("이메일 혹은 비밀번호를 확인해 주세요."),
                  ));
                  context.read<SignInCubit>().errorMsg();
                }
              },
              child:  Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.13),
                child: Center(
                  child: FractionallySizedBox(
                    heightFactor: 0.6,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/login_logo.svg',
                                  semanticsLabel: "login_login",
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  height: 44,
                                  child: TextFormField(
                                      controller: emailController,
                                      autofocus: true,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12.0),
                                              borderSide: BorderSide(color: dividerColor)
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12.0),
                                              borderSide: BorderSide(color: primaryColor)
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12.0),
                                              borderSide: BorderSide(color: dividerColor)
                                          ),
                                          hintText: '아이디를 입력하세요')),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 44,
                                  child: TextFormField(
                                      controller: passwordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12.0),
                                              borderSide: BorderSide(color: dividerColor)
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12.0),
                                              borderSide: BorderSide(color: primaryColor)
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12.0),
                                              borderSide: BorderSide(color: dividerColor)
                                          ),
                                          hintText: '비밀번호를 입력하세요.')),
                                ),
                                const SizedBox(height: 13),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => {
                                        setState( () {
                                          selectedAutoLogin = !selectedAutoLogin;
                                        })
                                      },
                                      icon: selectedAutoLogin ? SvgPicture.asset('assets/images/checkBox_on.svg')
                                          : SvgPicture.asset('assets/images/checkBox_off.svg'),
                                      iconSize: 22,
                                    ),
                                    Text('자동 로그인', style: Theme.of(context).textTheme.bodyText2!)
                                  ],
                                ),
                                GestureDetector(
                                    onTap: () {
                                      if (emailController.text.trim() != '' &&
                                          passwordController.text.trim() != '') {
                                        _signInCubit.signInWithEmail(
                                            email: emailController.text,
                                            password: passwordController.text);
                                      }
                                    },
                                    child: Container(
                                        width: maxWidth(context),
                                        height: 48,
                                        decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius: BorderRadius.circular(12)),
                                        child: Center(
                                            child: Text("로그인",
                                                style: Theme
                                                    .of(context).textTheme.headline5!.copyWith(color: Colors.white))))),
                                const SizedBox(height: 26),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                        onTap: () =>
                                            context.vRouter.to(FindingScreen.routeName, isReplacement: true),
                                        child: Text('아이디 찾기', style: Theme.of(context).textTheme.bodyText2!)
                                    ),
                                    _TextRowSpacing(),
                                    GestureDetector(
                                        onTap: () => {
                                          context.vRouter.to(FindingScreen.routeName, isReplacement: true),
                                        },
                                        child: Text('비밀번호 찾기', style: Theme.of(context).textTheme.bodyText2!)
                                    ),
                                    _TextRowSpacing(),
                                    GestureDetector(
                                        onTap: () => context.vRouter.to(SignupScreen.routeName, isReplacement: true),
                                        child: Text('회원가입', style: Theme.of(context).textTheme.bodyText2!)
                                    )
                                  ],
                                ),
                              ]
                          ),
                          Column(
                            children: [
                              Text("SNS 로그인"),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(backgroundColor: Colors.amber),
                                  const SizedBox(width: 20),
                                  CircleAvatar(backgroundColor: Colors.black)
                                ],
                              )
                            ],
                          )
                        ]),
                  ),
                ),
              )
          ),
        ));
  }

  Widget _TextRowSpacing() {
    return Row(
      children: [
        SizedBox(width: 13),
        Text('|'),
        SizedBox(width: 13),
      ],
    );
  }
}
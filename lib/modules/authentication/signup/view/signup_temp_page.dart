import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/modules/authentication/signin/cubit/signin_cubit.dart';
import 'package:krrng_client/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:krrng_client/modules/main/main_screen.dart';
import 'package:krrng_client/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:krrng_client/repositories/user_repository/models/user.dart';
import 'package:krrng_client/repositories/user_repository/src/user_repository.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:vrouter/vrouter.dart';

class SignupTempPage extends StatefulWidget {
  @override
  _SignupTempPageState createState() => _SignupTempPageState();
}

class _SignupTempPageState extends State<SignupTempPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  late SignupCubit _signupCubit;
  late AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _signupCubit = BlocProvider.of<SignupCubit>(context);
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
  }

  @override
  void dispose() {
    passwordConfirmController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void getUser() async {
    ApiResult<User> apiResult =
        await RepositoryProvider.of<UserRepository>(context).getUser();
    apiResult.when(success: (User? user) {
      _authenticationBloc.emit(AuthenticationState.authenticated(user!));
    }, failure: (NetworkExceptions? error) {
      _authenticationBloc.emit(AuthenticationState.unauthenticated());
    });
  }

  @override
  Widget build(BuildContext context) {
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
            child: BlocListener<SignupCubit, SignupState>(
                listener: (context, state) async {
                  if (state.errorMessage != null &&
                      state.errorMessage!.length > 0) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("이메일 혹은 비밀번호를 확인해 주세요."),
                    ));
                    _signupCubit
                        .emit(state.copyWith(error: null, errorMessage: null));
                  }
                },
                child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('회원가입',
                              style: Theme.of(context).textTheme.headline3),
                          const SizedBox(height: 30),
                          const Text("아이디"),
                          TextFormField(
                              controller: emailController,
                              autofocus: true,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  hintText: '아이디를 입력 해주세요.')),
                          const SizedBox(height: 20),
                          const Text("비밀번호"),
                          TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  hintText: '비밀번호를 입력 해주세요.')),
                          const SizedBox(height: 20),
                          const Text("비밀번호 확인"),
                          TextFormField(
                              controller: passwordConfirmController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  hintText: '비밀번호를 확인 해주세요.')),
                          const SizedBox(height: 30),
                          GestureDetector(
                              onTap: () async {
                                if (passwordController.text !=
                                    passwordConfirmController.text) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("비밀번호가 서로 일치하지 않습니다.")));
                                } else {
                                  if (emailController.text.trim() != '' &&
                                      passwordController.text.trim() != '') {
                                    await _signupCubit.signupTemp(
                                        emailController.text,
                                        passwordController.text);
                                    getUser();
                                    context.vRouter.to(MainScreen.routeName);
                                  }
                                }
                              },
                              child: Container(
                                  width: maxWidth(context),
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                      child: Text("회원가입",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(color: Colors.white)))))
                        ])))));
  }
}

double maxWidth(context) {
  return MediaQuery.of(context).size.width;
}

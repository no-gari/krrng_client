import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  List<Widget> _taps = [
    SignupFirstStepPage(),
    SignupSecondStepPage()
  ];

  @override
  void initState() {
    super.initState();
    _signupCubit = BlocProvider.of<SignupCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocBuilder<SignupCubit, SignupState>(
        builder: (context, state) {
          return Scaffold(
            bottomSheet: MaterialButton(
              onPressed: () => {
                if (state.selectedTap == 0) {
                  _signupCubit.selectedTap(1)
                }
                else {  // TODO 비번 변경 완료
                  context.vRouter.pop()
                }},
              minWidth: size.width,
              child: Text(state.selectedTap == 0 ? "다음" : "확인",
                style: Theme.of(context).textTheme.headline3!.copyWith(color: primaryColor)
            ),
          ),
          body: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        height: size.height*0.05,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () => { _signupCubit.selectedTap(0) },
                                      icon: state.selectedTap == 0 ? SvgPicture.asset('assets/icons/property1On.svg') : SvgPicture.asset('assets/icons/property1Off.svg')),
                                  IconButton(
                                      onPressed: () => { _signupCubit.selectedTap(1) },
                                      icon: state.selectedTap == 1 ? SvgPicture.asset('assets/icons/property1On.svg') : SvgPicture.asset('assets/icons/property1Off.svg')),
                                ],
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                    onPressed: () => { context.vRouter.pop() },
                                    icon: Icon(Icons.close)
                                )
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      BlocProvider.value(value: _signupCubit, child: _taps[state.selectedTap!]),
                    ],
                  )
              )
          ),
          );
        });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krrng_client/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:krrng_client/support/style/theme.dart';

class SignupSecondStepPage extends StatefulWidget {
  @override
  _SignupSecondStepState createState() => _SignupSecondStepState();
}

class _SignupSecondStepState extends State<SignupSecondStepPage> {

  late SignupCubit _signupCubit;

  final phoneController = TextEditingController();

  @override
  void initState() {
    _signupCubit = BlocProvider.of<SignupCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          width: size.width,
          height: size.height * 0.23,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("휴대폰 인증", style: Theme.of(context).textTheme.headline3!),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width*0.61,
                      height: 44,
                      child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
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
                              hintText: '휴대폰 번호 입력하세요.')),
                    ),
                    Container(
                      width: size.width * 0.24,
                      height: 44,
                      child: ElevatedButton(
                          onPressed: () => {

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                          child: Text("인증요청", style: TextStyle(color: Colors.white))
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  height: 44,
                  child: TextFormField(
                      keyboardType: TextInputType.number,
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
                          hintText: '인증 번호를 입력하세요.')),
                ),
                SizedBox(height: size.height * 0.03),
                GestureDetector(
                  onTap: () => {

                  },
                  child: Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: Text("인증번호 재전송",
                      style: TextStyle(color: primaryColor, decoration: TextDecoration.underline),
                    ),
                  ),
                ),

              ]
          ),
        ),
        Container(
            width: size.width,
            height: size.height*0.2,
            decoration: BoxDecoration(
                color: Color(0xFFfbfbfb),
                border: Border.all(color: dividerColor, width: 1),
                borderRadius: BorderRadius.circular(12)
            ),
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 5),
                shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 0,
                  title: Text("전체 동의", style: Theme.of(context).textTheme.bodyText1!),
                  leading: SvgPicture.asset('assets/images/checkBox_off.svg'),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  horizontalTitleGap: 0,
                  title: Text("이용 약관(필수)", style: Theme.of(context).textTheme.bodyText1!),
                  trailing: Text("내용", style: Theme.of(context).textTheme.bodyText1!),
                  leading: SvgPicture.asset('assets/images/checkBox_off.svg'),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  horizontalTitleGap: 0,
                  title: Text("개인 정보 취급 방침 (필수)", style: Theme.of(context).textTheme.bodyText1!),
                  trailing: Text("내용", style: Theme.of(context).textTheme.bodyText1!),
                  leading: SvgPicture.asset('assets/images/checkBox_off.svg'),
                )
              ],
            )
        )
      ],
    );
  }
}
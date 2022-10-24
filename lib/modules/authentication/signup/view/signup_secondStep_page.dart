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
  var allCheck = false;
  var termsCheck = false;
  var personalCheck = false;

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
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: dividerColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: primaryColor)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: dividerColor)),
                hintText: '휴대폰 번호 입력하세요.'),
          )),
          SizedBox(width: 10),
          Container(
              width: 93,
              height: 44,
              child: ElevatedButton(
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                  child: Text("인증요청",
                      style: TextStyle(color: Colors.white, fontSize: 16))))
        ]),
        const SizedBox(height: 10),
        TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                isCollapsed: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: dividerColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: primaryColor)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: dividerColor)),
                hintText: '인증 번호를 입력하세요.')),
        SizedBox(height: 30),
        GestureDetector(
            onTap: () => {},
            child: Container(
                width: size.width,
                alignment: Alignment.center,
                child: Text("인증번호 재전송",
                    style: TextStyle(
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                        fontWeight: FontWeight.bold))))
      ]),
      SizedBox(height: 260),
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
                      value: allCheck,
                      onChanged: (bool? value) => setState(() {
                            if (value == true) {
                              allCheck = true;
                              termsCheck = true;
                              personalCheck = true;
                            } else {
                              allCheck = false;
                              termsCheck = false;
                              personalCheck = false;
                            }
                          })),
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
                        value: termsCheck,
                        onChanged: (bool? value) =>
                            setState(() => termsCheck = value!)),
                  ),
                ),
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
                        value: personalCheck,
                        onChanged: (bool? value) =>
                            setState(() => personalCheck = value!)),
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
          ]))
    ]);
  }
}

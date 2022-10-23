import 'package:flutter/material.dart';
import 'package:krrng_client/support/style/theme.dart';
import 'package:vrouter/vrouter.dart';

import 'views.dart';

class FindingPage extends StatefulWidget {
  @override
  _FindingPageState createState() => _FindingPageState();
}

class _FindingPageState extends State<FindingPage> {
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      bottomSheet: MaterialButton(
        onPressed: () => {
          context.vRouter.to(FindingResultPage.routeName)
        },
        minWidth: size.width,
        child: Text("확인",
            style: Theme.of(context).textTheme.headline3!.copyWith(color: primaryColor)
        ),
      ),
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
                    height: size.height*0.05,
                    child: IconButton(
                        onPressed: () => {
                          context.vRouter.pop()
                        }, icon: Icon(Icons.close)),
                  ),
                  Text("아이디를 찾기 위해 회원 가입 시\n사용하신 휴대폰 번호를 인증해 주세요",
                    style: Theme.of(context).textTheme.headline3!.copyWith(height: 1.5),
                  ),
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
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
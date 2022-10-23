import 'package:flutter/material.dart';
import 'package:krrng_client/modules/authentication/signin/view/signin_screen.dart';
import 'package:krrng_client/support/style/theme.dart';
import 'package:vrouter/vrouter.dart';

class FindingResultPage extends StatefulWidget {
  static String routeName = "/finding/result";

  @override
  _FindingEmailResultState createState() => _FindingEmailResultState();
}

class _FindingEmailResultState extends State<FindingResultPage> {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                height: size.height*0.05,
                child: IconButton(
                    onPressed: () => {
                      context.vRouter.to(SigninScreen.routeName, isReplacement: true)
                    }, icon: Icon(Icons.close)),
              ),
              Text("아이디를 확인해주세요.",
                style: Theme.of(context).textTheme.headline3!,
              ),
              const SizedBox(height: 10),
              Text("Irene0909",
                style: Theme.of(context).textTheme.headline3!.copyWith(color: primaryColor),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 44,
                    width: size.width * 0.43,
                    child: ElevatedButton(
                        onPressed: () => {

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                        child: Text("로그인", style: TextStyle(color: Colors.white))
                    ),
                  ),
                  Container(
                    height: 44,
                    width: size.width * 0.43,
                    child: ElevatedButton(
                        onPressed: () => {
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: dividerColor),
                          ),
                        ),
                        child: Text("비밀번호 찾기", style: TextStyle(color: primaryColor))
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:krrng_client/modules/authentication/signin/view/signin_screen.dart';
import 'package:krrng_client/support/style/theme.dart';
import 'package:vrouter/vrouter.dart';

import 'views.dart';

class FindingResultPage extends StatefulWidget {
  static String routeName = "/finding/result";

  @override
  _FindingEmailResultState createState() => _FindingEmailResultState();
}

class _FindingEmailResultState extends State<FindingResultPage> {

  late String userId;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final findingId = context.vRouter.queryParameters["userId"];
    if (findingId != null) {
      setState(() {
        userId = findingId;
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                height: 44,
                child: IconButton(
                    onPressed: () => context.vRouter.to(SigninScreen.routeName, isReplacement: true),
                    icon: Icon(Icons.close)
                ),
              ),
              Text("아이디를 확인해주세요.",
                style: Theme.of(context).textTheme.headline3!,
              ),
              const SizedBox(height: 10),
              Text("${userId}",
                style: Theme.of(context).textTheme.headline3!.copyWith(color: primaryColor),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 44,
                      child: ElevatedButton(
                          onPressed: () => context.vRouter.to(SigninScreen.routeName, isReplacement: true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                          child: Text("로그인", style: TextStyle(color: Colors.white))
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 44,
                      child: ElevatedButton(
                          onPressed: () => context.vRouter.to(FindingScreen.routeName, isReplacement: true, queryParameters: {"key":"password"}),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: dividerColor),
                            ),
                          ),
                          child: Text("비밀번호 찾기", style: TextStyle(color: primaryColor))
                      ),
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
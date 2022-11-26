import 'package:krrng_client/modules/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(scrollDirection: Axis.horizontal, children: [
          Container(
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).accentColor,
              child: Expanded(child: Image.asset('assets/images/splash.png'))),
          Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Expanded(child: Image.asset('assets/images/splash2.png'))),
          Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Expanded(child: Image.asset('assets/images/splash3.png')))
        ]),
        bottomNavigationBar: InkWell(
            onTap: () =>
                context.vRouter.to(MainScreen.routeName, isReplacement: true),
            child: Container(
                height: 65,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    border:
                        Border(top: BorderSide(color: Colors.grey, width: 1))),
                child: Text('건너뛰기',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).accentColor)))));
  }
}

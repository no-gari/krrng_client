import 'package:kakao_flutter_sdk/kakao_flutter_sdk_share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class InvitePage extends StatefulWidget {
  const InvitePage({Key? key}) : super(key: key);

  @override
  State<InvitePage> createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  bool? isKakaoTalkSharingAvailable;
  String? query;
  String? smsUri;
  String? emailUri;

  @override
  void initState() {
    super.initState();
    isKakaoShareAvailable();
  }

  isKakaoShareAvailable() async {
    isKakaoTalkSharingAvailable =
        await ShareClient.instance.isKakaoTalkSharingAvailable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              Center(
                  child: Padding(
                      padding: EdgeInsets.only(top: 0, bottom: 10),
                      child: Text('지금 크르릉이 필요한\n친구들을 초대해보세요.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w900)))),
              Text('앱을 공유하고 위치기반으로 주변 동물병원\n병원비를 저렴하게 사용할 수 있다고 알려주세요',
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
              SizedBox(height: 50),
              Image.asset('assets/images/invite.png'),
              SizedBox(height: 75),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                GestureDetector(
                    onTap: () async {
                      if (isKakaoTalkSharingAvailable!) {
                        try {
                          Uri uri = await ShareClient.instance
                              .shareDefault(template: defaultFeed);
                          await ShareClient.instance.launchKakaoTalk(uri);
                          print('카카오톡 공유 완료');
                        } catch (error) {
                          print('카카오톡 공유 실패 $error');
                        }
                      } else {
                        try {
                          Uri shareUrl = await WebSharerClient.instance
                              .makeDefaultUrl(template: defaultFeed);
                          await launchBrowserTab(shareUrl, popupOpen: true);
                        } catch (error) {
                          print('카카오톡 공유 실패 $error');
                        }
                      }
                    },
                    child: SvgPicture.asset('assets/icons/kakao-share.svg')),
                SizedBox(width: 23),
                GestureDetector(
                    onTap: () async {
                      smsUri = Platform.isIOS
                          ? Uri.encodeFull(
                              "sms:''&body=반려동물 진료비 고민 될 땐? 크르릉! https://onelink.to/82ttrz")
                          : Uri.encodeFull(
                              "sms:''?body=반려동물 진료비 고민 될 땐? 크르릉! https://onelink.to/82ttrz");
                      launch(smsUri!);
                    },
                    child: SvgPicture.asset('assets/icons/sms.svg')),
                SizedBox(width: 23),
                GestureDetector(
                    onTap: () async {
                      emailUri = Uri.encodeFull(
                          "mailto:''?subject=크르릉 앱 다운로드 받으세요!&body=반려동물 진료비 고민 될 땐? 크르릉! https://onelink.to/82ttrz");
                      launch(emailUri!);
                    },
                    child: SvgPicture.asset('assets/icons/mail.svg')),
                SizedBox(width: 23),
                GestureDetector(
                    onTap: () => Clipboard.setData(
                            ClipboardData(text: 'https://onelink.to/82ttrz'))
                        .then((_) => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("링크가 복사되었습니다.")))),
                    child: SvgPicture.asset('assets/icons/link-share.svg'))
              ]),
              SizedBox(height: AppBar().preferredSize.height + 20)
            ]))));
  }

  final defaultFeed = FeedTemplate(
      content: Content(
          title: "반려동물 진료비 고민 될 때에는? 크르릉!",
          description: "#반려동물 #동물병원 #진료비",
          imageUrl: Uri.parse(
              "https://t1.daumcdn.net/cfile/tistory/24283C3858F778CA2E"),
          link: Link(
              webUrl: Uri.parse('https://onelink.to/82ttrz'),
              mobileWebUrl: Uri.parse('https://onelink.to/82ttrz'))),
      buttons: [
        Button(
            title: '앱 다운로드',
            link: Link(
                webUrl: Uri.parse('https://onelink.to/82ttrz'),
                mobileWebUrl: Uri.parse('https://onelink.to/82ttrz')))
      ]);
}

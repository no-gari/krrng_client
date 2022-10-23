import 'package:flutter/material.dart';
import 'package:krrng_client/modules/delete_account/delete_account_result_screen.dart';
import 'package:vrouter/vrouter.dart';

class DeleteAccountScreen extends StatelessWidget {
  static const String routeName = '/delete-account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('회원 탈퇴', style: Theme.of(context).textTheme.headline2),
            centerTitle: false),
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(12)),
                          margin: EdgeInsets.symmetric(vertical: 20),
                          padding: EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image.asset('assets/images/head.png',
                                      width: 40),
                                  SizedBox(width: 10.5),
                                  Text('계정 비활성화 및 삭제 시 주의사항.',
                                      style: TextStyle(fontSize: 13))
                                ])
                              ])),
                      SizedBox(height: 10),
                      Text('유의사항',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      SizedBox(height: 14),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 16),
                          decoration: BoxDecoration(
                              color: Color(0xFFFBFBFB),
                              border: Border.all(color: Color(0xFFDFE2E9)),
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                              '사용하고 계신 계정은 탈퇴가 완료 될 경우 복구가 불가하니 유의 부탁드립니다.\n탈퇴가 완료될 경우 앱 이용내역이(리뷰내역, 반려동물  내역 등) 삭제되며 복구가 불가능합니다.',
                              style: TextStyle(fontSize: 14))),
                      SizedBox(height: 30),
                      Text('회원 탈퇴 진행 방법',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      SizedBox(height: 14),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 16),
                          decoration: BoxDecoration(
                              color: Color(0xFFFBFBFB),
                              border: Border.all(color: Color(0xFFDFE2E9)),
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                              '회원 탈퇴 선택 시 불법도용 및 불이익에 대한 피해를 방지하고자 회원가입 시 진행된 휴대폰인증 절차가 진행됩니다.\n\n휴대폰인증 완료 후 회원탈퇴 신청이 진행 됩니다.',
                              style: TextStyle(fontSize: 14))),
                      SizedBox(height: 30),
                      Text('회원 탈퇴 대기기간 안내',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      SizedBox(height: 14),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 16),
                          decoration: BoxDecoration(
                              color: Color(0xFFFBFBFB),
                              border: Border.all(color: Color(0xFFDFE2E9)),
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                              '인증 완료 후 14일간의 탈퇴 대기기간이 있으며, 탈퇴 대기기간 동안 탈퇴 대기 취소를 할 수 있습니다.',
                              style: TextStyle(fontSize: 14)))
                    ]))),
        bottomNavigationBar: GestureDetector(
            onTap: () => context.vRouter
                .to(DeleteAccountResultScreen.routeName, isReplacement: true),
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black38, width: 1))),
                height: 75,
                child: Text('회원 탈퇴 신청',
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Theme.of(context).accentColor)))));
  }
}

import 'package:krrng_client/modules/version_info/cubit/version_info_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class VersionInfoPage extends StatefulWidget {
  const VersionInfoPage({Key? key}) : super(key: key);

  @override
  State<VersionInfoPage> createState() => _VersionInfoPageState();
}

class _VersionInfoPageState extends State<VersionInfoPage> {
  late VersionInfoCubit _versionInfoCubit;

  PackageInfo _packageInfo = PackageInfo(
      appName: 'Unknown',
      packageName: 'Unknown',
      version: 'Unknown',
      buildNumber: 'Unknown');

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    _versionInfoCubit = BlocProvider.of<VersionInfoCubit>(context);
    _versionInfoCubit.getAppversion();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() => _packageInfo = info);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: Text('버전 정보', style: Theme.of(context).textTheme.headline2)),
        body: BlocBuilder<VersionInfoCubit, VersionInfoState>(
            builder: (context, state) {
          if (state.isLoaded == true && _packageInfo.version != 'Unknown') {
            return SafeArea(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  Center(child: Image.asset('assets/images/version_info.png')),
                  SizedBox(height: 60),
                  if (state.version.toString() ==
                      _packageInfo.version.toString())
                    Column(children: [
                      Center(
                          child: Text('현재 최신 버전을 사용 중입니다.',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                      SizedBox(height: 10),
                      Center(
                          child: Text('현재 버전 ${state.version.toString()}V',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w900)))
                    ])
                  else
                    Column(children: [
                      Center(
                          child: Text('현재 버전 ${_packageInfo.version}V',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                      SizedBox(height: 10),
                      Center(
                          child: Text('최신 버전 ${state.version.toString()}V',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w900))),
                      SizedBox(height: 10),
                      InkWell(
                          onTap: _launchURL,
                          child: Container(
                              width: 161,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              child: Text('버전 업데이트 하기',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              alignment: Alignment.center))
                    ])
                ]));
          }
          return Center(
              child: Image.asset('assets/images/indicator.gif',
                  width: 100, height: 100));
        }));
  }
}

_launchURL() async {
  const url = 'https://onelink.to/82ttrz';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

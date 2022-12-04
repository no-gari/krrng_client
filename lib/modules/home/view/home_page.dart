import 'package:krrng_client/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:krrng_client/repositories/user_repository/src/user_repository.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/modules/search_result/view/search_result_screen.dart';
import 'package:krrng_client/modules/notification/view/notification_screen.dart';
import 'package:krrng_client/repositories/user_repository/models/user.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:krrng_client/modules/mypage/view/mypage_screen.dart';
import 'package:krrng_client/modules/search/view/search_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:krrng_client/modules/pet/view/pet_screen.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';
import '../components/menus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthenticationBloc _authenticationBloc;
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    if (_authenticationBloc.state.status == AuthenticationStatus.authenticated)
      () => getUser();
  }

  void getUser() async {
    ApiResult<User> apiResult =
        await RepositoryProvider.of<UserRepository>(context).getUser();
    apiResult.when(success: (User? user) {
      _authenticationBloc.emit(AuthenticationState.authenticated(user!));
    }, failure: (NetworkExceptions? error) {
      _authenticationBloc.emit(AuthenticationState.unauthenticated());
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: SvgPicture.asset('assets/icons/logo_text.svg',
                height: 19, fit: BoxFit.scaleDown),
            actions: [
              GestureDetector(
                  onTap: () => context.vRouter.to(SearchScreen.routeName),
                  child: SvgPicture.asset('assets/icons/search_icon.svg')),
              SizedBox(width: 20),
              GestureDetector(
                  onTap: () => _authenticationBloc.state.status ==
                          AuthenticationStatus.authenticated
                      ? context.vRouter.to(NotificationScreen.routeName)
                      : showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                content: Text("로그인이 필요합니다."),
                                insetPadding:
                                    const EdgeInsets.fromLTRB(0, 80, 0, 80),
                                actions: [
                                  TextButton(
                                      child: const Text('확인'),
                                      onPressed: () =>
                                          Navigator.of(context).pop())
                                ]);
                          }),
                  child: SvgPicture.asset('assets/icons/noti_icon.svg')),
              SizedBox(width: 20),
              GestureDetector(
                  onTap: () => context.vRouter.to(MyPageScreen.routeName),
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.asset('assets/images/default_image.png'))),
              SizedBox(width: 16)
            ]),
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state.status != AuthenticationStatus.unknown) {
            return SafeArea(
                child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                              builder: (context, authState) {
                            if (authState.status ==
                                    AuthenticationStatus.authenticated &&
                                authState.user.animals!.isNotEmpty) {
                              return Column(children: [
                                SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: 112,
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: authState
                                                      .user.animals!.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var birthday = authState
                                                        .user
                                                        .animals![index]
                                                        .birthday
                                                        .toString();
                                                    var year = int.parse(
                                                        birthday.split('-')[0]);
                                                    var nowYear =
                                                        DateTime.now().year;
                                                    var age =
                                                        (nowYear - year + 1)
                                                            .toString();

                                                    return buildAnimalTile(
                                                        authState,
                                                        index,
                                                        age,
                                                        context);
                                                  })),
                                          InkWell(
                                            onTap: () => context.vRouter
                                                .to(PetScreen.routeName),
                                            child: Container(
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      CircleAvatar(
                                                          radius: 35,
                                                          backgroundColor:
                                                              Colors.black
                                                                  .withOpacity(
                                                                      0.04),
                                                          child: Icon(Icons.add,
                                                              size: 32,
                                                              color:
                                                                  Colors.grey)),
                                                      SizedBox(width: 15),
                                                      Text('등록하기',
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.grey))
                                                    ]),
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 16),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                height: 112,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.85,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    border: Border.all(
                                                        color: Color(
                                                            0xFFDFE2E9)))),
                                          )
                                        ])),
                                SizedBox(height: 50)
                              ]);
                            }
                            return Column(children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: GestureDetector(
                                    onTap: () => _authenticationBloc
                                                .state.status ==
                                            AuthenticationStatus.authenticated
                                        ? context.vRouter
                                            .to(PetScreen.routeName)
                                        : showLoginNeededDialog(context),
                                    child: Image.asset(
                                        "assets/images/mainbanner.png")),
                              ),
                              SizedBox(height: 50)
                            ]);
                          }),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(TextSpan(
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(text: '내 주변 동물병원\n'),
                                          TextSpan(text: '진료비를 검색해 보세요'),
                                        ])),
                                    SizedBox(height: 15),
                                    Row(children: [
                                      Expanded(
                                          child: Container(
                                              height: 44,
                                              child: TextField(
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  textInputAction:
                                                      TextInputAction.go,
                                                  onSubmitted: (value) {
                                                    if (value.trim() != '') {
                                                      // context.vRouter.toNamed('/search_result',
                                                      //     pathParameters: {
                                                      //       'keyword': _textEditingController.text
                                                      //     });
                                                      _textEditingController
                                                          .clear();
                                                    }
                                                  },
                                                  autofocus: false,
                                                  controller:
                                                      _textEditingController,
                                                  decoration: InputDecoration(
                                                      isCollapsed: true,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  15.0),
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFFDFE2E9))),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  15),
                                                          borderSide: BorderSide(
                                                              color: Color(0xFFDFE2E9))),
                                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0), borderSide: BorderSide(color: Color(0xFFDFE2E9))),
                                                      hintText: '중성화 수술',
                                                      hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                                                      suffixIcon: IconButton(icon: SvgPicture.asset('assets/icons/search_icon.svg', color: Colors.grey), color: Colors.black, onPressed: () => _textEditingController.clear()))))),
                                      SizedBox(width: 10),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SearchResultScreen())),
                                          child: Container(
                                              alignment: Alignment.center,
                                              width: 93,
                                              height: 44,
                                              child: Text('검색하기',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15))))
                                    ]),
                                    SizedBox(height: 40),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 19),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Menu(
                                                iconPath:
                                                    'assets/icons/24hour.svg',
                                                title: '24시 진료'),
                                            Menu(
                                                iconPath:
                                                    'assets/icons/eye.svg',
                                                title: '안과 진료'),
                                            Menu(
                                                iconPath:
                                                    'assets/icons/skin.svg',
                                                title: '피부진료'),
                                            Menu(
                                                iconPath:
                                                    'assets/icons/stomache.svg',
                                                title: '소화기관'),
                                          ]),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 19, vertical: 15),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Menu(
                                                iconPath:
                                                    'assets/icons/lungs.svg',
                                                title: '호흡기'),
                                            Menu(
                                                iconPath:
                                                    'assets/icons/tooth.svg',
                                                title: '치과 전문'),
                                            Menu(
                                                iconPath:
                                                    'assets/icons/brain.svg',
                                                title: '정신(뇌)'),
                                            Menu(
                                                iconPath:
                                                    'assets/icons/korean_hospital.svg',
                                                title: '한의원'),
                                          ]),
                                    ),
                                    SizedBox(height: 15),
                                    GestureDetector(
                                        onTap: () {},
                                        child: Image.asset(
                                            'assets/images/home_screen_banner.png'))
                                  ]))
                        ])));
          }
          return Center(
              child: Image.asset('assets/images/indicator.gif',
                  width: 100, height: 100));
        }));
  }

  Future<dynamic> showLoginNeededDialog(BuildContext context) {
    return showDialog(
        useRootNavigator: false,
        context: context,
        builder: (context) {
          return AlertDialog(title: const Text("로그인이 필요합니다."), actions: [
            MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("확인")),
          ]);
        });
  }

  GestureDetector buildAnimalTile(AuthenticationState authState, int index,
      String age, BuildContext context) {
    return GestureDetector(
        onTap: () => context.vRouter.to(PetScreen.routeName, queryParameters: {
              "edit": "true",
              "id": "${authState.user.animals![index].id!}"
            }),
        child: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Color(0xFFDFE2E9)),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(authState
                                        .user.animals![index].image ??
                                    'https://github.com/cheonhyeonjin/krrng/blob/main/default_image.png?raw=true')))),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text.rich(
                              TextSpan(children: [
                                TextSpan(
                                    text: authState.user.animals![index].name ??
                                        ""),
                                TextSpan(
                                    text: '(${age}세)',
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor))
                              ]),
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w900)),
                          Text(
                            authState.user.animals![index].kind.toString(),
                            style: TextStyle(fontSize: 15),
                          ),
                          Row(children: [
                            Text(
                                authState.user.animals![index].sexChoices ==
                                        'MA'
                                    ? '남'
                                    : '여',
                                style: TextStyle(fontSize: 15)),
                            Container(
                                width: 1,
                                height: 10,
                                color: Colors.grey,
                                margin: EdgeInsets.symmetric(horizontal: 5)),
                            Text(
                              authState.user.animals![index].weight!,
                              style: TextStyle(fontSize: 15),
                            )
                          ])
                        ])
                  ]),
                  Icon(Icons.edit, size: 20, color: Colors.black26)
                ]),
            width: MediaQuery.of(context).size.width * 0.85,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(left: 16),
            height: 110,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Color(0xFFDFE2E9)))));
  }
}

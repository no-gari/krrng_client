import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/modules/home/view/home_screen.dart';
import 'package:krrng_client/modules/hospital/view/hospital_screen.dart';
import 'package:krrng_client/modules/mypage/view/mypage_screen.dart';
import 'package:krrng_client/modules/store/view/store_screen.dart';
import 'package:krrng_client/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:krrng_client/support/base_component/login_needed.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

enum MenuState { home, hospital, store, mypage }

extension MenuStateToString on MenuState {
  String get name {
    return const ["home", "hospital", "store", "mypage"][this.index];
  }

  String get nickName {
    return const ["", "", "", ""][this.index];
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  late AuthenticationBloc _authenticationBloc;

  PageController _pageController = PageController();
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pageIndex = 0;

    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
  }

  void _onPageChanged(int index) => setState(() => _pageIndex = index);

  void _onItemTapped(int index) => _pageController.jumpToPage(index);

  List<Widget> pageList = [
    HomeScreen(),
    HospitalScreen(),
    StoreScreen(),
    MyPageScreen()
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ScaffoldContext) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      return Scaffold(
          body: DoubleBack(
              message: '앱을 닫으시려면 한 번 더 눌러주세요.',
              child: BlocProvider.value(value: _authenticationBloc,
                child: PageView(
                    children: pageList,
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    physics: const NeverScrollableScrollPhysics()),
              )),
          bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.grey, width: 1))),
              child: BottomNavigationBar(
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: List.generate(
                      MenuState.values.length,
                      (index) => BottomNavigationBarItem(
                          label: '',
                          icon: index != 3
                              ? ImageIcon(
                                  Svg(
                                    "assets/icons/${MenuState.values[index].name}.svg",
                                  ),
                                  size: 32)
                              : Image.asset('assets/icons/mypage.png'))),
                  onTap: (context) {
                    // if (state.status != AuthenticationStatus.authenticated &&
                    //     context == 3) {
                    //   showSocialLoginNeededDialog(ScaffoldContext);
                    // } else {
                    _onItemTapped(context);
                    // }
                  },
                  selectedItemColor: Theme.of(context).accentColor,
                  unselectedItemColor: const Color(0xFF979797),
                  currentIndex: _pageIndex,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  elevation: 0)));
    });
  }
}

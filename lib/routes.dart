import 'package:krrng_client/modules/authentication/signin/view/signin_screen.dart';
import 'package:krrng_client/modules/authentication/signup/view/signup_screen.dart';
import 'package:krrng_client/modules/hospital/view/hospital_screen.dart';
import 'package:krrng_client/modules/mypage/view/mypage_screen.dart';
import 'package:krrng_client/modules/main/main_screen.dart';
import 'package:krrng_client/modules/notification/view/notification_screen.dart';
import 'package:krrng_client/modules/search/view/search_screen.dart';
import 'package:krrng_client/modules/settings/view/setting_screen.dart';
import 'package:krrng_client/modules/splash/splash_screen.dart';
import 'package:krrng_client/modules/store/view/store_screen.dart';
import 'package:vrouter/vrouter.dart';

import 'modules/authentication/finding/views/views.dart';


final routes = [
  VWidget(path: MainScreen.routeName, widget: MainScreen(), stackedRoutes: [
    VWidget(path: MyPageScreen.routeName, widget: MyPageScreen()),
    VWidget(path: HospitalScreen.routeName, widget: HospitalScreen()),
    VWidget(path: StoreScreen.routeName, widget: StoreScreen()),
    VWidget(path: SearchScreen.routeName, widget: SearchScreen()),
    VWidget(path: NotificationScreen.routeName, widget: NotificationScreen()),
    VWidget(path: SettingScreen.routeName, widget: SettingScreen()),
  ]),
  VWidget(path: SplashScreen.routeName, widget: SplashScreen()),
  VWidget(path: SigninScreen.routeName, widget: SigninScreen(),
    stackedRoutes: [
      VWidget(path: SignupScreen.routeName, widget: SignupScreen()),
      VWidget(path: FindingScreen.routeName, widget: FindingScreen()),
    ]
  ),
];

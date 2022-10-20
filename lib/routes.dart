import 'package:krrng_client/modules/hospital/view/hospital_screen.dart';
import 'package:krrng_client/modules/mypage/view/mypage_screen.dart';
import 'package:krrng_client/modules/main/main_screen.dart';
import 'package:krrng_client/modules/search/view/search_screen.dart';
import 'package:krrng_client/modules/store/view/store_screen.dart';
import 'package:vrouter/vrouter.dart';

final routes = [
  VWidget(path: MainScreen.routeName, widget: MainScreen()),
  VWidget(path: MyPageScreen.routeName, widget: MyPageScreen()),
  VWidget(path: HospitalScreen.routeName, widget: HospitalScreen()),
  VWidget(path: StoreScreen.routeName, widget: StoreScreen()),
  VWidget(path: SearchScreen.routeName, widget: SearchScreen()),
  VWidget(path: '*', widget: MainScreen())
];

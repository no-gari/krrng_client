import 'package:krrng_client/modules/authentication/signin/view/signin_screen.dart';
import 'package:krrng_client/modules/authentication/signin/view/sns_phone_screen.dart';
import 'package:krrng_client/modules/authentication/signup/view/signup_screen.dart';
import 'package:krrng_client/modules/ads_request/view/ads_request_screen.dart';
import 'package:krrng_client/modules/authentication/signup/view/signup_temp_screen.dart';
import 'package:krrng_client/modules/delete_account/delete_account_result_screen.dart';
import 'package:krrng_client/modules/delete_account/delete_account_screen.dart';
import 'package:krrng_client/modules/faq/page/faq_screen.dart';
import 'package:krrng_client/modules/hospital/view/hospital_screen.dart';
import 'package:krrng_client/modules/hospital_search/view/hospital_search_screen.dart';
import 'package:krrng_client/modules/invite/page/invite_screen.dart';
import 'package:krrng_client/modules/my_reviews/view/my_review_screen.dart';
import 'package:krrng_client/modules/mypage/view/mypage_screen.dart';
import 'package:krrng_client/modules/main/main_screen.dart';
import 'package:krrng_client/modules/notice/view/notice_screen.dart';
import 'package:krrng_client/modules/notification/view/notification_screen.dart';
import 'package:krrng_client/modules/pet/view/pet_screen.dart';
import 'package:krrng_client/modules/point/page/point_screen.dart';
import 'package:krrng_client/modules/profile_change/view/profile_change_screen.dart';
import 'package:krrng_client/modules/search/view/search_screen.dart';
import 'package:krrng_client/modules/search_result/view/search_result_screen.dart';
import 'package:krrng_client/modules/search_result_branch/view/search_result_branch_screen.dart';
import 'package:krrng_client/modules/settings/view/setting_screen.dart';
import 'package:krrng_client/modules/splash/splash_screen.dart';
import 'package:krrng_client/modules/store/view/store_screen.dart';
import 'package:krrng_client/modules/terms_of_use/personal_info_screen.dart';
import 'package:krrng_client/modules/terms_of_use/terms_of_use_screen.dart';
import 'package:krrng_client/modules/version_info/page/version_info_screen.dart';
import 'package:vrouter/vrouter.dart';

import 'modules/authentication/finding/views/views.dart';

final routes = [
  VWidget(path: MainScreen.routeName, widget: MainScreen(), stackedRoutes: [
    VWidget(path: MyPageScreen.routeName, widget: MyPageScreen()),
    VWidget(
        path: HospitalSearchScreen.routeName + '/:disease' + '/:fromMap',
        widget: HospitalSearchScreen(),
        name: HospitalSearchScreen.routeName),
    VWidget(
        path: HospitalScreen.routeName,
        widget: HospitalScreen(),
        stackedRoutes: []),
    VWidget(
        path: MyReviewScreen.routeName,
        widget: MyReviewScreen(),
        stackedRoutes: []),
    VWidget(
        path: PetScreen.routeName + '/:editValue' + '/:id',
        widget: PetScreen(),
        name: PetScreen.routeName),
    VWidget(path: StoreScreen.routeName, widget: StoreScreen()),
    VWidget(
        path: SearchScreen.routeName,
        widget: SearchScreen(),
        stackedRoutes: [
          VWidget(
              path: SearchResultScreen.routeName + '/:keyword',
              widget: SearchResultScreen(),
              name: SearchResultScreen.routeName)
        ]),
    VWidget(path: NotificationScreen.routeName, widget: NotificationScreen()),
    VWidget(
        path: SettingScreen.routeName,
        widget: SettingScreen(),
        stackedRoutes: [
          VWidget(path: AdsRequestScreen.routeName, widget: AdsRequestScreen()),
          VWidget(
              path: VersionInfoScreen.routeName, widget: VersionInfoScreen()),
          VWidget(path: TermsOfUseScreen.routeName, widget: TermsOfUseScreen()),
          VWidget(
              path: PersonalInfoScreen.routeName, widget: PersonalInfoScreen()),
          VWidget(
              path: DeleteAccountScreen.routeName,
              widget: DeleteAccountScreen()),
        ]),
    VWidget(path: FaqScreen.routeName, widget: FaqScreen()),
    VWidget(path: PointScreen.routeName, widget: PointScreen()),
    VWidget(path: NoticeScreen.routeName, widget: NoticeScreen()),
    VWidget(path: InviteScreen.routeName, widget: InviteScreen()),
    VWidget(path: ProfileChangeScreen.routeName, widget: ProfileChangeScreen()),
    VWidget(
        path: DeleteAccountResultScreen.routeName,
        widget: DeleteAccountResultScreen()),
    VWidget(
        path: SigninScreen.routeName,
        widget: SigninScreen(),
        stackedRoutes: [
          VWidget(path: SignupScreen.routeName, widget: SignupScreen()),
          VWidget(path: SignupTempScreen.routeName, widget: SignupTempScreen()),
          VWidget(path: SnsPhoneScreen.routeName, widget: SnsPhoneScreen()),
          VWidget(path: FindingScreen.routeName, widget: FindingScreen()),
          VWidget(
              path: FindingResultPage.routeName, widget: FindingResultPage())
        ]),
  ]),
  VWidget(path: SplashScreen.routeName, widget: SplashScreen()),
  VWidget(
      path: SearchResultBranchScreen.routeName,
      widget: SearchResultBranchScreen()),
  VWidget(path: '*', widget: MainScreen()),
];

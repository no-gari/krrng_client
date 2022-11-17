import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/dio_client.dart';
import 'dart:convert';
import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final DioClient _dioClient;

  AuthenticationRepository(this._dioClient);

  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));

    String? accessToken = await getAccessToken();

    if (accessToken != null) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  Future<void> logIn() async {
    _controller.add(AuthenticationStatus.authenticated);
  }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('access')) {
      await prefs.remove("refresh");
      await prefs.remove("access").whenComplete(() {
        _controller.add(AuthenticationStatus.unauthenticated);
      });
    } else {
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  void signOut() async {
    try {
      _dioClient.delete('/api/v1/user/profile_change/').whenComplete(() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove("refresh");
        await prefs.remove("access").whenComplete(
            () => _controller.add(AuthenticationStatus.unauthenticated));
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<ApiResult<Map>> signInWithSns(
      {required String code,
      required String email,
      required String nickname,
      String? socialType,
      String? profileImageUrl}) async {
    print('================repository====================');

    try {
      String body = json.encode({
        "code": code,
        "socialType": socialType,
        "email": email,
        "nickname": nickname,
        "profileImageUrl": profileImageUrl,
      });

      var response =
          await _dioClient.signinPost('/api/v1/user/social_login/', data: body);
      return ApiResult.success(data: response);
    } catch (e) {
      print('================repository fail====================');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Map>> signInWithEmail(
      {required String userId, required String password}) async {
    try {
      String body = json.encode({
        "userId": userId,
        "password": password,
      });
      var response =
          await _dioClient.signinPost('/dev/api/v1/user/login/', data: body);
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<String?> getAccessToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('access');
    } on Exception {
      print(Error);
    }
  }

  Future<ApiResult<Map>> updateUserProfile(
      Map<String, dynamic> updateUserProfile) async {
    try {
      String body = json.encode(updateUserProfile);
      var response =
          await _dioClient.put('/api/v1/user/profile_change/', data: body);

      return ApiResult.success(
        data: response,
      );
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
      );
    }
  }

  Future<ApiResult<void>> duplicateId(String id) async {
    try {
      var body = { 'userId': id };
      var response = await _dioClient.post('/dev/api/v1/user/user-id-check/', data: body);

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<void>> requestSignupCode(String phoneNumber) async {
    try {
      var body = { 'phone': phoneNumber };
      var response = await _dioClient.post('/dev/api/v1/user/register-phone-create/', data: body);

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<void>> confirmCode(String phoneNumber, String code) async {
    try {
      var body = {
        'phone': phoneNumber,
        'code': code
      };
      var response = await _dioClient.post('/dev/api/v1/user/register-phone-confirm/', data: body);

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Map>> signup(String userId, String password, String phoneNumber) async {
    try {
      var body = {
        'userId': userId,
        'password': password,
        'phone': phoneNumber
      };
      var response = await _dioClient.post('/dev/api/v1/user/email-signup/', data: body);

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
  void dispose() => _controller.close();
}

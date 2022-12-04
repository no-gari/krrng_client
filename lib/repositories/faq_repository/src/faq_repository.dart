import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/dio_client.dart';

class FAQRepository {
  final DioClient _dioClient;

  FAQRepository(this._dioClient);

  Future<ApiResult<List<dynamic>>> getFAQList() async {
    try {
      var response = await _dioClient.get('/dev/api/v1/cs/faq-menu/list/');
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<dynamic>> createOffer(
    String? hospitalName,
    String? hospitalAddress,
    String? userName,
    String? userEmail,
    String? userPhone,
    String? userHospital,
    String? methods,
  ) async {
    try {
      var response =
          await _dioClient.signinPost('/dev/api/v1/cs/offer/create/', data: {
        'hospitalName': hospitalName,
        'hospitalAddress': hospitalAddress,
        'userName': userName,
        'userEmail': userEmail,
        'userPhone': userPhone,
        'userHospital': userHospital,
        'methods': methods,
      });
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}

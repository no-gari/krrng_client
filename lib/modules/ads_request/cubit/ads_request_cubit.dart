import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:krrng_client/repositories/faq_repository/models/faq_menu.dart';
import 'package:krrng_client/repositories/faq_repository/src/faq_repository.dart';

part 'ads_request_state.dart';

class AdsRequestCubit extends Cubit<AdsRequestState> {
  AdsRequestCubit(this._faqRepository)
      : super(const AdsRequestState(
          isLoading: true,
          isLoaded: false,
        ));

  final FAQRepository _faqRepository;

  Future<void> createOffer(
    String? hospitalName,
    String? hospitalAddress,
    String? userName,
    String? userEmail,
    String? userPhone,
    String? userHospital,
    String? methods,
  ) async {
    ApiResult<dynamic> apiResult = await _faqRepository.createOffer(
        hospitalName,
        hospitalAddress,
        userName,
        userEmail,
        userPhone,
        userHospital,
        methods);

    apiResult.when(success: (void response) {
      emit(state.copyWith(
        isLoading: false,
        isLoaded: true,
      ));
    }, failure: (NetworkExceptions? error) {
      print(error);
    });
  }
}

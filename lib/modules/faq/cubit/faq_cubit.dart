import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:krrng_client/repositories/faq_repository/models/faq_menu.dart';
import 'package:krrng_client/repositories/faq_repository/src/faq_repository.dart';

part 'faq_state.dart';

class FAQCubit extends Cubit<FAQState> {
  FAQCubit(this._faqRepository)
      : super(const FAQState(
          isLoading: true,
          isLoaded: false,
        ));

  final FAQRepository _faqRepository;

  Future<void> getFAQList() async {
    ApiResult<List<dynamic>> apiResult = await _faqRepository.getFAQList();

    apiResult.when(success: (List? listResponse) {
      emit(state.copyWith(
        faq: listResponse!.map((e) => FAQMenu.fromJson(e)).toList(),
        isLoading: false,
        isLoaded: true,
      ));
    }, failure: (NetworkExceptions? error) {
      print(error);
    });
  }
}

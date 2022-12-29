import 'package:krrng_client/repositories/notice_repository/src/notice_repository.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'version_info_state.dart';

class VersionInfoCubit extends Cubit<VersionInfoState> {
  VersionInfoCubit(this._noticeRepository)
      : super(const VersionInfoState(
          isLoading: true,
          isLoaded: false,
        ));

  final NoticeRepository _noticeRepository;

  Future<void> getAppversion() async {
    ApiResult<dynamic> apiResult = await _noticeRepository.getAppVersion();

    apiResult.when(success: (response) {
      emit(state.copyWith(
        version: response,
        isLoading: false,
        isLoaded: true,
      ));
    }, failure: (NetworkExceptions? error) {
      print(error);
    });
  }
}

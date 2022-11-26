import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:krrng_client/repositories/notice_repository/models/notice.dart';
import 'package:krrng_client/repositories/notice_repository/src/notice_repository.dart';

part 'notice_state.dart';

class NoticeCubit extends Cubit<NoticeState> {
  NoticeCubit(this._noticeRepository)
      : super(const NoticeState(
          isLoading: true,
          isLoaded: false,
        ));

  final NoticeRepository _noticeRepository;

  Future<void> getNoticeList() async {
    ApiResult<List<dynamic>> apiResult =
        await _noticeRepository.getNoticeList();

    apiResult.when(success: (List? listResponse) {
      emit(state.copyWith(
        noticeList: listResponse!.map((e) => Notice.fromJson(e)).toList(),
        isLoading: false,
        isLoaded: true,
      ));
    }, failure: (NetworkExceptions? error) {
      print(error);
    });
  }
}

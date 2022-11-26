import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:krrng_client/repositories/point_repository/models/point.dart';
import 'package:krrng_client/repositories/point_repository/models/point_list.dart';
import 'package:krrng_client/repositories/point_repository/src/point_repository.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';

part 'point_state.dart';

class PointCubit extends Cubit<PointState> {
  PointCubit(this._pointRepository)
      : super(const PointState(
          isLoading: true,
          isLoaded: false,
        ));

  final PointRepository _pointRepository;

  Future<void> getPointList(String order) async {
    ApiResult<PointList> apiResult = await _pointRepository.getPointList(order);

    apiResult.when(success: (PointList? pointList) {
      emit(state.copyWith(
        pointList: pointList!.points,
        totalPoint: pointList.totalPoint,
        isLoading: false,
        isLoaded: true,
      ));
    }, failure: (NetworkExceptions? error) {
      print(error);
    });
  }
}

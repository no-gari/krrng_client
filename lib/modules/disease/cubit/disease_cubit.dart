import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/repositories/disease_repository/models/disease.dart';
import 'package:krrng_client/repositories/disease_repository/src/disease_repository.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';

part 'disease_state.dart';

class DiseaseCubit extends Cubit<DiseaseState> {
  DiseaseCubit(this._diseaseRepository)
      : super(const DiseaseState(
          isLoading: true,
          isLoaded: false,
        ));

  final DiseaseRepository _diseaseRepository;

  Future<void> getDiseaseList(String symptom) async {
    ApiResult<List<dynamic>> apiResult =
        await _diseaseRepository.getDiseaseList(symptom);

    apiResult.when(success: (List? listResponse) {
      emit(state.copyWith(
        disease: listResponse!.map((e) => Disease.fromJson(e)).toList(),
        isLoading: false,
        isLoaded: true,
      ));
    }, failure: (NetworkExceptions? error) {
      print(error);
    });
  }
}

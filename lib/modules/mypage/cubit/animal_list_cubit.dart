import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:krrng_client/repositories/animal_repository/animal_repository.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';

part 'animal_list_state.dart';

class AnimalListCubit extends Cubit<AnimalListState> {
  AnimalListCubit(this._animalRepository)
      : super(const AnimalListState(
          isLoading: true,
          isLoaded: false,
        ));

  final AnimalRepository _animalRepository;

  Future<void> getAnimals() async {
    ApiResult<List<dynamic>> apiResult = await _animalRepository.getAnimals();

    apiResult.when(success: (List? listResponse) {
      emit(state.copyWith(
        animals: listResponse!.map((e) => Animal.fromJson(e)).toList(),
        isLoading: false,
        isLoaded: true,
      ));
    }, failure: (NetworkExceptions? error) {
      print('======================================');
      print(error.toString());
      print('======================================');
      print(error.toString());
    });
  }
}

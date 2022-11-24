import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:krrng_client/repositories/animal_repository/animal_repository.dart';
import 'package:krrng_client/repositories/map_repository/models/mapData.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';

part 'animal_state.dart';

class AnimalCubit extends Cubit<AnimalState> {
  AnimalCubit(this._animalRepository)
      : super(const AnimalState(
          isLoading: true,
          isLoaded: false,
        ));

  final AnimalRepository _animalRepository;

  Future<void> getAnimalById(String Id) async {
    ApiResult<Animal> apiResult = await _animalRepository.getAnimalById(Id);

    apiResult.when(
        success: (Animal? animal) {
          emit(state.copyWith(
            animal: animal,
            isLoading: false,
            isLoaded: true,
          ));
        },
        failure: (NetworkExceptions? error) {});
  }
}

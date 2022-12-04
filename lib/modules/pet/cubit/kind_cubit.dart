import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:krrng_client/repositories/animal_repository/animal_repository.dart';
import 'package:krrng_client/repositories/animal_repository/models/sort_animal.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';

part 'kind_state.dart';

class KindCubit extends Cubit<KindState> {
  KindCubit(this._animalRepository) : super(const KindState(isLoaded: false));

  final AnimalRepository _animalRepository;

  Future<void> getKindList() async {
    ApiResult<List<dynamic>> apiResult =
        await _animalRepository.getAnimalKinds();

    apiResult.when(success: (List? listResponse) {
      emit(state.copyWith(
        sortAnimals: listResponse!.map((e) => SortAnimal.fromJson(e)).toList(),
        isLoaded: true,
      ));
    }, failure: (NetworkExceptions? error) {
      print(error);
    });
  }
}

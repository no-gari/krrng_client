import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:krrng_client/modules/pet/enums.dart';
import 'package:krrng_client/repositories/animal_repository/animal_repository.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';

part 'pet_state.dart';

class PetCubit extends Cubit<PetState> {
  PetCubit(this._animalRepository, this.isEdit) : super(const PetState());

  final AnimalRepository _animalRepository;
  final bool isEdit;

  void setPet({String? image, int? sort, String? kind, String? name, String? birthday, String? weight,
    String? hospital1, String? hospital2, String? interestedDisease,
    SexChoice? sexChoice, AllergicChoice? allergicChoice, NeutralizeChoice? neutralizeChoice}) {
    emit(state.copyWith(
      image: image,
      kind: kind,
      name: name,
      birthday: birthday,
      weight: weight,
      interestedDisease: interestedDisease
    ));

    if (sort != null) {
      emit(state.copyWith(sort: PetSortRawValue(sort)));
    }

    if (sexChoice != null) {
      emit(state.copyWith(sex: PetSexRawValue(sexChoice)));
    }

    if (neutralizeChoice != null) {
      emit(state.copyWith(neutralizeChoice: PetNeutralizeRawValue(neutralizeChoice)));
    }

    if (allergicChoice != null) {
      emit(state.copyWith(allergicChoice: PetAllergicRawValue(allergicChoice)));
    }
  }

  Future<void> registerPet() async {
    Map<String, dynamic> body = {
      // "image": state.
      "sort": state.sort,
      "birthday": state.birthday,
      "weight": state.weight,
      "kind": state.kind,
      "hospitalAddress": state.hospitalAddress,
      "hospitalAddressDetail": state.hospitalAddressDetail,
      "interestedDisease": state.interestedDisease,
      "neuterChoices": state.neutralizeChoice,
      "hasAlergy": state.allergicChoice,
      "sexChoices": state.sex
    };

    var response = await _animalRepository.createAnimal(body);
    response.when(success: (Animal? animal) {

    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
    });
  }

  Future<void> updatePet() async {
    Map<String, dynamic> body = {

    };

    var response = await _animalRepository.updateAnimalById(state.id!, body);
    response.when(success: (Animal? animal) {

    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
    });
  }

}
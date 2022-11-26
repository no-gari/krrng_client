import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:krrng_client/modules/pet/enums.dart';
import 'package:krrng_client/repositories/animal_repository/animal_repository.dart';

part 'pet_state.dart';

class PetCubit extends Cubit<PetState> {
  PetCubit(this._animalRepository) : super(const PetState());

  final AnimalRepository _animalRepository;

  void setMode(bool isEdit) {
    emit(state.copyWith(isEdit: isEdit));
  }

  void setPet({String? image, String? name, String? birthday, int? weight, SexChoice? sexChoice, AllergicChoice? allergicChoice, NeutralizeChoice? neutralizeChoice}) {
    emit(state.copyWith(
      image: image,
      name: name,
      birthday: birthday,
      weight: weight,
    ));

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

  }

  Future<void> updatePet() async {

  }

}
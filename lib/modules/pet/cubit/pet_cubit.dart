import 'dart:io';
import 'dart:async';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:krrng_client/modules/pet/enums.dart';
import 'package:krrng_client/repositories/animal_repository/animal_repository.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';

part 'pet_state.dart';

class PetCubit extends Cubit<PetState> {
  PetCubit(this._animalRepository, this.isEdit, this.id) : super(const PetState());

  final AnimalRepository _animalRepository;
  final bool isEdit;
  final String? id;

  void setPet({String? image, PetSort? sort, String? kind, String? name, String? birthday, String? weight,
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
      emit(state.copyWith(sort: sort.name));
    }

    if (sexChoice != null) {
      emit(state.copyWith(sex: sexChoice.value));
    }

    if (neutralizeChoice != null) {
      emit(state.copyWith(neutralizeChoice: neutralizeChoice.value));
    }

    if (allergicChoice != null) {
      emit(state.copyWith(allergicChoice: allergicChoice.value));
    }
  }

  Future<Animal?> registerPet() async {

    MultipartFile? image = null;

    if (state.image != null) {
      final bytes = File(state.image!).readAsBytesSync();
      image = await MultipartFile.fromBytes(bytes, contentType: MediaType("image", "jpeg"));
    }

    Map<String, dynamic> body = {
      "image": image,
      "sort": PetSort.getValueByEnum(state.sort!).value,
      "name": state.name,
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

    final data = FormData.fromMap(body);

    var response = await _animalRepository.createAnimal(data);
    response.when(success: (Animal? response) {
      if (response != null) {
        return response;
      }

      return null;
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
      return null;
    });

    return null;
  }

  Future<Animal?> updatePet() async {
    Map<String, dynamic> body = {
      "image": state.image == null ? null : state.image!.startsWith(RegExp(r'https://'), 0)? null : await MultipartFile.fromFile(state.image!),
      "sort": state.sort,
      "name": state.name,
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

    print(body);

    var response = await _animalRepository.updateAnimalById(state.id!, body);
    print(response);
    response.when(success: (Animal? animal) {
      if (animal != null) {
        emit(state.copyWith(
          id: animal.id,
          sort: animal.sort,
          birthday: animal.birthday,
          name: animal.name,
          weight: animal.weight,
          image: animal.image,
          kind: animal.kind,
          hospitalAddress: animal.hospitalAddress,
          hospitalAddressDetail: animal.hospitalAddressDetail,
          interestedDisease: animal.interestedDisease,
          neutralizeChoice: animal.neuterChoices,
          allergicChoice: animal.hasAlergy,
          sex: animal.sexChoices,
          isComplete: true
        ));

        return animal;
      }
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
      return null;
    });
    return null;
  }

  Future<void> getPetById(String id) async {
    var response = await _animalRepository.getAnimalById(id);
    response.when(success: (Animal? animal) {
      if (animal != null) {
        print(animal);
        print(PetSort.getEnumByName(animal.sort!));
        emit(state.copyWith(
            id: animal.id,
            image: animal.image,
            name: animal.name,
            sort: PetSort.getEnumByName(animal.sort!),
            birthday: animal.birthday,
            weight: animal.weight,
            kind: animal.kind,
            hospitalAddress: animal.hospitalAddress,
            hospitalAddressDetail: animal.hospitalAddressDetail,
            interestedDisease: animal.interestedDisease,
            neutralizeChoice: animal.neuterChoices,
            allergicChoice: animal.hasAlergy,
            sex: animal.sexChoices
        ));
      }
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
    });
  }
  
  Future<void> deletePet(String id) async {
    var response = await _animalRepository.deleteAnimalWithId(id);
    response.when(success: (dynamic response) {
      emit(state.copyWith(
        isComplete: true
      ));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
    });
  }
}
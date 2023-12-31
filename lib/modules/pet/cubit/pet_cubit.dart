import 'package:krrng_client/repositories/animal_repository/animal_repository.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:krrng_client/modules/pet/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'dart:async';

part 'pet_state.dart';

class PetCubit extends Cubit<PetState> {
  PetCubit(
      this._animalRepository, this._authenticationBloc, this.isEdit, this.id)
      : super(const PetState());

  final AnimalRepository _animalRepository;
  final AuthenticationBloc _authenticationBloc;
  final bool isEdit;
  final String? id;

  void setPet(
      {String? image,
      PetSort? sort,
      String? kind,
      String? name,
      String? birthday,
      String? weight,
      String? hospital1,
      String? hospital2,
      String? interestedDisease,
      SexChoice? sexChoice,
      AllergicChoice? allergicChoice,
      NeutralizeChoice? neutralizeChoice}) {
    emit(state.copyWith(
        image: image,
        kind: kind,
        name: name,
        birthday: birthday,
        weight: weight,
        interestedDisease: interestedDisease));

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

  Future<void> registerPet() async {
    emit(state.copyWith(isLoaded: false));

    Map<String, dynamic> body = {
      "image": state.image != null
          ? await MultipartFile.fromFile(state.image!)
          : null,
      "sort": state.sort.toString(),
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
    response.when(success: (Animal? animal) {
      if (animal != null) {
        var user = _authenticationBloc.state.user;
        var animals = _authenticationBloc.state.user.animals ?? [];
        animals.add(animal);
        user.copyWith(animals: animals);
        _authenticationBloc.add(AuthenticationUserChanged(user));
        emit(state.copyWith(isComplete: true, isLoaded: true));
      }
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
    });
  }

  Future<void> updatePet() async {
    Map<String, dynamic> body = {
      "image": state.image == null
          ? null
          : state.image!.startsWith(RegExp(r'https://'), 0)
              ? null
              : await MultipartFile.fromFile(state.image!),
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

    emit(state.copyWith(isLoaded: false));

    var response = await _animalRepository.updateAnimalById(state.id!, body);
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
            isComplete: true,
            isLoaded: true));

        var user = _authenticationBloc.state.user;

        var animals = _authenticationBloc.state.user.animals ?? [];
        final index = animals.indexWhere((element) => element.id == animal.id);

        animals[index] = animal;
        user.copyWith(animals: animals);
        _authenticationBloc.add(AuthenticationUserChanged(user));
        print(_authenticationBloc.state.user);
      }
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
    });
  }

  Future<void> getPetById(String id) async {
    emit(state.copyWith(isLoaded: false));

    var response = await _animalRepository.getAnimalById(id);
    response.when(success: (Animal? animal) {
      if (animal != null) {
        print(animal);
        emit(state.copyWith(
            id: animal.id,
            image: animal.image,
            name: animal.name,
            sort: animal.sort,
            birthday: animal.birthday,
            weight: animal.weight,
            kind: animal.kind,
            hospitalAddress: animal.hospitalAddress,
            hospitalAddressDetail: animal.hospitalAddressDetail,
            interestedDisease: animal.interestedDisease,
            neutralizeChoice: animal.neuterChoices,
            allergicChoice: animal.hasAlergy,
            sex: animal.sexChoices,
            isLoaded: true));
      }
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
    });
  }

  Future<void> deletePet(String id) async {
    emit(state.copyWith(isLoaded: false));

    var response = await _animalRepository.deleteAnimalWithId(id);
    response.when(success: (dynamic response) {
      var user = _authenticationBloc.state.user;
      var animals = user.animals ?? [];
      final index =
          animals.indexWhere((element) => element.id == int.parse(id));
      _authenticationBloc.add(AuthenticationUserChanged(_authenticationBloc
          .state.user
          .copyWith(animals: animals..removeAt(index))));

      emit(state.copyWith(isComplete: true, isLoaded: true));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
    });
  }
}

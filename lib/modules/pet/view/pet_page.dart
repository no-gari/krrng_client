import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kpostal/kpostal.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/modules/pet/cubit/kind_cubit.dart';
import 'package:krrng_client/modules/pet/cubit/pet_cubit.dart';
import 'package:krrng_client/repositories/authentication_repository/authentication_repository.dart';
import 'package:krrng_client/support/style/theme.dart';
import 'package:vrouter/vrouter.dart';
import '../components/components.dart';
import '../enums.dart';

class PetPage extends StatefulWidget {
  const PetPage({Key? key}) : super(key: key);

  @override
  State<PetPage> createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  late PetCubit _petCubit;
  late AuthenticationBloc _authenticationBloc;
  late KindCubit _kindCubit;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _weightController = TextEditingController();
  final _kindController = TextEditingController();
  final _addressController = TextEditingController();
  final _kopoController = TextEditingController();
  final _interestController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  int petIsSelectedIndex = 0;
  XFile? _image;
  DateTime? _pickedPetDate;

  SexChoice? _choice = SexChoice.male;
  NeutralizeChoice? _neutralizeChoice = NeutralizeChoice.yes;
  AllergicChoice? _allergicChoice = AllergicChoice.yes;

  @override
  void initState() {
    super.initState();
    _kindCubit = BlocProvider.of<KindCubit>(context);
    _petCubit = BlocProvider.of<PetCubit>(context);
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    _kindCubit.getKindList();
    if (_petCubit.isEdit && _petCubit.id != null) {
      _petCubit.getPetById(_petCubit.id!);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthdayController.dispose();
    _weightController.dispose();
    _kindController.dispose();
    _addressController.dispose();
    _kopoController.dispose();
    _interestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title:
                Text('반려동물 관리', style: Theme.of(context).textTheme.headline2)),
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: BlocConsumer<PetCubit, PetState>(
                    listener: (context, state) {
                  if (state.isComplete ?? false) {
                    showDialog(
                        context: context,
                        barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                        builder: (BuildContext context) {
                          return AlertDialog(
                              content: Text(
                                  "${_petCubit.isEdit ? "완료되었습니다." : "등록이 완료되었습니다."}"),
                              insetPadding:
                                  const EdgeInsets.fromLTRB(0, 80, 0, 80),
                              actions: [
                                TextButton(
                                    child: const Text('확인'),
                                    onPressed: () {
                                      context.vRouter.pop();
                                      context.vRouter.pop();
                                    })
                              ]);
                        });
                  }

                  if (state.id != null) {
                    petIsSelectedIndex =
                        PetSort.getValueByEnum(state.sort!).index;
                    _nameController.text = state.name!;
                    _addressController.text = state.hospitalAddress ?? "";
                    _kopoController.text = state.hospitalAddressDetail ?? "";
                    _neutralizeChoice = NeutralizeChoice.getValueByEnum(
                        state.neutralizeChoice!);
                    _weightController.text = state.weight ?? "";
                    _kindController.text = state.kind ?? "";
                    _interestController.text = state.interestedDisease ?? "";
                    _pickedPetDate =
                        DateFormat('yyyy-MM-dd').parse(state.birthday!);
                    _birthdayController.text =
                        DateFormat('yyyy-MM-dd').format(_pickedPetDate!).trim();
                    _choice = SexChoice.getValueByEnum(state.sex!);
                  }
                }, builder: (context, state) {
                  return Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                var image = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                setState(() {
                                  if (image != null) {
                                    _image = image;
                                  }
                                });
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 30),
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.black12,
                                      child: state.image == null
                                          ? (_image == null
                                              ? Icon(Icons.add,
                                                  size: 32, color: Colors.grey)
                                              : ClipOval(
                                                  child: Image.file(
                                                      File(_image!.path),
                                                      width: 80,
                                                      height: 80,
                                                      fit: BoxFit.cover)))
                                          : ClipOval(
                                              child: Image.network(state.image!,
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover)))),
                            ),
                            PetFormHeader('종류'),
                            SizedBox(height: 10),
                            Row(children: [
                              PetContainer(
                                  path: 'assets/images/pic1.png',
                                  title: PetSort.DOG.value,
                                  isSelected: petIsSelectedIndex == 0,
                                  onTap: () =>
                                      setState(() => petIsSelectedIndex = 0)),
                              SizedBox(width: 10),
                              PetContainer(
                                  path: 'assets/images/pic2.png',
                                  title: PetSort.CAT.value,
                                  isSelected: petIsSelectedIndex == 1,
                                  onTap: () =>
                                      setState(() => petIsSelectedIndex = 1)),
                              SizedBox(width: 10),
                              PetContainer(
                                  path: 'assets/images/pic3.png',
                                  title: PetSort.ETC.value,
                                  isSelected: petIsSelectedIndex == 2,
                                  onTap: () =>
                                      setState(() => petIsSelectedIndex = 2))
                            ]),
                            SizedBox(height: 30),
                            PetFormHeader('이름'),
                            SizedBox(height: 10),
                            PetTextField(
                                controller: _nameController,
                                hintText: '이름을 입력하세요.',
                                validator: (text) => (text ?? "").length == 0
                                    ? '이름을 입력해주세요.'
                                    : null),
                            SizedDivider(),
                            PetFormHeader('생년월일'),
                            SizedBox(height: 10),
                            PetTextField(
                              controller: _birthdayController,
                              hintText: '생년월일을 입력하세요.',
                              readOnly: true,
                              onTap: () {
                                print("tap");
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1960),
                                        lastDate: DateTime.now())
                                    .then((pickedDate) {
                                  if (pickedDate == null) {
                                    return;
                                  }
                                  setState(() {
                                    _pickedPetDate = pickedDate;
                                    _birthdayController.text =
                                        DateFormat('yyyy년 MM월 dd일')
                                            .format(pickedDate);
                                  });
                                });
                              },
                              validator: (text) => (text ?? "").length == 0
                                  ? '생년월일을 입력해주세요.'
                                  : null,
                            ),
                            SizedBox(height: 30),
                            PetFormHeader('몸무게'),
                            SizedBox(height: 10),
                            PetTextField(
                              controller: _weightController,
                              suffixIcon: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Text('Kg',
                                      style: TextStyle(fontSize: 16))),
                              hintText: '몸무게를 입력하세요.',
                              keyboardType: TextInputType.number,
                              validator: (text) => (text ?? "").length == 0
                                  ? '몸무게를 입력해주세요.'
                                  : null,
                            ),
                            SizedBox(height: 20),
                            Wrap(children: [
                              Container(
                                  height: 30,
                                  width: 70,
                                  child: Row(children: [
                                    SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Radio<SexChoice>(
                                            value: SexChoice.male,
                                            groupValue: _choice,
                                            onChanged: (SexChoice? value) =>
                                                setState(
                                                    () => _choice = value))),
                                    SizedBox(width: 5),
                                    Text('남자', style: font_16_w900)
                                  ])),
                              Container(
                                  height: 30,
                                  width: 100,
                                  child: Row(children: [
                                    SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Radio<SexChoice>(
                                            value: SexChoice.female,
                                            groupValue: _choice,
                                            onChanged: (SexChoice? value) =>
                                                setState(
                                                    () => _choice = value))),
                                    SizedBox(width: 5),
                                    Text('여자', style: font_16_w900)
                                  ]))
                            ]),
                            SizedBox(height: 30),
                            PetFormHeader('품종'),
                            SizedBox(height: 10),
                            BlocBuilder<KindCubit, KindState>(
                                builder: (context, state) {
                              if (state.isLoaded == true &&
                                  petIsSelectedIndex != 2) {
                                var dropdownValue =
                                    _petCubit.state.isComplete == true &&
                                            _petCubit.state.id != null
                                        ? _kindController.text
                                        : state.sortAnimals![petIsSelectedIndex]
                                            .kinds!.first.kind!;

                                return Container(
                                    height: 44,
                                    child: DropdownButtonFormField<String>(
                                        value: dropdownValue,
                                        elevation: 16,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 15),
                                            enabledBorder: outline,
                                            focusedBorder: outline_focus,
                                            border: outline),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        onChanged: (String? value) =>
                                            setState(() {
                                              _kindController.text = value!;
                                              dropdownValue = value;
                                            }),
                                        items: [
                                          for (var kind in state
                                              .sortAnimals![petIsSelectedIndex]
                                              .kinds!)
                                            DropdownMenuItem(
                                                value: kind.kind,
                                                child: Text(kind.kind!))
                                        ]));
                              } else {
                                return TextFormField(
                                    controller: _kindController,
                                    textAlignVertical: TextAlignVertical.center,
                                    readOnly:
                                        petIsSelectedIndex == 2 ? false : true,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        enabledBorder: outline,
                                        focusedBorder: outline_focus,
                                        border: outline,
                                        hintText: '품종을 입력하세요.'),
                                    validator: (text) =>
                                        (text ?? "").length == 0
                                            ? '품종을 입력해주세요.'
                                            : null);
                              }
                            }),
                            SizedBox(height: 30),
                            Text('내원병원', style: font_17_w900),
                            SizedBox(height: 10),
                            PetTextField(
                                controller: _kopoController,
                                readOnly: true,
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => KpostalView(
                                        useLocalServer: false,
                                        callback: (Kpostal result) {
                                          setState(() {
                                            _kopoController.text =
                                                result.address;
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                },
                                suffixIcon: Icon(Icons.search),
                                hintText: '주소를 입력하세요'),
                            SizedBox(height: 10),
                            PetTextField(
                              controller: _addressController,
                              hintText: '상세 주소를 입력하세요.',
                            ),
                            Container(
                                height: 0.5,
                                width: double.maxFinite,
                                color: Colors.black12,
                                margin: EdgeInsets.symmetric(vertical: 30)),
                            PetFormHeader('중성화 수술 유무'),
                            SizedBox(height: 10),
                            Wrap(children: [
                              Container(
                                  height: 30,
                                  width: 70,
                                  child: Row(children: [
                                    SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Radio<NeutralizeChoice>(
                                            value: NeutralizeChoice.yes,
                                            groupValue: _neutralizeChoice,
                                            onChanged:
                                                (NeutralizeChoice? value) =>
                                                    setState(() =>
                                                        _neutralizeChoice =
                                                            value))),
                                    SizedBox(width: 5),
                                    Text('유',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))
                                  ])),
                              Container(
                                  height: 30,
                                  width: 70,
                                  child: Row(children: [
                                    SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Radio<NeutralizeChoice>(
                                            value: NeutralizeChoice.no,
                                            groupValue: _neutralizeChoice,
                                            onChanged:
                                                (NeutralizeChoice? value) =>
                                                    setState(() =>
                                                        _neutralizeChoice =
                                                            value))),
                                    SizedBox(width: 5),
                                    Text('무',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))
                                  ])),
                              Container(
                                  height: 30,
                                  width: 80,
                                  child: Row(children: [
                                    SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Radio<NeutralizeChoice>(
                                            value: NeutralizeChoice.dontknow,
                                            groupValue: _neutralizeChoice,
                                            onChanged:
                                                (NeutralizeChoice? value) =>
                                                    setState(() =>
                                                        _neutralizeChoice =
                                                            value))),
                                    SizedBox(width: 5),
                                    Text('모름',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))
                                  ]))
                            ]),
                            SizedBox(height: 50),
                            PetFormHeader('관심 질병'),
                            SizedBox(height: 10),
                            PetTextField(
                              controller: _interestController,
                              hintText: '관심 있는 질병을 입력하세요.',
                              validator: (text) => (text ?? "").length == 0
                                  ? '관심 있는 질을병 입력해주세요.'
                                  : null,
                            ),
                            SizedBox(height: 30),
                            PetFormHeader('알러지 유무'),
                            SizedBox(height: 10),
                            Wrap(children: [
                              Container(
                                  height: 30,
                                  width: 70,
                                  child: Row(children: [
                                    SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Radio<AllergicChoice>(
                                            value: AllergicChoice.yes,
                                            groupValue: _allergicChoice,
                                            onChanged:
                                                (AllergicChoice? value) =>
                                                    setState(() =>
                                                        _allergicChoice =
                                                            value))),
                                    SizedBox(width: 5),
                                    Text('유',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))
                                  ])),
                              Container(
                                  height: 30,
                                  width: 70,
                                  child: Row(children: [
                                    SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Radio<AllergicChoice>(
                                            value: AllergicChoice.no,
                                            groupValue: _allergicChoice,
                                            onChanged:
                                                (AllergicChoice? value) =>
                                                    setState(() =>
                                                        _allergicChoice =
                                                            value))),
                                    SizedBox(width: 5),
                                    Text('무',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))
                                  ])),
                              Container(
                                  height: 30,
                                  width: 80,
                                  child: Row(children: [
                                    SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Radio<AllergicChoice>(
                                            value: AllergicChoice.dontknow,
                                            groupValue: _allergicChoice,
                                            onChanged:
                                                (AllergicChoice? value) =>
                                                    setState(() =>
                                                        _allergicChoice =
                                                            value))),
                                    SizedBox(width: 5),
                                    Text('모름',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))
                                  ]))
                            ]),
                            (_petCubit.isEdit)
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 50),
                                      Text(
                                          "종류는 변경이 불가능합니다. 반려동물 종류 변경을 원하시는 경우 삭제 후 재 등록해 주세요.",
                                          style: font_14_w500),
                                      const SizedBox(height: 20),
                                      GestureDetector(
                                          onTap: () => _petCubit
                                              .deletePet(state.id!.toString()),
                                          child: Text('반려동물 정보 삭제하기',
                                              style: font_16_w700.copyWith(
                                                  color: Colors.red,
                                                  decoration: TextDecoration
                                                      .underline)))
                                    ],
                                  )
                                : const SizedBox(height: 0),
                            SizedBox(height: 80),
                          ]));
                }))),
        bottomNavigationBar: GestureDetector(
            onTap: () {
              final validate = _formKey.currentState?.validate();

              if (validate ?? false) {
                // 완료
                _petCubit.setPet(
                  image: _image?.path,
                  sort: PetSort.values[petIsSelectedIndex],
                  kind: _kindController.text.trim(),
                  name: _nameController.text.trim(),
                  birthday:
                      DateFormat('yyyy-MM-dd').format(_pickedPetDate!).trim(),
                  weight: _weightController.text,
                  hospital1: _addressController.text.trim(),
                  hospital2: _kopoController.text.trim(),
                  interestedDisease: _interestController.text.trim(),
                  sexChoice: _choice,
                  allergicChoice: _allergicChoice,
                  neutralizeChoice: _neutralizeChoice,
                );

                if (_petCubit.isEdit) {
                  // 수정하기
                  _petCubit.updatePet().then((animal) {
                    if (animal != null) {
                      var user = _authenticationBloc.state.user;

                      var animals = _authenticationBloc.state.user.animals ?? [];
                      animals.add(animal);
                      user.copyWith(animals: animals);
                      _authenticationBloc.add(AuthenticationUserChanged(user));
                    }
                  });
                } else {
                  // 등록하기
                  _petCubit.registerPet().then((animal) {
                    if (animal != null) {
                      var user = _authenticationBloc.state.user;

                      var animals = _authenticationBloc.state.user.animals ?? [];
                      animals.add(animal);
                      user.copyWith(animals: animals);
                      _authenticationBloc.add(AuthenticationUserChanged(user));
                    }
                  });
                }
              }
            },
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black38, width: 1))),
                height: 75,
                child: Text('등록하기',
                    style: font_17_w900.copyWith(color: primaryColor)))));
  }
}

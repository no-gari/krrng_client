import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kpostal/kpostal.dart';
import 'package:krrng_client/modules/pet/cubit/pet_cubit.dart';
import 'package:krrng_client/support/style/theme.dart';
import '../components/components.dart';
import '../enums.dart';

class PetRegisterPage extends StatefulWidget {
  const PetRegisterPage({Key? key}) : super(key: key);

  @override
  State<PetRegisterPage> createState() => _PetRegisterPageState();
}

class _PetRegisterPageState extends State<PetRegisterPage> {

  late PetCubit _petCubit;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _weightController = TextEditingController();
  final _addressController = TextEditingController();
  final _kopoController = TextEditingController();
  final _interestController = TextEditingController();

  int petIsSelectedIndex = 0;

  SexChoice? _choice = SexChoice.male;
  NeutralizeChoice? _neutralizeChoice = NeutralizeChoice.yes;
  AllergicChoice? _allergicChoice = AllergicChoice.yes;

  @override
  void initState() {
    super.initState();
    _petCubit = BlocProvider.of<PetCubit>(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthdayController.dispose();
    _weightController.dispose();
    _addressController.dispose();
    _interestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: Text('반려동물 관리', style: Theme.of(context).textTheme.headline2)),
        body: SafeArea( child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<PetCubit, PetState>(
              builder: (context, state) {
                return Form(key: _formKey, child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      print("tap picture");
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        alignment: Alignment.center,
                        child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.black12,
                            child: Icon(Icons.add, size: 32, color: Colors.grey))),
                  ),
                  PetFormHeader('종류'),
                  SizedBox(height: 10),
                  Row(children: [
                    PetContainer(
                        path: 'assets/images/pic1.png',
                        title: '강아지',
                        isSelected: petIsSelectedIndex == 0,
                        onTap: () => setState(() => petIsSelectedIndex = 0)),
                    SizedBox(width: 10),
                    PetContainer(
                        path: 'assets/images/pic2.png',
                        title: '고양이',
                        isSelected: petIsSelectedIndex == 1,
                        onTap: () => setState(() => petIsSelectedIndex = 1)),
                    SizedBox(width: 10),
                    PetContainer(
                        path: 'assets/images/pic3.png',
                        title: '기타',
                        isSelected: petIsSelectedIndex == 2,
                        onTap: () => setState(() => petIsSelectedIndex = 2))
                  ]),
                  SizedBox(height: 30),
                  PetFormHeader('이름'),
                  SizedBox(height: 10),
                  PetTextField(
                      controller: _nameController,
                      hintText: '이름을 입력하세요.',
                      validator: (text) => (text ?? "").length == 0 ? '이름을 입력해주세요.' : null
                  ),
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
                          lastDate: DateTime.now()).then((pickedDate) {
                        if (pickedDate == null) {
                          return;
                        }
                        setState(() {
                          _birthdayController.text = DateFormat('yyyy년 MM월 dd일').format(pickedDate);
                        });
                      });
                    },
                    validator: (text) => (text ?? "").length == 0 ? '생년월일을 입력해주세요.' : null,
                  ),
                  SizedBox(height: 30),
                  PetFormHeader('몸무게'),
                  SizedBox(height: 10),
                  PetTextField(
                    controller: _weightController,
                    suffixIcon: Padding(padding: EdgeInsets.symmetric(vertical: 15), child: Text('Kg', style: TextStyle(fontSize: 16))),
                    hintText: '몸무게를 입력하세요.',
                    keyboardType: TextInputType.number,
                    validator: (text) => (text ?? "").length == 0 ? '몸무게를 입력해주세요.' : null,
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
                                  onChanged: (SexChoice? value) => setState(() => _choice = value))),
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
                                  onChanged: (SexChoice? value) => setState(() => _choice = value))),
                          SizedBox(width: 5),
                          Text('여자', style: font_16_w900)
                        ]))
                  ]),
                  SizedBox(height: 50),
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
                                  _kopoController.text = result.address;
                                });
                              },
                            ),
                          ),
                        );
                      },
                      validator: (text) => (text ?? "").length == 0 ? '주소를 입력해주세요.' : null,
                      suffixIcon: Icon(Icons.search),
                      hintText: '주소를 입력하세요'
                  ),
                  SizedBox(height: 10),
                  PetTextField(
                    controller: _addressController,
                    hintText: '상세 주소를 입력하세요.',
                    validator: (text) => (text ?? "").length == 0 ? '상세 주소를 입력해주세요.' : null,
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
                                  onChanged: (NeutralizeChoice? value) =>
                                      setState(() =>
                                      _neutralizeChoice = value))),
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
                                  onChanged: (NeutralizeChoice? value) =>
                                      setState(() =>
                                      _neutralizeChoice = value))),
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
                                  onChanged: (NeutralizeChoice? value) =>
                                      setState(() =>
                                      _neutralizeChoice = value))),
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
                    validator: (text) => (text ?? "").length == 0 ? '관심 있는 질을병 입력해주세요.' : null,
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
                                  onChanged: (AllergicChoice? value) =>
                                      setState(
                                              () => _allergicChoice = value))),
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
                                  onChanged: (AllergicChoice? value) =>
                                      setState(
                                              () => _allergicChoice = value))),
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
                                  onChanged: (AllergicChoice? value) =>
                                      setState(
                                              () => _allergicChoice = value))),
                          SizedBox(width: 5),
                          Text('모름',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold))
                        ]))
                  ]),
                  (state.isEdit ?? false) ? const SizedBox(height: 0) :
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Text("종류는 변경이 불가능합니다. 반려동물 종류 변경을 원하시는 경우 삭제 후 재 등록해 주세요.", style: font_14_w500),
                      const SizedBox(height: 20),
                      Text('반려동물 정보 삭제하기',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                              color: Colors.red,
                              decoration: TextDecoration.underline)),
                    ],
                  ),
                  SizedBox(height: 80),
                ])
                );
          })
        )),
        bottomNavigationBar: GestureDetector(
            onTap: () {
              final validate = _formKey.currentState?.validate();

              if (validate ?? false) {
                // 완료
                _petCubit.setPet(
                  // image
                  name: _nameController.text,
                  birthday: _birthdayController.text,
                  weight: int.parse(_weightController.text),
                  sexChoice: _choice,
                  allergicChoice: _allergicChoice,
                  neutralizeChoice: _neutralizeChoice,
                );

                if (_petCubit.state.isEdit ?? false) {
                  // 등록하기
                  _petCubit.registerPet();
                } else {
                  // 수정하기
                  _petCubit.updatePet();
                }
              }
            },
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black38, width: 1))),
                height: 75,
                child: Text('등록하기', style: font_17_w900.copyWith(color: primaryColor))
            )
        )
    );
  }
}

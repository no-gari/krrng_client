import 'package:flutter/material.dart';
import 'package:krrng_client/modules/pet_register/components/pet_container.dart';
import 'package:krrng_client/modules/pet_register/components/pet_textfield.dart';
import 'package:krrng_client/modules/pet_register/components/sized_divider.dart';
import '../enums.dart';

class PetRegisterPage extends StatefulWidget {
  const PetRegisterPage({Key? key}) : super(key: key);

  @override
  State<PetRegisterPage> createState() => _PetRegisterPageState();
}

class _PetRegisterPageState extends State<PetRegisterPage> {
  final _nameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _weightController = TextEditingController();
  final _addressController = TextEditingController();
  final _interestController = TextEditingController();

  int petIsSelectedIndex = 0;

  SexChoice? _choice = SexChoice.male;
  NeutralizeChoice? _neutralizeChoice = NeutralizeChoice.yes;
  AllergicCHoice? _allergicCHoice = AllergicCHoice.yes;

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
            title:
                Text('반려동물 관리', style: Theme.of(context).textTheme.headline2)),
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 30),
                          alignment: Alignment.center,
                          child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.black12,
                              child: Icon(Icons.add,
                                  size: 32, color: Colors.grey))),
                      Text('종류',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Row(children: [
                        PetContainer(
                            path: 'assets/images/pic1.png',
                            title: '강아지',
                            isSelected: petIsSelectedIndex == 0,
                            onTap: () =>
                                setState(() => petIsSelectedIndex = 0)),
                        SizedBox(width: 10),
                        PetContainer(
                            path: 'assets/images/pic2.png',
                            title: '고양이',
                            isSelected: petIsSelectedIndex == 1,
                            onTap: () =>
                                setState(() => petIsSelectedIndex = 1)),
                        SizedBox(width: 10),
                        PetContainer(
                            path: 'assets/images/pic3.png',
                            title: '기타',
                            isSelected: petIsSelectedIndex == 2,
                            onTap: () => setState(() => petIsSelectedIndex = 2))
                      ]),
                      SizedBox(height: 30),
                      Text('직책', style: Theme.of(context).textTheme.headline3),
                      SizedBox(height: 10),
                      PetTextField(
                          controller: _nameController, hintText: '이름을 입력하세요.'),
                      SizedDivider(),
                      Text('생년월일',
                          style: Theme.of(context).textTheme.headline3),
                      SizedBox(height: 10),
                      PetTextField(
                          controller: _birthdayController,
                          hintText: '생년월일을 입력하세요.'),
                      SizedBox(height: 30),
                      Text('몸무게', style: Theme.of(context).textTheme.headline3),
                      SizedBox(height: 10),
                      PetTextField(
                          controller: _weightController,
                          suffixIcon: Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child:
                                  Text('Kg', style: TextStyle(fontSize: 16))),
                          hintText: '몸무게를 입력하세요.'),
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
                                          setState(() => _choice = value))),
                              SizedBox(width: 5),
                              Text('남자',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))
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
                                          setState(() => _choice = value))),
                              SizedBox(width: 5),
                              Text('여자',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))
                            ]))
                      ]),
                      SizedBox(height: 50),
                      Text('내원병원',
                          style: Theme.of(context).textTheme.headline3),
                      SizedBox(height: 10),
                      PetTextField(
                          readOnly: true,
                          suffixIcon: Icon(Icons.search),
                          hintText: '주소를 입력하세요'),
                      SizedBox(height: 10),
                      PetTextField(
                          controller: _addressController,
                          hintText: '상세 주소를 입력하세요.'),
                      Container(
                          height: 0.5,
                          width: double.maxFinite,
                          color: Colors.black12,
                          margin: EdgeInsets.symmetric(vertical: 30)),
                      Text('중성화 수술 유무',
                          style: Theme.of(context).textTheme.headline3),
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
                      Text('관심질병',
                          style: Theme.of(context).textTheme.headline2),
                      SizedBox(height: 10),
                      PetTextField(
                          controller: _interestController,
                          hintText: '관심 있는 질병을 입력하세요.'),
                      SizedBox(height: 30),
                      Text('알러지 유무',
                          style: Theme.of(context).textTheme.headline2),
                      SizedBox(height: 10),
                      Wrap(children: [
                        Container(
                            height: 30,
                            width: 70,
                            child: Row(children: [
                              SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Radio<AllergicCHoice>(
                                      value: AllergicCHoice.yes,
                                      groupValue: _allergicCHoice,
                                      onChanged: (AllergicCHoice? value) =>
                                          setState(
                                              () => _allergicCHoice = value))),
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
                                  child: Radio<AllergicCHoice>(
                                      value: AllergicCHoice.no,
                                      groupValue: _allergicCHoice,
                                      onChanged: (AllergicCHoice? value) =>
                                          setState(
                                              () => _allergicCHoice = value))),
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
                                  child: Radio<AllergicCHoice>(
                                      value: AllergicCHoice.dontknow,
                                      groupValue: _allergicCHoice,
                                      onChanged: (AllergicCHoice? value) =>
                                          setState(
                                              () => _allergicCHoice = value))),
                              SizedBox(width: 5),
                              Text('모름',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))
                            ]))
                      ]),
                      SizedBox(height: 50),
                      Text('반려동물 정보 삭제하기',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  color: Colors.red,
                                  decoration: TextDecoration.underline)),
                      SizedBox(height: 80),
                    ]))),
        bottomNavigationBar: GestureDetector(
            onTap: () {},
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black38, width: 1))),
                height: 75,
                child: Text('등록하기',
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Theme.of(context).accentColor)))));
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/modules/authentication/signin/cubit/signin_cubit.dart';
import 'package:krrng_client/modules/mypage/view/mypage_screen.dart';
import 'package:krrng_client/modules/pet/components/pet_textfield.dart';
import 'package:krrng_client/modules/pet/enums.dart';
import 'package:krrng_client/repositories/authentication_repository/authentication_repository.dart';
import 'package:krrng_client/support/style/theme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vrouter/vrouter.dart';

class ProfileChangePage extends StatefulWidget {
  const ProfileChangePage({Key? key}) : super(key: key);

  @override
  State<ProfileChangePage> createState() => _ProfileChangePageState();
}

class _ProfileChangePageState extends State<ProfileChangePage> {
  late AuthenticationBloc _authenticationBloc;
  late SignInCubit _signInCubit;

  final _nameEditingController = TextEditingController();
  final _birthdayController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  XFile? _image;
  DateTime? _pickedBirthday;
  SexChoice? _choice;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _signInCubit = BlocProvider.of<SignInCubit>(context);
    _choice =
        SexChoice.getValueByEnum(_authenticationBloc.state.user.sexChoices!);
  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title:
                Text('내 정보 변경', style: Theme.of(context).textTheme.headline2)),
        bottomSheet:
            BlocBuilder<SignInCubit, SignInState>(builder: (context, state) {
          return MaterialButton(
              color: Colors.white,
              height: 75,
              padding: EdgeInsets.zero,
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.black38, width: 1))),
                  height: 75,
                  child: Text('변경하기',
                      style: font_17_w900.copyWith(color: primaryColor))),
              onPressed: () async {
                await _signInCubit.updateProfile(
                    profileImage: _image?.path,
                    birthday: DateFormat('yyyy-MM-dd')
                        .format(_pickedBirthday!)
                        .trim(),
                    nickname: _nameEditingController.text,
                    sexChoices: _choice?.value);
                _authenticationBloc.emit(AuthenticationState.authenticated(
                    _authenticationBloc.state.user.copyWith(
                        profileImage: _image?.path,
                        birthday: DateFormat('yyyy-MM-dd')
                            .format(_pickedBirthday!)
                            .trim(),
                        nickname: _nameEditingController.text,
                        sexChoices: _choice?.value)));
                context.vRouter.to(MyPageScreen.routeName);
              });
        }),
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                  print(state.user.sexChoices);
                  if (state.status == AuthenticationStatus.authenticated) {
                    if (state.user.birthday != null) {
                      _birthdayController.text = state.user.birthday!;
                      _pickedBirthday = DateFormat('yyyy-MM-dd')
                          .parse(state.user.birthday ?? "");
                    }
                    if (state.user.nickname != null) {
                      _nameEditingController.text = state.user.nickname!;
                    }

                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),
                          GestureDetector(
                              onTap: () async {
                                PermissionStatus status =
                                    await Permission.camera.request();

                                if (!status.isGranted) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            content: Text("권한 설정을 확인해주세요."),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      openAppSettings(),
                                                  child: Text('설정하기')),
                                            ]);
                                      });
                                } else {
                                  var image = await _picker.pickImage(
                                      source: ImageSource.gallery);
                                  setState(() {
                                    if (image != null) {
                                      _image = image;
                                    }
                                  });
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.only(top: 30, bottom: 50),
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.black12,
                                      child: state.user.profileImage == null
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
                                              child: Image.network(
                                                  state.user.profileImage!,
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover))))),
                          Text('닉네임',
                              style: Theme.of(context).textTheme.headline3),
                          SizedBox(height: 10),
                          TextField(
                              autofocus: true,
                              controller: _nameEditingController,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide:
                                          BorderSide(color: Color(0xFFDFE2E9))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:
                                          BorderSide(color: Color(0xFFDFE2E9))),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide:
                                          BorderSide(color: Color(0xFFDFE2E9))),
                                  hintText: '이름을 입력 하세요.')),
                          SizedBox(height: 25),
                          Text('생년월일',
                              style: Theme.of(context).textTheme.headline3),
                          SizedBox(height: 10),
                          PetTextField(
                            controller: _birthdayController,
                            hintText: '생년월일을 입력하세요',
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
                                  _pickedBirthday = pickedDate;
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
                          SizedBox(height: 25),
                          Text('성별',
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
                                      child: Radio<SexChoice>(
                                          value: SexChoice.male,
                                          groupValue: _choice,
                                          onChanged: (SexChoice? value) =>
                                              setState(() => _choice = value))),
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
                                              setState(() => _choice = value))),
                                  SizedBox(width: 5),
                                  Text('여자', style: font_16_w900)
                                ]))
                          ]),

                          // SizedBox(height: 25),
                          // Text('이메일',
                          //     style: Theme.of(context).textTheme.headline3),
                          // SizedBox(height: 10),
                          // TextField(
                          //     controller: _emailEditingController,
                          //     textAlignVertical: TextAlignVertical.center,
                          //     decoration: InputDecoration(
                          //         contentPadding:
                          //             EdgeInsets.symmetric(horizontal: 15),
                          //         enabledBorder: OutlineInputBorder(
                          //             borderRadius: BorderRadius.circular(15.0),
                          //             borderSide:
                          //                 BorderSide(color: Color(0xFFDFE2E9))),
                          //         focusedBorder: OutlineInputBorder(
                          //             borderRadius: BorderRadius.circular(15),
                          //             borderSide:
                          //                 BorderSide(color: Color(0xFFDFE2E9))),
                          //         border: OutlineInputBorder(
                          //             borderRadius: BorderRadius.circular(15.0),
                          //             borderSide:
                          //                 BorderSide(color: Color(0xFFDFE2E9))),
                          //         hintText: '이메일을 입력 하세요.'))
                        ]);
                  }
                  return Center(
                      child: Image.asset('assets/images/indicator.gif',
                          width: 100, height: 100));
                }))));
  }
}

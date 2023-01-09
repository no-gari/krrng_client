import 'package:krrng_client/repositories/authentication_repository/authentication_repository.dart';
import 'package:krrng_client/repositories/user_repository/src/user_repository.dart';
import 'package:krrng_client/modules/authentication/signin/cubit/signin_cubit.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/repositories/user_repository/models/user.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:krrng_client/modules/mypage/view/mypage_screen.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:krrng_client/support/style/theme.dart';
import 'package:krrng_client/modules/pet/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';
import 'package:intl/intl.dart';
import 'dart:io';

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

  bool changed = false;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _signInCubit = BlocProvider.of<SignInCubit>(context);
    _choice =
        SexChoice.getValueByEnum(_authenticationBloc.state.user.sexChoices!);
    getUserInfo();
  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  void getUserInfo() {
    if (_authenticationBloc.state.user.birthday != null) {
      setState(() {
        _birthdayController.text = _authenticationBloc.state.user.birthday!;
        _pickedBirthday = DateFormat('yyyy-MM-dd')
            .parse(_authenticationBloc.state.user.birthday ?? "");
      });
    }
    if (_authenticationBloc.state.user.nickname != null) {
      setState(() {
        _nameEditingController.text = _authenticationBloc.state.user.nickname!;
      });
    }
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
                setState(() {
                  changed = true;
                });
                if (_image?.path != null) {
                  await _signInCubit
                      .updateProfile(
                          profileImage: _image!.path,
                          birthday: DateFormat('yyyy-MM-dd')
                              .format(_pickedBirthday!)
                              .trim(),
                          nickname: _nameEditingController.text,
                          sexChoices: _choice?.value)
                      .then((_) async {
                    ApiResult<User> apiResult =
                        await RepositoryProvider.of<UserRepository>(context)
                            .getUser();
                    apiResult.when(
                        success: (User? user) {
                          _authenticationBloc
                              .emit(AuthenticationState.authenticated(user!));
                        },
                        failure: (NetworkExceptions? error) {});
                  });
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            content: Text("완료되었습니다."),
                            insetPadding:
                                const EdgeInsets.fromLTRB(0, 80, 0, 80),
                            actions: [
                              TextButton(
                                  child: const Text('확인'),
                                  onPressed: () {
                                    context.vRouter.to(MyPageScreen.routeName);
                                  })
                            ]);
                      });
                } else {
                  await _signInCubit
                      .updateProfile(
                          birthday: DateFormat('yyyy-MM-dd')
                              .format(_pickedBirthday!)
                              .trim(),
                          nickname: _nameEditingController.text,
                          sexChoices: _choice?.value)
                      .then((_) async {
                    ApiResult<User> apiResult =
                        await RepositoryProvider.of<UserRepository>(context)
                            .getUser();
                    apiResult.when(
                        success: (User? user) {
                          _authenticationBloc
                              .emit(AuthenticationState.authenticated(user!));
                        },
                        failure: (NetworkExceptions? error) {});
                  });
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            content: Text("완료되었습니다."),
                            insetPadding:
                                const EdgeInsets.fromLTRB(0, 80, 0, 80),
                            actions: [
                              TextButton(
                                  child: const Text('확인'),
                                  onPressed: () {
                                    context.vRouter.to(MyPageScreen.routeName);
                                  })
                            ]);
                      });
                }
              });
        }),
        body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SafeArea(
                child: changed == false
                    ? SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: BlocConsumer<AuthenticationBloc,
                            AuthenticationState>(listener: (context, state) {
                          if (state.user.birthday != null) {
                            setState(() {
                              _birthdayController.text = state.user.birthday!;
                              _pickedBirthday = DateFormat('yyyy-MM-dd')
                                  .parse(state.user.birthday ?? "");
                            });
                          }
                          if (state.user.nickname != null) {
                            setState(() {
                              _nameEditingController.text =
                                  state.user.nickname!;
                            });
                          }
                        }, builder: (context, state) {
                          if (state.status ==
                              AuthenticationStatus.authenticated) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 30),
                                  GestureDetector(
                                      onTap: () async {
                                        PermissionStatus status =
                                            await Permission.camera.request();

                                        if (status.isGranted == true) {
                                          var image = await _picker.pickImage(
                                              source: ImageSource.gallery);
                                          setState(() {
                                            if (image != null) {
                                              _image = image;
                                            }
                                          });
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    content:
                                                        Text("권한 설정을 확인해주세요."),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () =>
                                                              openAppSettings(),
                                                          child: Text('설정하기')),
                                                    ]);
                                              });
                                        }
                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              top: 30, bottom: 50),
                                          alignment: Alignment.center,
                                          child: CircleAvatar(
                                            radius: 40,
                                            backgroundColor: Colors.black12,
                                            child: state.user.profileImage ==
                                                    null
                                                ? _image == null
                                                    ? Icon(Icons.add,
                                                        size: 32,
                                                        color: Colors.grey)
                                                    : Image.file(
                                                        File(_image!.path),
                                                        fit: BoxFit.cover)
                                                : _image == null
                                                    ? Container(
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    state.user
                                                                        .profileImage!),
                                                                fit: BoxFit
                                                                    .cover)),
                                                      )
                                                    : ClipOval(
                                                        child: Image.file(
                                                            File(_image!.path),
                                                            width: 80,
                                                            height: 80,
                                                            fit: BoxFit.cover),
                                                      ),
                                          ))),
                                  Text('닉네임',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3),
                                  SizedBox(height: 10),
                                  TextField(
                                      autofocus: true,
                                      controller: _nameEditingController,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: BorderSide(
                                                  color: Color(0xFFDFE2E9))),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: Color(0xFFDFE2E9))),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: BorderSide(
                                                  color: Color(0xFFDFE2E9))),
                                          hintText: '이름을 입력 하세요.')),
                                  SizedBox(height: 25),
                                  Text('생년월일',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3),
                                  SizedBox(height: 10),
                                  TextFormField(
                                      controller: _birthdayController,
                                      readOnly: true,
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                                confirmText: '확인',
                                                cancelText: '취소',
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1960),
                                                lastDate: DateTime.now());
                                        if (pickedDate != null) {
                                          setState(() {
                                            _pickedBirthday = pickedDate;
                                            _birthdayController.text =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(pickedDate)
                                                    .toString();
                                            print(_pickedBirthday);
                                            print(_birthdayController.text);
                                          });
                                        }
                                      },
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: BorderSide(
                                                  color: Color(0xFFDFE2E9))),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: Color(0xFFDFE2E9))),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: BorderSide(
                                                  color: Color(0xFFDFE2E9))))),
                                  SizedBox(height: 25),
                                  Text('성별',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3),
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
                                                  onChanged:
                                                      (SexChoice? value) =>
                                                          setState(() =>
                                                              _choice =
                                                                  value))),
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
                                                  onChanged:
                                                      (SexChoice? value) =>
                                                          setState(() =>
                                                              _choice =
                                                                  value))),
                                          SizedBox(width: 5),
                                          Text('여자', style: font_16_w900)
                                        ]))
                                  ]),
                                  SizedBox(height: 100),
                                ]);
                          }
                          return Center(
                              child: Image.asset('assets/images/indicator.gif',
                                  width: 100, height: 100));
                        }))
                    : Center(
                        child: Image.asset('assets/images/indicator.gif',
                            width: 100, height: 100)))));
  }
}

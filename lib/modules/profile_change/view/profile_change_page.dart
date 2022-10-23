import 'package:flutter/material.dart';

enum SexChoice { male, female }

class ProfileChangePage extends StatefulWidget {
  const ProfileChangePage({Key? key}) : super(key: key);

  @override
  State<ProfileChangePage> createState() => _ProfileChangePageState();
}

class _ProfileChangePageState extends State<ProfileChangePage> {
  SexChoice? _choice = SexChoice.male;
  final _nameEditingController = TextEditingController();
  final _emailEditingController = TextEditingController();

  @override
  void dispose() {
    _nameEditingController.dispose();
    _emailEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('내 정보 변경', style: Theme.of(context).textTheme.headline2),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Text('이름', style: Theme.of(context).textTheme.headline3),
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
                      TextField(
                          onTap: () => print('clicked'),
                          readOnly: true,
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
                              suffixIcon: IconButton(
                                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                                  color: Colors.black,
                                  onPressed: () {}),
                              hintText: '생년월일을 입력 하세요.')),
                      SizedBox(height: 25),
                      Text('성별', style: Theme.of(context).textTheme.headline3),
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
                              Text('남자', style: TextStyle(fontSize: 16))
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
                              Text('여자', style: TextStyle(fontSize: 16))
                            ]))
                      ]),
                      SizedBox(height: 25),
                      Text('이메일', style: Theme.of(context).textTheme.headline3),
                      SizedBox(height: 10),
                      TextField(
                          controller: _emailEditingController,
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
                              hintText: '이메일을 입력 하세요.'))
                    ]))));
  }
}

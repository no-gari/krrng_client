import 'package:flutter/material.dart';

List<String> optionList = ['병원', '진료비'];

class SearchDropdownButton extends StatefulWidget {
  const SearchDropdownButton({super.key});

  @override
  State<SearchDropdownButton> createState() => _SearchDropdownButtonState();
}

class _SearchDropdownButtonState extends State<SearchDropdownButton> {
  String dropdownValue = optionList.first;

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      DropdownButton<String>(
          isDense: true,
          iconSize: 12,
          value: dropdownValue,
          icon: Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.black),
          selectedItemBuilder: (BuildContext ctxt) {
            return optionList.map<Widget>((item) {
              return DropdownMenuItem(child: Text("${item}"), value: item);
            }).toList();
          },
          underline: Container(),
          onChanged: (String? value) {
            setState(() => dropdownValue = value!);
          },
          items: optionList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                    style: TextStyle(color: Colors.black, fontSize: 14)));
          }).toList())
    ]);
  }
}

import 'package:flutter/material.dart';

class WallletDropDownButton extends StatelessWidget {
  final String defaultVal;
  final dynamic listVal;
  final List list;
  final Function onChanged;

  WallletDropDownButton({this.defaultVal, this.listVal, this.list, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Valyutanı seçin: '),
      trailing: DropdownButton(
        style: TextStyle(color: Colors.white, fontSize: 17),
        underline: SizedBox(),
        hint: Text(defaultVal, style: TextStyle(color: Colors.white60),),
        dropdownColor: Color(0XFF009BFF),
        value: listVal,
        items: list.map((val) => DropdownMenuItem(child: Text(val), value: val,)).toList(),
        onChanged: onChanged
      ),
    );
  }
}

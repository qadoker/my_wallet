import 'package:flutter/material.dart';

class WallletDropDownButton extends StatelessWidget {
  final String defaultVal;
  final dynamic listVal;
  final List list;
  final Function onChanged;
  final String text;
  final Color textColor;
  final Color hintColor;
  final Color dropdownColor;
  final Color dropdownTextColor;
  final Color iconColor;

  WallletDropDownButton(
      {this.defaultVal,
      this.listVal,
      this.list,
      this.onChanged,
      this.text,
      this.textColor,
      this.dropdownColor,
      this.dropdownTextColor,
      this.hintColor,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      trailing: DropdownButton(
          icon: Icon(IconData(Icons.arrow_drop_down.codePoint, fontFamily: 'MaterialIcons'), color: iconColor,),
          style: TextStyle(color: dropdownTextColor, fontSize: 17),
          underline: SizedBox(),
          hint: Text(
            defaultVal,
            style: TextStyle(color: hintColor),
          ),
          dropdownColor: dropdownColor,
          value: listVal,
          items: list
              .map((val) => DropdownMenuItem(
                    child: Text(val),
                    value: val,
                  ))
              .toList(),
          onChanged: onChanged),
    );
  }
}

import 'package:flutter/material.dart';

class WalletTextFormField extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  final bool obscureText;
  WalletTextFormField(
      {@required this.hintText, @required this.obscureText, this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    const blue1 = Color(0XFF009BFF);
    const blue2 = Color(0XFF9DDEFF);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black38, blurRadius: 5.0, offset: Offset(0, 1))
          ]),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(color: blue1),
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(color: blue2),
          hintText: hintText,
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: blue1, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
      ),
    );
  }
}

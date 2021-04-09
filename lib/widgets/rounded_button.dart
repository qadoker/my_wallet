import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  RoundedButton({ @required this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          boxShadow: [
            BoxShadow(color: Colors.black38,
                blurRadius: 5.0,
                offset: Offset(0, 5.0)
            )
          ]
      ),
      child: MaterialButton(
        minWidth: double.infinity,
        splashColor: Color(0XFF9DDEFF),
        color: Color(0XFF009BFF),
        shape: StadiumBorder(),
        onPressed: onPressed,
        child: Text(
          text, style: TextStyle(color: Colors.white, fontFamily: 'Pacifico', fontSize: 21.0),
        ),
      ),
    );
  }
}
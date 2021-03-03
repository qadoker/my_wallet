import 'package:flutter/material.dart';

class TextCard extends StatelessWidget {
  final String text;
  final String amountText;
  TextCard({this.text, this.amountText});


  @override
  Widget build(BuildContext context) {
    double screenWidth;
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;

    return Column(
      children: [
        Text(text, style: TextStyle(color: Colors.black38, fontSize: screenWidth*0.06),),
        Text(amountText, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: screenWidth*0.06))
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }
}

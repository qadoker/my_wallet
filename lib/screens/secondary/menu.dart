import 'package:flutter/material.dart';
import 'package:my_wallet/screens/secondary/main&menu.dart';
import 'package:my_wallet/widgets/secondary/menu_option.dart';

class MenuScreen extends StatefulWidget {
  static const String id = 'menu_screen';

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  double screenWidth, screenHeight;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        padding: EdgeInsets.only(left: 15.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Color(0XFF9DDEFF),
              Color(0XFF009BFF),
            ]
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MenuOption(
              icon: Icons.home,
              screenName: "Əsas",
              pushScreen: () {
                Navigator.pushNamed(context, Drawing.id);
              },
            ),
            MenuOption(
                icon: Icons.category,
                screenName: 'Kategoriyalar',
              pushScreen: () {
                  // Navigator.pushNamed(context, Categories.id);
              },
            )
          ],
        ),
      ),
    );
  }
}


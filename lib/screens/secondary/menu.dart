import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_wallet/screens/secondary/main&menu.dart';
import 'package:my_wallet/screens/secondary/profile.dart';
import 'package:my_wallet/screens/secondary/settings.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenHeight*0.15, left: screenWidth*0.05),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: screenWidth*0.1,
                child: Icon(Icons.person, size: 50,),
              )
            ),
            SizedBox(height: screenHeight*0.03,),
            Text('Qadir Kerimov', style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(height: screenHeight*0.01,),
            Text('Balans: 200', style: TextStyle(color: Colors.white, fontSize: 18)),
            Divider(
              color: Colors.white.withOpacity(0.5),
              height: screenWidth*0.2,
              endIndent: screenWidth*0.45,
            ),

            MenuOption(
              icon: Icons.home,
              screenName: "Əsas",
              pushScreen: () {
                Navigator.pushNamed(context, Drawing.id);
              },
            ),
            MenuOption(
                icon: Icons.settings,
                screenName: 'Parametrlər',
              pushScreen: () {
                  Navigator.pushNamed(context, Settings.id);
              },
            ),
            MenuOption(
              icon: Icons.person_outline,
              screenName: 'Profil',
              pushScreen: () {
                Navigator.pushNamed(context, Profile.id);
              },
            )
          ],
        ),
      ),
    );
  }
}


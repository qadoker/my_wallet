import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_wallet/screens/profile.dart';
import 'package:my_wallet/screens/settings.dart';
import 'package:my_wallet/widgets/menu_option.dart';
import 'package:provider/provider.dart';
import 'package:my_wallet/firebase/firebase_providers/email_sign_in_provider.dart';

import 'drawing.dart';


class MenuScreen extends StatefulWidget {
  static const String id = 'menu_screen';

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  double screenWidth, screenHeight;
  User user = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    final emailSignInProvider = Provider.of<EmailSignInProvider>(context, listen: false);
    var appLang = AppLocalizations.of(context);
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
                child: Icon(Icons.person, size: 50,)
              )
            ),
            SizedBox(height: screenHeight*0.03,),
            SizedBox(height: screenHeight*0.01,),
            Divider(
              color: Colors.white.withOpacity(0.5),
              height: screenWidth*0.2,
              endIndent: screenWidth*0.45,
            ),

            MenuOption(
              icon: Icons.home,
              screenName: appLang.home,
              pushScreen: () {
                Navigator.pushNamed(context, Drawing.id);
              },
            ),
            MenuOption(
                icon: Icons.settings,
                screenName: appLang.settings,
              pushScreen: () {
                  Navigator.pushNamed(context, Settings.id);
              },
            ),
            MenuOption(
              icon: Icons.person_outline,
              screenName: appLang.profile,
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


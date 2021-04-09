import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_wallet/widgets/rounded_button.dart';

import '1 _login_screen.dart';


class Profile extends StatefulWidget {
  static const String id = 'profile_screen';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  double screenWidth, screenHeight;
  Color blue = Color(0XFF009BFF);
  User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var appLang = AppLocalizations.of(context);
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
        backgroundColor: blue,
        focusColor: Color(0XFF9DDEFF),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/background2.jpg'),
            // fit: BoxFit.fill
          )),
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(appLang.my_wallet,
                      style: TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: screenWidth * 0.13,
                          color: Colors.white)),
                ),
                SizedBox(height: screenHeight * 0.03),
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    elevation: 5,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.lightBlue,
                            radius: screenWidth * 0.1,
                            child: Icon(Icons.person, size: 50,)
                          ),
                          SizedBox(
                            height: screenHeight * 0.03,
                          ),
                          Text(user.email,
                              style: TextStyle(color: blue, fontSize: 18)),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          Divider(
                            color: blue.withOpacity(0.5),
                            height: screenWidth * 0.2,
                          ),
                          RoundedButton(
                            text: appLang.log_out,
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.popAndPushNamed(context, LoginScreen.id);
                            },
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          )),
    );
  }
}

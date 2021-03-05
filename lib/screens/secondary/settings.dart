import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_wallet/constants.dart';
import 'package:my_wallet/screens/primary/initial_settings.dart';
import 'package:my_wallet/screens/secondary/main&menu.dart';
import 'package:my_wallet/widgets/primary/wallet_dropdownbutton.dart';
import 'package:provider/provider.dart';
class Settings extends StatefulWidget {
  static const String id = 'settings_screen';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String currencyVal,
      defaultCur = currency[0],
      languageVal,
      defaultLan = languages[0];

  double screenWidth, screenHeight;
  Color blue = Color(0XFF009BFF);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
        backgroundColor: Color(0XFF009BFF),
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
                  child: Text('My Wallet',
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
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    child: Column(
                      children: [
                        WallletDropDownButton(
                          iconColor: blue,
                          dropdownColor: Colors.white,
                          dropdownTextColor: blue,
                          hintColor: blue,
                          textColor: blue,
                          text: 'Valyutanı seçin: ',
                          defaultVal: defaultCur,
                          listVal: currencyVal,
                          list: currency,
                          onChanged: (newValue) {
                            setState(() {
                              currencyVal = newValue;
                            });
                          },
                        ),
                        WallletDropDownButton(
                          iconColor: blue,
                          dropdownColor: Colors.white,
                          dropdownTextColor: blue,
                          hintColor: blue,
                          textColor: blue,
                          text: 'Dili seçin: ',
                          defaultVal: defaultLan,
                          listVal: languageVal,
                          list: languages,
                          onChanged: (newValue) {
                            setState(() {
                              languageVal = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ),

              ],
            ),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_wallet/app_providers/currency_provider.dart';
import 'package:my_wallet/app_providers/locale_provider.dart';
import 'package:my_wallet/widgets/wallet_dropdownbutton.dart';
import 'package:provider/provider.dart';
import 'drawing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_wallet/l10n/l10n.dart';


class Settings extends StatefulWidget {
  static const String id = 'settings_screen';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  String currencyVal,
      languageVal,
      defaultLan = L10n.languages[0];

  double screenWidth, screenHeight;
  Color blue = Color(0XFF009BFF);


  @override
  Widget build(BuildContext context) {
    var appLang = AppLocalizations.of(context);
    final currencyProvider = Provider.of<Currencies>(context, listen: false);
    String defaultCur = currencyProvider.currency ?? currencyProvider.currencies.first;
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
          if(currencyVal != null ){currencyProvider.currency = currencyVal;}
          if(languageVal ==null ?? L10n.languages[0]){
            Provider
                .of<LocaleProvider>(context, listen: false).setLocale(Locale('az'));
          }else if(languageVal == L10n.languages[1]){
            Provider
                .of<LocaleProvider>(context, listen: false).setLocale(Locale('en'));
          }
          Navigator.popAndPushNamed(context, Drawing.id);
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
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    child: Column(
                      children: [
                        WallletDropDownButton(
                          iconColor: blue,
                          dropdownColor: Colors.white,
                          dropdownTextColor: blue,
                          hintColor: blue,
                          textColor: blue,
                          text: appLang.choose_currency,
                          defaultVal: defaultCur,
                          listVal: currencyVal,
                          list:   Provider.of<Currencies>(context, listen: false).currencies,
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
                          text: appLang.choose_language,
                          defaultVal: defaultLan,
                          listVal: languageVal,
                          list: L10n.languages,
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

import 'package:flutter/material.dart';
import 'package:my_wallet/app_providers/currency_provider.dart';
import 'package:my_wallet/app_providers/locale_provider.dart';
import 'package:my_wallet/firebase/firebase_providers/categories_provider.dart';
import 'package:my_wallet/l10n/l10n.dart';
import 'package:my_wallet/widgets/wallet_dropdownbutton.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'drawing.dart';

class InitialSetScreen extends StatefulWidget {
  static const String id = 'initial_settings_screen';

  @override
  _InitialSetScreenState createState() => _InitialSetScreenState();
}

class _InitialSetScreenState extends State<InitialSetScreen> {
  String currencyVal,
      languageVal,
      defaultLan = L10n.languages[0];

  double screenWidth, screenHeight;

  @override
  Widget build(BuildContext context) {
    var appLang = AppLocalizations.of(context);
    final currencyProvider = Provider.of<Currencies>(context, listen: false);
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    String defaultCur =
        currencyProvider
            .currency;
    defaultCur = currencyProvider
        .currencies[0];

    Size size = MediaQuery
        .of(context)
        .size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.arrow_right_alt,
          color: Colors.white,
        ),
        backgroundColor: Color(0XFF009BFF),
        focusColor: Color(0XFF9DDEFF),
        onPressed: () {
          Navigator.pushNamed(context, Drawing.id);
          if(languageVal == L10n.languages[0]){
            localeProvider.setLocale(Locale('az'));
          }else if(languageVal == L10n.languages[1]){
            localeProvider.setLocale(Locale('en'));
          }
          if (currencyVal != null) {
            currencyProvider
                .currency =
                currencyVal;
          } else {
            currencyProvider
                .currency =
                defaultCur;
          }

        },
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.17),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background2.jpg'),
              )),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(appLang.my_wallet,
                    style: TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: screenWidth * 0.13,
                        color: Colors.white)),
                SizedBox(height: screenHeight * 0.03),
                Container(
                    decoration: BoxDecoration(
                        color: Color(0XFF009BFF),
                        border: Border(
                            bottom:
                            BorderSide(width: 1.0, color: Colors.white))),
                    child: WallletDropDownButton(
                      iconColor: Colors.white,
                      dropdownColor: Color(0XFF009BFF),
                      dropdownTextColor: Colors.white,
                      hintColor: Colors.white54,
                      textColor: Colors.white,
                      text: appLang.choose_currency,
                      defaultVal: defaultCur,
                      listVal: currencyVal,
                      list: Provider
                          .of<Currencies>(context)
                          .currencies,
                      onChanged: (newValue) {
                        setState(() {
                          currencyVal = newValue;
                        });
                      },
                    )),
                Flexible(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(0XFF009BFF),
                          border: Border(
                              bottom:
                              BorderSide(width: 1.0, color: Colors.white))),
                      child: WallletDropDownButton(
                        iconColor: Colors.white,
                        dropdownColor: Color(0XFF009BFF),
                        dropdownTextColor: Colors.white,
                        hintColor: Colors.white54,
                        textColor: Colors.white,
                        text: appLang.choose_language,
                        defaultVal: defaultLan,
                        listVal: languageVal,
                        list: L10n.languages,
                        onChanged: (newValue) {
                          setState(() {
                            languageVal = newValue;
                          });
                        },
                      )),
                )
              ],
            ),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_wallet/constants.dart';
import 'package:my_wallet/screens/secondary/main&menu.dart';
import 'package:my_wallet/widgets/primary/wallet_dropdownbutton.dart';



class InitialSetScreen extends StatefulWidget {
  static const String id = 'initial_settings_screen';
  @override
  _InitialSetScreenState createState() => _InitialSetScreenState();
}

class _InitialSetScreenState extends State<InitialSetScreen> {

  String currencyVal, defaultCur = currency[0], languageVal, defaultLan = languages[0];

  double screenWidth, screenHeight;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_right_alt, color: Colors.white,),
        backgroundColor: Color(0XFF009BFF),
        focusColor: Color(0XFF9DDEFF),
        onPressed: (){
          Navigator.pushNamed(context, Drawing.id);
        },
          ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth*0.17),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background2.jpg'),
            // fit: BoxFit.fill
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                    'My Wallet',
                    style: TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: screenWidth*0.13,
                        color: Colors.white
                    )
                ),
              ),
              SizedBox(height: screenHeight*0.03),

              Container(
                decoration: BoxDecoration(
                    color: Color(0XFF009BFF),
                    border: Border(bottom: BorderSide(width: 1.0, color: Colors.white))),
                child: WallletDropDownButton(
                    defaultVal: defaultCur,
                    listVal: currencyVal,
                    list: currency,
                  onChanged: (newValue){
                      setState(() {
                        currencyVal = newValue;
                      });
                  },
                )
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0XFF009BFF),
                    border: Border(bottom: BorderSide(width: 1.0, color: Colors.white))),
                child: WallletDropDownButton(
                  defaultVal:  defaultLan,
                  listVal: languageVal,
                  list: languages,
                  onChanged: (newValue){
                    setState(() {
                      languageVal = newValue;
                    });
                  },
                )

              ),
            ],
          ),
        )
      ),
    );
  }
}

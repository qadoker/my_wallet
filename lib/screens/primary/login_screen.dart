import 'package:flutter/material.dart';
import 'package:my_wallet/widgets/primary/rounded_button.dart';
import 'package:my_wallet/widgets/primary/wallet_textformfield.dart';
import 'package:my_wallet/screens/primary/signup_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double screenWidth, screenHeight;

  @override
  Widget build(BuildContext context) {
    var appLang = AppLocalizations.of(context);

    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  top: screenHeight * 0.2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(appLang.my_wallet,
                      style: TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: screenWidth * 0.13,
                          color: Color(0XFF009BFF))),
                  SizedBox(height: screenHeight * 0.03),
                  WalletTextFormField(
                    hintText: appLang.enter_email,
                    obscureText: false,
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color(0XFF009BFF),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  WalletTextFormField(
                    hintText: appLang.enter_password,
                    obscureText: true,
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: Color(0XFF009BFF),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  RoundedButton(onPressed: () {}, text: appLang.log_in),
                  SizedBox(height: screenHeight * 0.02),
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.6),
                    child: GestureDetector(
                      child: Text(appLang.forgot_password,
                          style: TextStyle(color: Color(0XFF009BFF)),
                          textAlign: TextAlign.right),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 1.0,
                          width: screenWidth * 0.3,
                          color: Colors.black38,
                        ),
                        Center(
                            child: Text(
                          appLang.or,
                          style: TextStyle(color: Colors.black38),
                        )),
                        Container(
                          height: 1.0,
                          width: screenWidth * 0.3,
                          color: Colors.black38,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: screenWidth * 0.07,
                          child: Padding(
                            padding: EdgeInsets.all(7.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  AssetImage('assets/pngs/google.png'),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.1),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage:
                              AssetImage('assets/pngs/facebook.png'),
                          radius: screenWidth * 0.07,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.2),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    appLang.do_you_have_account,
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.id);
                    },
                    child: Text(appLang.sign_up,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

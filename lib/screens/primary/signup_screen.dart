import 'package:flutter/material.dart';
import 'package:my_wallet/widgets/primary/rounded_button.dart';
import 'package:my_wallet/widgets/primary/wallet_textformfield.dart';
import 'package:my_wallet/screens/primary/initial_settings.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signup_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;

    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('My Wallet',
                    style: TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: screenWidth * 0.13,
                        color: Color(0XFF009BFF))),
                SizedBox(height: screenHeight * 0.03),
                WalletTextFormField(
                  hintText: 'Enter Your Email',
                  obscureText: false,
                  prefixIcon: Icon(
                    Icons.email,
                    color: Color(0XFF009BFF),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                WalletTextFormField(
                  hintText: 'Enter Your Username',
                  obscureText: false,
                  prefixIcon: Icon(
                    Icons.perm_identity,
                    color: Color(0XFF009BFF),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                WalletTextFormField(
                  hintText: 'Enter password',
                  obscureText: true,
                  prefixIcon: Icon(
                    Icons.vpn_key,
                    color: Color(0XFF009BFF),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                RoundedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, InitialSetScreen.id);
                    },
                    text: 'Sign Up'),
              ],
            ),
          )),
    );
  }
}

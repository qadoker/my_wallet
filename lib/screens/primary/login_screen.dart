import 'package:flutter/material.dart';
import 'package:my_wallet/widgets/primary/rounded_button.dart';
import 'package:my_wallet/widgets/primary/wallet_textformfield.dart';
import 'package:my_wallet/screens/primary/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double screenWidth, screenHeight;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.fill)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text('My Wallet',
                        style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: screenWidth * 0.13,
                            color: Color(0XFF009BFF))),
                  ),
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
                    hintText: 'Enter password',
                    obscureText: true,
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: Color(0XFF009BFF),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  RoundedButton(onPressed: () {}, text: 'Log In'),
                  SizedBox(height: screenHeight * 0.02),
                  Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.1),
                    child: GestureDetector(
                      child: Text('Forgot Password?',
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
                          'OR',
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
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Dont you have an account',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.id);
                    },
                    child: Text('Sign Up',
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

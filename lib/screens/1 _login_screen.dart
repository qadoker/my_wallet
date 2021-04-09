import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_wallet/app_providers/currency_provider.dart';
import 'package:my_wallet/app_providers/email_sign_in_provider.dart';
import 'package:my_wallet/app_providers/facebook_sign_in_provider.dart';
import 'package:my_wallet/app_providers/google_sign_in_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_wallet/widgets/rounded_button.dart';
import 'package:my_wallet/widgets/wallet_textformfield.dart';
import 'package:provider/provider.dart';

import '2_signup_screen.dart';
import '3_initial_settings.dart';
import 'drawing.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  User user = FirebaseAuth.instance.currentUser;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureShow = true;
  double screenWidth, screenHeight;

  @override
  Widget build(BuildContext context) {
    var appLang = AppLocalizations.of(context);
    var currencyProvider = Provider.of<Currencies>(context, listen: false);
    var authenticationProvider =
        Provider.of<EmailSignInProvider>(context, listen: false);

    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Stack(
      children: [
        Image.asset(
          'assets/images/background.jpg',
          fit: BoxFit.fill,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.05,
                      right: screenWidth * 0.05,
                      top: screenHeight * 0.19),
                  child: Form(
                    key: _formKey,
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
                          controller: emailController,
                          hintText: appLang.enter_email,
                          obscureText: false,
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color(0XFF009BFF),
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return appLang.enter_email;
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return appLang.enter_valid_email;
                            }
                            if (authenticationProvider.userEmail != value) {
                              return appLang.email_is_wrong;
                            }
                          },
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        WalletTextFormField(
                          hintText: appLang.enter_password,
                          obscureText: obscureShow,
                          controller: passwordController,
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Color(0XFF009BFF),
                          ),
                          suffixIcon: IconButton(
                            padding: EdgeInsets.only(right: 10),
                            icon: obscureShow
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            color: Color(0XFF009BFF).withOpacity(0.5),
                            onPressed: () {
                              setState(() {
                                obscureShow = !obscureShow;
                              });
                            },
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return appLang.enter_password;
                            }
                            if (value.length < 8) {
                              return appLang.password_symbols;
                            }
                            if (value != authenticationProvider.userPassword) {
                              return appLang.password_is_wrong;
                            }
                          },
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        RoundedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                authenticationProvider.userEmail =
                                    emailController.text;
                                authenticationProvider.userPassword =
                                    passwordController.text;
                                final isSuccess =
                                    await authenticationProvider.signIn();
                                if (isSuccess) {
                                  Navigator.pushNamed(context, Drawing.id);
                                  currencyProvider.currency =
                                      currencyProvider.currencies[0];
                                } else {
                                  final message =
                                      'An error occurred, please check your credentials!';
                                }
                              }
                            },
                            text: appLang.log_in),
                        SizedBox(height: screenHeight * 0.02),
                        SizedBox(height: screenHeight * 0.02),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05),
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
                                  child: IconButton(
                                    padding: EdgeInsets.all(6),
                                    icon: FaIcon(FontAwesomeIcons.google,
                                        size: 35, color: Colors.redAccent),
                                    onPressed: () {
                                      final googleProvider =
                                          Provider.of<GoogleSignInProvider>(
                                              context,
                                              listen: false);
                                      googleProvider.login().whenComplete(() =>
                                          Navigator.pushNamed(
                                              context, InitialSetScreen.id));
                                    },
                                  )),
                              SizedBox(width: screenWidth * 0.1),
                              CircleAvatar(
                                  backgroundColor: Colors.blue[900],
                                  radius: screenWidth * 0.07,
                                  child: IconButton(
                                    padding: EdgeInsets.all(6),
                                    icon: FaIcon(FontAwesomeIcons.facebookF,
                                        size: 35, color: Colors.white),
                                    onPressed: () {
                                      final facebookProvider =
                                          Provider.of<FacebookSignInProvider>(
                                              context,
                                              listen: false);
                                      facebookProvider.login().whenComplete(
                                          () => Navigator.pushNamed(
                                              context, InitialSetScreen.id));
                                    },
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
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
        ),
      ],
    );
  }
}

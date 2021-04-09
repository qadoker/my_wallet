import 'package:flutter/material.dart';
import 'package:my_wallet/app_providers/email_sign_in_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_wallet/widgets/rounded_button.dart';
import 'package:my_wallet/widgets/wallet_textformfield.dart';
import 'package:provider/provider.dart';

import '3_initial_settings.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signup_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  bool passwordIsObscure = true;
  bool confirmPassIsObscure = true;
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    var appLang = AppLocalizations.of(context);
    var authenticationProvider =
        Provider.of<EmailSignInProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;

    return Stack(children: [
      Image.asset(
        'assets/images/background.jpg',
        fit: BoxFit.cover,
      ),
      Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                top: screenHeight * 0.2),
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
                    hintText: appLang.enter_username,
                    obscureText: false,
                    controller: userNameController,
                    prefixIcon: Icon(
                      Icons.perm_identity,
                      color: Color(0XFF009BFF),
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return appLang.enter_username;
                      }
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  WalletTextFormField(
                    hintText: appLang.enter_email,
                    obscureText: false,
                    controller: emailController,
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color(0XFF009BFF),
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return appLang.enter_email;
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return appLang.enter_valid_email;
                      }
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  WalletTextFormField(
                    controller: passwordController,
                    hintText: appLang.enter_password,
                    obscureText: passwordIsObscure,
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: Color(0XFF009BFF),
                    ),
                    suffixIcon: IconButton(
                      icon: passwordIsObscure
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      color: Color(0XFF009BFF).withOpacity(0.5),
                      onPressed: () {
                        setState(() {
                          passwordIsObscure = !passwordIsObscure;
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
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  WalletTextFormField(
                    controller: confirmPassController,
                    hintText: appLang.confirm_password,
                    obscureText: confirmPassIsObscure,
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: Color(0XFF009BFF),
                    ),
                    suffixIcon: IconButton(
                      icon: confirmPassIsObscure
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      color: Color(0XFF009BFF).withOpacity(0.5),
                      onPressed: () {
                        setState(() {
                          confirmPassIsObscure = !confirmPassIsObscure;
                        });
                      },
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return appLang.confirm_password;
                      }
                      if (passwordController.text !=
                          confirmPassController.text) {
                        return appLang.not_correct;
                      }
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  RoundedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          authenticationProvider.userName =
                              userNameController.text;
                          authenticationProvider.userEmail =
                              emailController.text;
                          authenticationProvider.userPassword =
                              passwordController.text;
                          final isSuccess =
                              await authenticationProvider.signUp();
                          if (isSuccess) {
                            Navigator.pushNamed(context, InitialSetScreen.id);
                          } else {
                            final message =
                                'An error occurred, please check your credentials!';
                          }
                        }
                      },
                      text: appLang.sign_up),
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:my_wallet/database/wallet_database.dart';
import 'package:my_wallet/screens/secondary/profile.dart';
import 'package:my_wallet/screens/secondary/settings.dart';
import 'package:my_wallet/widgets/secondary/operation_tile.dart';
import 'package:my_wallet/widgets/secondary/operation_view.dart';
import 'package:provider/provider.dart';
import 'package:my_wallet/screens/primary/initial_settings.dart';
import 'package:my_wallet/screens/primary/login_screen.dart';
import 'package:my_wallet/screens/primary/signup_screen.dart';
import 'package:my_wallet/screens/secondary/main&menu.dart';
import 'package:my_wallet/screens/secondary/menu.dart';

void main() => runApp(Provider<WalletDatabase>(
      create: (context) => WalletDatabase(),
      child: MyWallet(),
      dispose: (context, db) => db.close(),
    ));

class MyWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
            textSelectionColor: Color(0XFF009BFF).withOpacity(0.2),
            textSelectionHandleColor: Color(0XFF009BFF),
            scaffoldBackgroundColor: Colors.transparent,
            primaryColor: Color(0XFF009BFF)),
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          InitialSetScreen.id: (context) => InitialSetScreen(),
          Drawing.id: (context) => Drawing(),
          MainScreen.id: (context) => MainScreen(),
          MenuScreen.id: (context) => MenuScreen(),
          Settings.id: (context) => Settings(),
          Profile.id: (context) => Profile()
        });
  }
}

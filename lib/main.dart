import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_wallet/database/wallet_database.dart';
import 'package:my_wallet/l10n/l10n.dart';
import 'package:my_wallet/providers/currency_provider.dart';
import 'package:my_wallet/providers/locale_provider.dart';
import 'package:my_wallet/screens/secondary/profile.dart';
import 'package:my_wallet/screens/secondary/settings.dart';
import 'package:provider/provider.dart';
import 'package:my_wallet/screens/primary/initial_settings.dart';
import 'package:my_wallet/screens/primary/login_screen.dart';
import 'package:my_wallet/screens/primary/signup_screen.dart';
import 'package:my_wallet/screens/secondary/drawing.dart';
import 'package:my_wallet/screens/secondary/menu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MyWallet());
}

class MyWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<WalletDatabase>(
          create: (context) => WalletDatabase(),
          dispose: (context, db) => db.close(),
        ),
        ChangeNotifierProvider(create: (context) => Currencies()),
      ],
      child: ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child){
          final provider = Provider.of<LocaleProvider>(context);
          return MaterialApp(
              locale: provider.locale,
              supportedLocales: L10n.all,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              theme: ThemeData.dark().copyWith(
                  textSelectionTheme: TextSelectionThemeData(
                    selectionColor: Color(0XFF009BFF).withOpacity(0.2),
                    selectionHandleColor: Color(0XFF009BFF),
                  ),
                  scaffoldBackgroundColor: Colors.transparent,
                  primaryColor: Color(0XFF009BFF)),
              debugShowCheckedModeBanner: false,
              initialRoute: LoginScreen.id,
              routes: {
                LoginScreen.id: (context) => LoginScreen(),
                SignUpScreen.id: (context) => SignUpScreen(),
                InitialSetScreen.id: (context) => InitialSetScreen(),
                Drawing.id: (context) => Drawing(),
                HomeScreen.id: (context) => HomeScreen(),
                MenuScreen.id: (context) => MenuScreen(),
                Settings.id: (context) => Settings(),
                Profile.id: (context) => Profile()
              });
        },
      ),
    );
  }
}

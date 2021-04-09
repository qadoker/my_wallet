import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_wallet/firebase/firebase_providers/categories_provider.dart';
import 'package:my_wallet/firebase/firebase_providers/operations_provider.dart';
import 'package:my_wallet/l10n/l10n.dart';
import 'file:///D:/My%20lessons/Development/Flutter%20with%20Dart/proyektlerim/my_wallet/lib/screens/profile.dart';
import 'file:///D:/My%20lessons/Development/Flutter%20with%20Dart/proyektlerim/my_wallet/lib/screens/settings.dart';
import 'package:provider/provider.dart';
import 'file:///D:/My%20lessons/Development/Flutter%20with%20Dart/proyektlerim/my_wallet/lib/screens/3_initial_settings.dart';
import 'file:///D:/My%20lessons/Development/Flutter%20with%20Dart/proyektlerim/my_wallet/lib/screens/1%20_login_screen.dart';
import 'file:///D:/My%20lessons/Development/Flutter%20with%20Dart/proyektlerim/my_wallet/lib/screens/2_signup_screen.dart';
import 'file:///D:/My%20lessons/Development/Flutter%20with%20Dart/proyektlerim/my_wallet/lib/screens/drawing.dart';
import 'file:///D:/My%20lessons/Development/Flutter%20with%20Dart/proyektlerim/my_wallet/lib/screens/menu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app_providers/currency_provider.dart';
import 'app_providers/email_sign_in_provider.dart';
import 'app_providers/facebook_sign_in_provider.dart';
import 'app_providers/google_sign_in_provider.dart';
import 'app_providers/locale_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyWallet());
}

class MyWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OperationProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => Currencies()),
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (context) => FacebookSignInProvider()),
        ChangeNotifierProvider(create: (context) => EmailSignInProvider()),


      ],
      child: ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
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

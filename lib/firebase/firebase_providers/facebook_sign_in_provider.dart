import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FacebookSignInProvider extends ChangeNotifier{
  FacebookLogin facebookLogIn = FacebookLogin();
  bool _isLogingIn;

  FacebookSignInProvider(){
    _isLogingIn = false;
  }

  bool get isLogingIn => _isLogingIn;

  set isLogingIn(bool isLogingIn){
    _isLogingIn = isLogingIn;
    notifyListeners();
  }

  Future login() async {
    isLogingIn = true;

    final result = await facebookLogIn.logIn(['email']);

    if(result == null){
      isLogingIn = false;
      return;
    } else{
      final token = result.accessToken.token;
      
      final credential = FacebookAuthProvider.credential(token);

      await FirebaseAuth.instance.signInWithCredential(credential);
      isLogingIn = false;
    }
  }

  void logout() async {
    await facebookLogIn.logOut();
    FirebaseAuth.instance.signOut();
  }

}
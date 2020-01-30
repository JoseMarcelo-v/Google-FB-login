import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginState with ChangeNotifier {

//INSTANCIAS DE LOGIN, GOOGLE,FACEBOOK Y SHARED PREFERENCES
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;
SharedPreferences _prefs;

//INSTANCIAS DE LOGIN, GOOGLE,FACEBOOK Y SHARED PREFERENCES

bool _loggedIn = false;
bool _loading = true;
bool _inEvent = false;
FirebaseUser _user;
bool _categorySelected = false;
String _cartaSel = "todos";

LoginState() {
    loginState();
}

bool isInEvent() => _inEvent;
bool isLoggedIn() => _loggedIn;
bool isLoading() => _loading;
String cartaSel() => _cartaSel;
FirebaseUser isUser() => _user;
bool categorySelected() => _categorySelected;

//changeCarta
void updateCarta(String carta){
  _cartaSel = carta;
  _categorySelected = true;
  notifyListeners();
}

void listenCartState(){
  _categorySelected = true;
  notifyListeners();
}
//changeCarta

//Enter OnEvent--------------------
void enterOnEvent(){
  _inEvent = true;
  notifyListeners();
}
//Enter OnEvent--------------------

//Exit OnEvent--------------------
void exitOfEvent(){
  _inEvent = false;
  notifyListeners();
}
//Exit OnEvent--------------------

//LOGIN------------------------
 void login(String tipo) async {
   _loading = true;
   notifyListeners();
 
   if(tipo == "FACEBOOK"){
      _user = await _handleFacebookSignIn();
   }else if(tipo == "GOOGLE"){
     _user = await _handleGoogleSignIn();
   }
 
   _loading = false;
   if (_user != null) {
     _prefs.setBool('isLoggedIn', true);
     _loggedIn = true;
     notifyListeners();
   } else {
     _loggedIn = false;
     notifyListeners();
   }
 }
//LOGIN------------------------

//LOGOUT------------------------
 void logout(){
    _prefs.clear();
    _googleSignIn.signOut();
    _loggedIn = false;
    notifyListeners();
 }
//LOGOUT------------------------

//LOGIN STATE------------------------
 void loginState() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey('isLoggedIn')) {
      _user = await _auth.currentUser();
      _loggedIn = _user != null;
      _loading = false;
      notifyListeners();
    } else {
      _loading = false;
      notifyListeners();
    }
  }
//LOGIN STATE------------------------


//INICIAR SESION CON GOOGLE------------------------
 Future<FirebaseUser> _handleGoogleSignIn() async {
 final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
 if (googleUser == null) {
   return null;
 }
 final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
 
 final AuthCredential credential = GoogleAuthProvider.getCredential(
   accessToken: googleAuth.accessToken,
   idToken: googleAuth.idToken,
 );
 
 final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
 print("Usuario "+user.displayName);
 return user;
 }
 //INICIAR SESION CON GOOGLE------------------------

  //INICIAR SESION CON FACEBOOK------------------------
  Future<FirebaseUser> _handleFacebookSignIn() async {
   
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);
    if(result.status != FacebookLoginStatus.loggedIn){
      return null;
    }
    
    final AuthCredential credential = FacebookAuthProvider.getCredential(
      accessToken: result.accessToken.token,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    print("Usuario "+user.displayName);
    return user;
  }
  //INICIAR SESION CON FACEBOOK------------------------

}//class
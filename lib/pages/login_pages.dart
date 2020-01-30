import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../login_state.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Iniciar Sesion"),
        centerTitle: true,
      ),
       body: Center(
         child: Container(
           width: 200,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                 FloatingActionButton(
                        backgroundColor: Color(0xff4285F4),
                        child: Icon(FontAwesomeIcons.google),
                        onPressed: () {
                          Provider.of<LoginState>(context, listen: false).login("GOOGLE");
                        },
                 ),
                 FloatingActionButton(
                        backgroundColor: Color(0xff3b5998),
                        child: Icon(FontAwesomeIcons.facebook),
                        onPressed: () {
                          Provider.of<LoginState>(context, listen: false).login("FACEBOOK");
                        },
                 ),
               ],
             ),
         ),
       ),
    );
  }//build
}//class
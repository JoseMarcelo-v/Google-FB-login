import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vendeme/pages/movimientos.pages.dart';
import 'package:vendeme/pages/perfil.pages.dart';
import 'package:vendeme/theme.dart';
import '../login_state.dart';
import 'package:flare_flutter/flare_actor.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectDrawerItem = 0;
  bool _isDark;

  @override
  Widget build(BuildContext context) {
    //set theme
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    if(_themeChanger.getTheme().brightness == Brightness.dark){
      _isDark = true;
    }else{
      _isDark = false;
    }
    //set theme
    //get user info
    var userinfo = Provider.of<LoginState>(context).isUser();
    //get user info
    //get event state
    var eventState = Provider.of<LoginState>(context).isInEvent();
    //get event state
    //size of screen
    double _screenSize = MediaQuery.of(context).size.width;
    //size of screen
    String _animationName = _isDark ? "switch_night" : "switch_day";

    return  Scaffold(
      appBar:AppBar(
        //title: (eventState ? Text("Carta") : Text("Eventos")),
        //centerTitle: false,
        backgroundColor: (_isDark ? Colors.transparent : Theme.of(context).primaryColor ),
        elevation: 0.0,
      ),
      drawer: SizedBox(
        width: _screenSize * 0.70,
        child: Drawer(
         child: Column(
           children: <Widget>[
             Expanded(
               child: ListView(
                 children: <Widget>[
                  UserAccountsDrawerHeader(
                     accountName: Text(userinfo.displayName),
                     accountEmail: Text(userinfo.email),
                     currentAccountPicture: CircleAvatar(
                       backgroundImage: NetworkImage(userinfo.photoUrl),
                     ),
                   ),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.glassCheers),
                    title: (eventState ? Text("Evento Actual") : Text("Eventos")),
                    selected: (0 == _selectDrawerItem),
                    onTap: (){
                      setState(() {
                        Navigator.of(context).pop();
                        _selectDrawerItem = 0;
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.creditCard),
                    title: Text('Movimientos'),
                    selected: (1 == _selectDrawerItem),
                    onTap: (){
                      setState(() {
                        Navigator.of(context).pop();
                        _selectDrawerItem = 1;
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.addressCard),
                    title: Text('Perfil'),
                    selected: (2 == _selectDrawerItem),
                    onTap: (){
                      setState(() {
                        Navigator.of(context).pop();
                        _selectDrawerItem = 2;
                      });
                    },
                  ),
                 ],
               ),
             ),
             Container(
                 child: Align(
                     alignment: FractionalOffset.bottomCenter,
                     child: Container(
                         child: Column(
                       children: <Widget>[
                         Divider(),
                         ListTile(
                             leading: Icon(Icons.settings),
                             title: Text('Settings')),
                         ListTile(
                           leading: Container(
                             width: 50,
                             height: 50,
                             child: FlareActor(
                               "assets/switch_daytime.flr",
                               animation: _animationName,
                               isPaused: false,
                             ),
                           ),
                           title: (_isDark ? Text("Modo Oscuro") : Text("Modo Claro")),
                           onTap: (){
                             if(_isDark){
                              setState(() {
                                _animationName = "switch_day";
                              });
                              _themeChanger.setTheme(ThemeData.light());
                             }else{
                              setState(() {
                                _animationName = "switch_night";
                              });
                              _themeChanger.setTheme(ThemeData.dark());
                             }
                           },
                         ),
                         ListTile(
                           leading: Icon(FontAwesomeIcons.signOutAlt),
                           title: Text('Logout'),
                           onTap: (){
                             Navigator.pop(context);
                             Provider.of<LoginState>(context, listen: false).logout();
                           },
                         ),
                       ],
                     )
                   )
                 )
               )
           ],
         ),
       )
      ),
      body: _getDrawerItem(_selectDrawerItem),
    );
  }//build



 _getDrawerItem(int pos){
  switch(pos){
    case 1: return MovementsPage();
    case 2: return ProfilePage();
  }
 }//end


}//class




import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendeme/app_state.dart';
import 'package:vendeme/theme.dart';
import 'login_state.dart';
import 'pages/home_pages.dart';
import 'pages/login_pages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (BuildContext context) => ThemeChanger(ThemeData.dark()),
      child: MaterialAppWithTheme()
    );
  } 
}



class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //listen theme
    final theme = Provider.of<ThemeChanger>(context);
    //listen theme
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(create: (context)=> AppState()),
        ChangeNotifierProvider<LoginState>(create: (context)=> LoginState()),
      ],
      child: MaterialApp(
          theme: theme.getTheme(),
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            routes: {
              '/': (BuildContext context) {
                var state = Provider.of<LoginState>(context);
                if (state.isLoggedIn()) {
                  return HomePage();
                } else {
                  return LoginPage();
                }
              },
              //rutas
             '/home' :(BuildContext context) =>  HomePage(),
             '/login' :(BuildContext context) =>  LoginPage(),
              //rutas
            },
          ),
     );
  }
}


      //ChangeNotifierProvider<LoginState>(
      //create: (BuildContext context) => LoginState(),

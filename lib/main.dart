import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:test_app/login/LoginScreen.dart';

void main() => runApp(MainScreen());


class MainScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    //Set color status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.blue[900],
    ));
    
    // To set orientation always portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    /*
    * Default Open Login Screen
    * */
    return MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          primaryColorLight: Colors.white,
          primaryColorBrightness: Brightness.light,
          primaryColor: Colors.blue[700]),
    );
  }
}
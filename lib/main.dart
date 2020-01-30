import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/screens/feed_screen.dart';
import 'screens/signup_screen.dart';

import 'screens/login_screen.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {


  Widget _getScreenId(){
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          return FeedScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      debugShowCheckedModeBanner: false,
      home: _getScreenId(),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        FeedScreen.id: (context) => FeedScreen()
      },
    );
  }
}
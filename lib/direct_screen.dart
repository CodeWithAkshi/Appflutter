import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:infotrack/firestore_screen.dart';
import 'profile_screen.dart';
import 'login_screen.dart';
import 'dart:async';



class DirectScreen {

  void isLogin(BuildContext context){

    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user!= null){
      Timer(const Duration(seconds: 3),
      ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen())));
    

    

     
    }else{
      Timer(const Duration(seconds: 3),
    
      () => Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginScreen()),));
    }
  }
}
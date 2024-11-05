import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infotrack/profile_screen.dart';
import 'direct_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    final directScreen = DirectScreen();
    
    Timer( const Duration(seconds: 2),(){
      directScreen.isLogin(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[400],
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/game.jpg'),
          ),
          SizedBox(height: 20), 
      
      Text('Welcome',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
        ],
      ),
      ),
    );
  }
}


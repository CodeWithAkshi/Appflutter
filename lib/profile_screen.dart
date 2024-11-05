import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[400],
      appBar: AppBar(
        title: Text('Profile'),
        actions:[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: IconButton(onPressed: (){
              auth.signOut().then((value){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
            
              }).onError((error, StackTrace){
                Utils().toastMessage(error.toString());
              });
            
            }, icon:Icon(Icons.logout),
            ),
          ),
          SizedBox(width:10)
        ]
      ) ,
      
    );
}}

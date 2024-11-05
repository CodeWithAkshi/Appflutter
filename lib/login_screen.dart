import 'package:flutter/material.dart';
import 'login_button.dart';
import 'signup_screen.dart';
import 'phone_login_screen.dart';
 import 'package:firebase_auth/firebase_auth.dart';
 import 'utils.dart';
 import 'studentprofilepage.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController  = TextEditingController();
  final _auth = FirebaseAuth.instance ;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

void login(){
  
  _auth.signInWithEmailAndPassword(email: emailController.text, password:passwordController.text.toString()).then((value){
    Utils().toastMessage(value.user!.email.toString());
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => StudentProfilePage()));
    

  }).onError((error, stackTrace){
    Utils().toastMessage(error.toString());
  });
  
  
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      automaticallyImplyLeading: false,
      title: Text(' Login', style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
      centerTitle: true,
    ),
    backgroundColor: Colors.lightGreen[100],
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Login to your account',
          style:TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color:Colors.black),
          textAlign: TextAlign.center,
          ),
          SizedBox(height: 20,),
          Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
            controller: emailController,
            decoration:  const InputDecoration(
              hintText: 'Email',
              prefixIcon: Icon(Icons.email),
            
            ),
            validator: (value) {
              if(value!.isEmpty){
                return 'Enter email';
              }
              return null;

            },
          ),
           SizedBox(height: 10,),
           TextFormField(
            keyboardType: TextInputType.text,
            controller: passwordController,
            obscureText: true,
            decoration:  const InputDecoration(
              hintText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
            validator: (value) {
              if(value!.isEmpty){
                return 'Enter password';
              }
              return null;

            },
           )
            ],)),
            SizedBox(height: 50),
          
        LoginButton(
          title: 'Login',
          onTap: (){
            if(_formKey.currentState!.validate()){
              login();

            }
          },
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("Don't have an account?"),
          TextButton(onPressed: (){
            Navigator.push(context,
            MaterialPageRoute(builder:(context) => SignupScreen()),);
          },
          child: Text('Sign up'),)
        ],),
        const SizedBox(height:20),
        ElevatedButton(
        onPressed: () {
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => PhoneLoginScreen()),);

        },
        child:Text('Login with Phone'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
          textStyle: TextStyle(fontSize:18),
                  ),)
      ],),
    )
    );

  }
}

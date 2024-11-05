import 'package:flutter/material.dart';
import 'login_button.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignupScreen> {

final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController  = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  String? errorMessage;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      
      title: Text(' Sign up', style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
      centerTitle: true,
    ),
    backgroundColor: Colors.lightGreen[100],
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Signup to your account',
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
            SizedBox(height: 30),
            if (errorMessage != null) // Display error message if it exists
              Text(
                errorMessage!,
                style: TextStyle(color: Colors.red),
              ),

          
        LoginButton(
          title: 'Signup',
          onTap: () async {
            if(_formKey.currentState!.validate()){
              
              
               await auth.createUserWithEmailAndPassword(
                email: emailController.text.toString(),
                password: passwordController.text.toString()).then((value){

                }).onError((error, stackTrace){
                  Utils().toastMessage(error.toString());

                });

                

            }
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text('Already have a account!'),
          TextButton(onPressed: (){
            Navigator.push(context,
            MaterialPageRoute(builder:(context) => LoginScreen()),
            );
          },

          child: Text('Login'),

        ),
          
        ],
      ),],
    ),
    ),
    );

  }
}

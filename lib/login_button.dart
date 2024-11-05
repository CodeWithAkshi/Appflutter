import 'package:flutter/material.dart';



class LoginButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const LoginButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center( child:Text(title, style: TextStyle(color:Colors.white))),
      ),
    );
  }
}
import 'package:eval_ingreso/views/auth/login.dart';
import 'package:eval_ingreso/views/auth/register.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool showSingIn = true;
  void toggleView(){
    setState(() => showSingIn = !showSingIn);
  }
  @override
  Widget build(BuildContext context) {
    if (showSingIn == true){
      return SingIn(toggleView: toggleView);
    }else{
      return Register(toggleView: toggleView);
    }
  }
}
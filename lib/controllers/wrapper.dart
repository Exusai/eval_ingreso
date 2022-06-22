import 'package:eval_ingreso/views/auth/auth.dart';
import 'package:eval_ingreso/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return home or auth

    final user = Provider.of<Usuario?>(context); // provedor de usuario
    if (user == null) {
      return const Auth();
    } else {
      return const HomePage();
    }
  }
}

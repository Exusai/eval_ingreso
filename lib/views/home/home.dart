import 'package:eval_ingreso/controllers/database.dart';
import 'package:eval_ingreso/views/home/edit_user_info.dart';
import 'package:eval_ingreso/views/home/pokemonList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth.dart';
import '../../controllers/database.dart';
import '../../models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usuario?>(context); // provedor de usuario
    //final userData = Provider.of<UserData?>(context); // provedor de usuario
    final db = DatabaseService(uid: user!.uid);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("PokeAPI Test"),
        actions: [
          TextButton.icon(
            onPressed: (){
              _auth.singOut();
            }, 
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ), 
            label: const Text('Cerrar sesión', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _userInfoPannel(user, db),
            const SizedBox(height: 20),

            const PokemonGrid(),
          ],
        ),
      ),
    );
  }

  Widget _userInfoPannel(Usuario user, DatabaseService? db){
    if (user.isAnon){
      return const Text('Usted ha ingresado como anonimo');
    } else {
      return FutureBuilder<UserData>(
        future: db?.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasData){
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Bienvenido ${snapshot.data!.nombre} ${snapshot.data!.apellidoPaterno} ${snapshot.data!.apellidoMaterno}'),
                    Text('Correo: ${snapshot.data!.correo}'),
                    Text('Fecha de nacimiento: ${snapshot.data!.fechaNacimiento.year.toString()}-${snapshot.data!.fechaNacimiento.month.toString()}'),
                    Text('Género: ${snapshot.data!.gender}'),
                  ],
                ),
                ElevatedButton(
                  onPressed: (){
                    // push to edit info
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditInfo(),
                      ),
                    );
                  }, 
                  child: Column(
                    children: const [
                      Icon(Icons.settings),
                      Text('Editar info'),
                    ],
                  )
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
    }
  }
}
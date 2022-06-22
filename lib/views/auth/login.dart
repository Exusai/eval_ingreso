import 'package:flutter/material.dart';
import '../../controllers/auth.dart';
import '../loading.dart';
import 'auth.dart';

class SingIn extends StatefulWidget {
  final Function toggleView;
  SingIn({required this.toggleView});
  @override
  _SingInState createState() => _SingInState();
}
 
class _SingInState extends State<SingIn> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  String uID = '';
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
    //return Scaffold(
      //backgroundColor: Color(0xffF2F2F2),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 20.0, right: 20.0,top: 20.0),
          children: <Widget>[
            //Logo
            //Image.asset('assets/logo/logo.png', height: 150),
            const Center(child: Text('Esto es un logo')),
            //Text('Bienvenido'),
            //Divider(),

            Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10,),
                  TextFormField(
                    validator: (val) => val!.isEmpty ? 'Ingresar un correo' : null,
                    onChanged: (val){
                      setState(() => email = val);
                    },
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    initialValue: '',
                    decoration: const InputDecoration(
                      hintText: 'Correo',
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                      ),
                  ),
                const SizedBox(height: 15,),
                TextFormField(
                  validator: (val) => val!.length < 6 ? 'Ingresar contraseña de 6 o más carácteres' : null,
                    onChanged: (val){
                      setState(() => password = val);
                    },
                    obscureText: true,
                    autofocus: false,
                    initialValue: '',
                    decoration: const InputDecoration(
                      hintText: 'Contraseña',
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                      ),
                  ),
                const SizedBox(height: 10,),
                ],
              ),
            ),
            ElevatedButton(
              //elevation: 6,
              child: const Text('Entrar',),
              //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),),
              //color: Theme.of(context).accentColor,
              onPressed: () async{
                if (_formkey.currentState!.validate()){
                  setState(() => loading = true);
                  dynamic result = await _auth.singInWithEmailAndPassword(email, password);
                  if (result == null){
                    setState(() => loading = false);
                    setState(() => error = 'Ha ocurrido un error o el usuario/contraseña es incorrecto');
                  }
                  //LogedUser().uID = result.uid;
                }        
              },
            ),

            ElevatedButton(
              child: const Text('Registrarse',),
              onPressed: (){
                widget.toggleView();
              }
            ),
            const Divider(),

            TextButton(
              child: const Text('Entrar sin cuenta',),
              //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),),
              //onPressed: () {},
              onPressed: () async{
                setState(() => loading = true);
                dynamic result = await _auth.singInAnon(); 
                if (result == null){
                  //setState(() => loading = false);
                  print('error singing in');
                  setState(() { error = 'Error desconocido';});
                } else  {
                  print('singed');
                  print(result.uid);
                  //LogedUser().uID = result.uid;
                }
              },
            ),

            const SizedBox(height: 10,),
            Text(
              error,
              style: const TextStyle(color: Colors.red, fontSize: 14.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
} 
import 'package:flutter/material.dart';
import '../../controllers/auth.dart';
import '../../controllers/database.dart';
import '../loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String nombre = '';
  String apellidoPaterno =  '';
  String apellidoMaterno =  '';
  String email = '';
  DateTime fechaNacimiento = DateTime.parse("2000-01-01");
  String gender = 'Masculino';
  String password = '';
  String password2 = '';
  String error = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse("2000-01-01"),
      firstDate: DateTime.parse("1950-12-01"),
      lastDate: DateTime.now());
    if (picked != null && picked != fechaNacimiento) {
      setState(() {
        fechaNacimiento = picked;
      });
    }
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {

    return loading
        ? const Loading()
        : Scaffold(
            //backgroundColor: Color(0xffF2F2F2),
            appBar: AppBar(
              title: const Text('Registro'),
              centerTitle: false,
              //backgroundColor: Color(0xff8C035C),
              actions: <Widget>[
                TextButton.icon(
                  icon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: const Text('Entrar con mi cuenta', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ],
            ),
            body: ListView(
              //shrinkWrap: true,
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              children: <Widget>[
                //Image.asset('assets/avatar/avatar.png',height: 150,width: 150,)
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (val) => val!.isEmpty ? 'Ingresar un nombre' : null,
                        onChanged: (val) {
                          setState(() => nombre = val);
                        },
                        //keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        initialValue: '',
                        decoration: const InputDecoration(
                          hintText: 'Nombre o nombres',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      TextFormField(
                        validator: (val) => val!.isEmpty ? 'Ingresar apellido paterno' : null,
                        onChanged: (val) {
                          setState(() => apellidoPaterno = val);
                        },
                        //keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        initialValue: '',
                        decoration: const InputDecoration(
                          hintText: 'Apellido paterno',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      TextFormField(
                        validator: (val) =>
                            val!.isEmpty ? 'Ingresar apellido materno' : null,
                        onChanged: (val) {
                          setState(() => apellidoMaterno = val);
                        },
                        //keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        initialValue: '',
                        decoration: const InputDecoration(
                          hintText: 'Apellido materno',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      
                      TextFormField(
                        validator: (val) =>
                            val!.isEmpty ? 'Ingresar un correo' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        initialValue: '',
                        decoration: const InputDecoration(
                          hintText: 'Correo',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      //Container(child: const Text('Género')),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.secondary, style: BorderStyle.solid, width: 0.80),
                          ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: gender,
                            iconEnabledColor: Theme.of(context).colorScheme.secondary,
                            isDense: true,
                            items: const [
                              DropdownMenuItem(value: 'Masculino', child: Text('Masculino')),
                              DropdownMenuItem(value: 'Femenino', child: Text('Femenino'),),
                            ],
                            isExpanded: true,
                            onChanged: (String? value) {
                              setState(() {
                                gender = value!;
                                //print(dropdownValue);
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),

                      Row(
                        children: [
                          const Text('Fecha de nacimiento:'),
                          const Spacer(),
                          Text('${fechaNacimiento.toLocal()}'.split(' ')[0], style: TextStyle(color: Theme.of(context).colorScheme.secondary,),)
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: ElevatedButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: const Text('Seleccionar fecha', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 10,),

                      TextFormField(
                        validator: (val) => val!.length < 6
                            ? 'Ingresar contraseña de 6 o más carácteres'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                        obscureText: true,
                        autofocus: false,
                        initialValue: '',
                        decoration: const InputDecoration(
                          hintText: 'Contraseña',
                        ),
                      ),
                      TextFormField(
                        validator: (val) => val != password
                            ? 'Contreseñas no coinciden'
                            : null,
                        onChanged: (val) {
                          setState(() => password2 = val);
                        },
                        obscureText: true,
                        autofocus: false,
                        initialValue: '',
                        decoration: const InputDecoration(
                          hintText: 'Confirmar contraseña',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),

                ElevatedButton(
                  child: const Text('Registrar'),
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),),
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if (result == null) {
                        setState(() => loading = false);
                        setState(() => error = 'Ingrese un correo electronico válido');
                      }
                      await DatabaseService(uid: result.uid).updateUserData(
                          nombre,
                          apellidoPaterno,
                          apellidoMaterno,
                          email,
                          '${fechaNacimiento.year}-${fechaNacimiento.month}-${fechaNacimiento.day}',
                          gender
                          );
                      setState(() => loading = false);
                    } else {
                      setState(() => error = 'Formato invalido');
                    }
                  },
                ),

                TextButton(
                  child: const Text('Entrar sin cuenta',
                      style: TextStyle(color: Colors.black)),
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),),
                  onPressed: () async {
                    setState(() => loading = true);
                    dynamic result = await _auth.singInAnon();
                    if (result == null) {
                      setState(() => loading = false);
                      print('error singing in');
                    } else {
                      print('singed');
                      print(result.uid);
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 14.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
  }
}

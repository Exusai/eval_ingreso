import 'package:eval_ingreso/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/database.dart';

class EditInfo extends StatefulWidget {
  const EditInfo({Key? key}) : super(key: key);

  @override
  State<EditInfo> createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {

  String nombre = '';
  String apellidoPaterno =  '';
  String apellidoMaterno =  '';
  String email = '';
  DateTime fechaNacimiento = DateTime.parse("2000-01-01");
  String gender = 'Masculino';

  bool selectedNewDate = false; 

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse("2000-01-01"),
      firstDate: DateTime.parse("1950-12-01"),
      lastDate: DateTime.now());
    if (picked != null && picked != fechaNacimiento) {
      setState(() {
        fechaNacimiento = picked;
        selectedNewDate = true;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usuario?>(context); // provedor de usuario
    final db = DatabaseService(uid: user!.uid);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Editar información'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<UserData>(
          future: db.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              UserData userData = snapshot.data!;
              
              return SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) => val!.isEmpty ? 'Ingresar un nombre' : null,
                      onChanged: (val) {
                        setState(() => nombre = val);
                      },
                      //keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      initialValue: userData.nombre,
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
                      initialValue: userData.apellidoPaterno,
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
                      initialValue: userData.apellidoMaterno,
                      decoration: const InputDecoration(
                        hintText: 'Apellido materno',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
              
                    //Container(child: const Text('Género')),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      
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
                        Text('${!selectedNewDate ? userData.fechaNacimiento.toLocal() : fechaNacimiento.toLocal()}'.split(' ')[0], style: TextStyle(color: Theme.of(context).colorScheme.secondary,),)
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: TextButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        child: const Text('Seleccionar nueva fecha'),
                      ),
                    ),
                    const SizedBox(height: 10,),
              
                    ElevatedButton(
                      onPressed: () {
                        db.updateUserData(
                          nombre.isEmpty? userData.nombre : nombre,
                          apellidoPaterno.isEmpty? userData.apellidoPaterno : apellidoPaterno,
                          apellidoMaterno.isEmpty? userData.apellidoMaterno : apellidoMaterno,
                          userData.correo,
                          !selectedNewDate ? '${userData.fechaNacimiento.year}-${userData.fechaNacimiento.month.toString().padLeft(2, '0')}-${userData.fechaNacimiento.day.toString().padLeft(2, '0')}' : '${fechaNacimiento.year}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}',
                          gender != userData.gender ? gender : userData.gender,
                        );
                        Navigator.pop(context);
                      }, 
                      child: const Text('Guardar y salir'),
                    ),
                    const Text('Aún que los cambios se ven reflejados inmediatemente en firebase, para ver los cambios es necesario recargar la aplicación o hacer un hot reload. Ya que cuando se obtienen los datos de usuario en la pantalla anterior se usa un future builder en lugar de un stream y ya no me dio tiempo de cambiar a stream '), 
                  ]
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
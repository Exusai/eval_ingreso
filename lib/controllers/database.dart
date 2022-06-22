import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eval_ingreso/models/pokemon.dart';
import 'package:eval_ingreso/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('Usuarios');
  
  //UserInfo from snapshot
  UserData _userFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid:                uid,
      nombre:             snapshot.get('Nombre') ?? '',
      apellidoPaterno:    snapshot.get('ApellidoPaterno') ?? '',
      apellidoMaterno:    snapshot.get('ApellidoMaterno') ?? '',
      correo:             snapshot.get('Correo') ?? '', 
      fechaNacimiento:    DateTime.parse(snapshot.get('FechaNacimiento')), 
      gender:             snapshot.get('Gender') ?? '', 
    );
  }

  //Subir/Actualizar colecciones en la base datos
  //actualizar/subir info del usuario
  Future updateUserData(String nombre, String apellidoPaterno, String apellidoMaterno, String correo, String fechaNacimiento, String gender) async{
    return await userCollection.doc(uid).set({
      'Nombre': nombre,
      'ApellidoPaterno': apellidoPaterno,
      'ApellidoMaterno': apellidoMaterno,
      'Correo': correo,
      'FechaNacimiento': fechaNacimiento,
      'Gender' : gender,
    });
  }

  // Streams
  //get user Stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  // get single snapshot from user data
  Future<UserData> getUserData() async {
    DocumentSnapshot data = await userCollection.doc(uid).get();
    return UserData(
      uid:                uid,
      nombre:             data.get('Nombre') ?? '',
      apellidoPaterno:    data.get('ApellidoPaterno') ?? '',
      apellidoMaterno:    data.get('ApellidoMaterno') ?? '',
      correo:             data.get('Correo') ?? '', 
      fechaNacimiento:    DateTime.parse(data.get('FechaNacimiento')), 
      gender:             data.get('Gender') ?? '', 
    );
  }
}
class Usuario {
  final String uid;
  final bool isAnon;
  
  Usuario ({required this.uid, required this.isAnon});
}

class UserData {
  String uid;
  String nombre;
  String apellidoPaterno;
  String apellidoMaterno;
  String correo;
  DateTime fechaNacimiento;
  String gender;

  UserData({
    required this.uid,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.correo,
    required this.fechaNacimiento,
    required this.gender,
  });

}
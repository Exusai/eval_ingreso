import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //crea objeto usuario basado en el usuario que recive de servidor
  Usuario? _userFromFirebaseUser(User? user){
    return user != null ? Usuario(uid: user.uid, isAnon: user.isAnonymous) : null;
    //return Usuario(uid: user.uid, isAnon: user.isAnonymous);
  }

  //authStream
  Stream<Usuario?> get user{
    //return _auth.authStateChanges().map((User user) => _userFromFirebaseUser(user));
    //return _auth.authStateChanges().map((User user) => _userFromFirebaseUser(user));
    return _auth.authStateChanges().map((event) => _userFromFirebaseUser(event));
  }

  //Ingresar anonimo
  Future singInAnon() async{
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);   
      //return user;
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //crear usuario con correo y contraseña
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password); 
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //email and ps
  Future singInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password); 
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //salir (log out)
  Future singOut() async{
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  void changeMail(String mail) async{
    //Pass in the password to updatePassword.
    _auth.currentUser?.updateEmail(mail).then((_){
      print("Your password changed Succesfully ");
    }).catchError((err){
      print("You can't change the Password" + err.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }
}
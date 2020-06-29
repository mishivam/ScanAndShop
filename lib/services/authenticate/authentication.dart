import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future singInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      
      return user.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      await auth.signOut();
      return "Done";
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

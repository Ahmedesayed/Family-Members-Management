import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;


Future<UserCredential> signUp(String email, String pass) async {
  try {
    UserCredential userCredential = await auth
        .createUserWithEmailAndPassword(email: email, password: pass);
        return userCredential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    return null;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<UserCredential> login(String email, String pass) async {
  try {
    UserCredential userCredential = await auth
        .signInWithEmailAndPassword(email: email, password: pass);
        return userCredential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
    return null;
  }
}

logout() async{
  try {
    await auth.signOut();
  } catch (e) {
    print('error in logout $e');
  }
}

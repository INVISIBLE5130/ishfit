import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_flutter_app/domain/user.dart';

class AuthService {
  final FirebaseAuth fAuth = FirebaseAuth.instance;

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await fAuth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return User.fromFirebase(user);
    } catch(e) {
      return null;
    }
  }

  Future<User> registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await fAuth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return User.fromFirebase(user);
    } catch(e) {
      return null;
    }
  }

  Future logOut() async {
    await fAuth.signOut();
  }

  Stream<User> get currentUser {
    return fAuth.onAuthStateChanged.map(
            (FirebaseUser user) => user != null ? User.fromFirebase(user) : null
    );
  }
}
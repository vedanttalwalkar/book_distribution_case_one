import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final _firebaseAuthentication = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuthentication.currentUser;
  Stream<User?> get authStateChanges =>
      _firebaseAuthentication.authStateChanges();

  Future<void> signInWithAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuthentication.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _firebaseAuthentication.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuthentication.signOut();
  }
}

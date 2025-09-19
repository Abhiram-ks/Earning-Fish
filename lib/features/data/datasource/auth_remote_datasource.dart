import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRemoteDatasource {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String?> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (_) {

    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user?.uid;
}
 catch (e) {
  log('exeption : $e');
      throw Exception('Login failed: $e. Please try again');
    }
  }
}

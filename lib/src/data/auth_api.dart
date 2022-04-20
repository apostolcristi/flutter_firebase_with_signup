import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_with_signup/src/models/app_user.dart';

class AuthApi {
  AuthApi(this._auth);

  final FirebaseAuth _auth;

  Future<AppUser?> getCurrentUser() async {
    if (_auth.currentUser != null) {
      return AppUser(email: _auth.currentUser!.email!, uid: _auth.currentUser!.uid);
    }
    return null;
  }

  Future<AppUser> login({required String email, required String password}) async {
    final UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);

    return AppUser(email: email, uid: credential.user!.uid);
  }
}

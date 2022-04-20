import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_with_signup/src/models/app_user.dart';

class AuthApi {
  AuthApi(this._auth);

  final FirebaseAuth _auth;

  Future<AppUser?> getCurrentUser() async {
    if (_auth.currentUser != null) {
      return AppUser(
        email: _auth.currentUser!.email!,
        uid: _auth.currentUser!.uid,
        username: _auth.currentUser!.displayName!,
      );
    }
    return null;
  }

  Future<AppUser> login({required String email, required String password}) async {
    final UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);

    return AppUser(email: email, uid: credential.user!.uid, username: credential.user!.displayName!);
  }

  Future<AppUser> create({required String email, required String password, required String username}) async {
    final UserCredential credentials = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    await _auth.currentUser!.updateDisplayName(username);

    return AppUser(email: email, uid: credentials.user!.uid, username: username);
  }
}

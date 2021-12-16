import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthHelperProvider = Provider<FirebaseAuthHelper>(
    (ref) => FirebaseAuthHelper(FirebaseAuth.instance));

class FirebaseAuthHelper {
  const FirebaseAuthHelper(this.auth);
  final FirebaseAuth auth;

  Stream<User?> getStreamAuthUser() {
    return auth.authStateChanges().map((User? user) => user);
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user != null;
    } catch (e) {
      debugPrint('AuthService login: $e');
      rethrow;
    }
  }

  String? get currentUserId => auth.currentUser?.uid;

  Future<String> createAnonymousUser() async {
    try {
      final userCredential = await auth.signInAnonymously();
      final anonymousUser = userCredential.user;
      return anonymousUser!.uid;
    } catch (e) {
      debugPrint('Error in FirebaseAuthHelper.createAnonymousUser(): $e');
      rethrow;
    }
  }

  Future<void> linkWithCredential({required AuthCredential credential}) async {
    final user = auth.currentUser;
    await user?.linkWithCredential(credential);
  }

  Future<bool> sendPasswordResetEmail({required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      debugPrint('sendPasswordResetEmail $e');
      return false;
    }
  }

  bool isUserEmailRegistered() {
    return auth.currentUser != null ? !auth.currentUser!.isAnonymous : false;
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      debugPrint('Error in signOut: $e');
    }
  }
}

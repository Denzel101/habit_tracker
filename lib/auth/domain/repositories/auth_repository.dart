import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return response.user;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> logoutUser() async {
    try {
      await _auth.signOut();
    } catch (_) {
      rethrow;
    }
  }

  Future<User> registerUser({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user != null) {
        await user.updateDisplayName(username);
      }

      return user!;
    } catch (_) {
      rethrow;
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:TaskPulse/data/todo_data.dart';

abstract class AuthenticationDatasource {
  Future<void> register(String email, String password, String confirmpassword);
  Future<void> login(String email, String password);
  Future<void> logout();
  Future<void> resetPassword(String email);
}

class AuthenticationRemote extends AuthenticationDatasource {
  @override
  Future<String> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return 'Login Successful!';
    } on FirebaseAuthException catch (e) {
      print('Error code: ${e.code}');
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-credential') {
        return 'Invalid Credentials!';
      } else if (e.code == 'too-many-requests') {
        return 'We have blocked all requests from this device due to unusual activity. Try again later or reset your password to restore access.';
      } else {
        return 'An error occurred. Please try again.';
      }
    }
  }

  @override
  Future<String> register(
      String email, String password, String confirmpassword) async {
    try {
      if (confirmpassword == password) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.trim(), password: password.trim())
            .then((value) {
          Firestore_Datasource().CreateUser(email);
        });
        return 'Registration Successful!';
      } else {
        return 'Passwords do not match';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak. It must be at least 6 characters long.';
      } else if (e.code == 'email-already-in-use') {
        return 'An account already exists for that email.';
      } else {
        return 'An error occurred. Please try again.';
      }
    } catch (e) {
      return 'An error occurred. Please try again.';
    }
  }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Future<String> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      return 'If an account exists for the provided email, a password reset link has been sent. Please check your email.';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else {
        return 'An error occurred. Please try again.';
      }
    }
  }
}

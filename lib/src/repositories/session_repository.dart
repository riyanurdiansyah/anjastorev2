import 'package:firebase_auth/firebase_auth.dart';

abstract class SessionRepository {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static User? get currentUser => FirebaseAuth.instance.currentUser;

  static bool? _isLoggedIn = false;

  static User? userLoggedin;

  static String? isLoggedIn() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _isLoggedIn = user?.uid != null;
    });
    if (_firebaseAuth.currentUser == null) {
      _isLoggedIn = false;
    } else {
      _isLoggedIn = true;
    }
    if (_isLoggedIn == true) {
      return null;
    } else {
      return "/signin";
    }
  }

  static isSetUsername(User user) {
    userLoggedin = user;
  }

  static String userEmail() {
    return _firebaseAuth.currentUser?.displayName ?? "No Name";
  }
}

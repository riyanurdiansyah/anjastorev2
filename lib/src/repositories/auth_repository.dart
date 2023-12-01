import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_m.dart';

abstract class AuthRepository {
  Future<User?> signUp(Map<String, dynamic> body);

  Future<User?> signIn(Map<String, dynamic> body);

  Future<UserM?> getUser(String id);

  Future signOut();
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User?> signUp(Map<String, dynamic> body) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: body["email"],
        password: body["password"],
      );
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<User?> signIn(Map<String, dynamic> body) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: body["email"],
        password: body["password"],
      );
      return userCredential.user;
    } catch (e) {
      debugPrint("ERROR SIGNIN : ${e.toString()}");
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<UserM?> getUser(String id) async {
    try {
      final response =
          await FirebaseFirestore.instance.collection("users").doc(id).get();
      if (response.exists) {
        return UserM.fromJson(response.data()!);
      }
      return null;
    } catch (e) {
      debugPrint("ERROR GET USER : ${e.toString()}");
      return null;
    }
  }
}

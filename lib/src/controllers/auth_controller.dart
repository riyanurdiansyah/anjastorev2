import 'package:anjastore/config/app_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/app_route_name.dart';
import '../repositories/auth_repository.dart';

class AuthController extends GetxController {
  final tcUsername = TextEditingController();

  final tcPassword = TextEditingController();

  final AuthRepository authRepository = AuthRepositoryImpl();

  late SharedPreferences prefs;

  final isLoading = false.obs;

  final errorMessage = "".obs;

  final Rx<bool> isLoggedIn = false.obs;

  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = await isAuthenticated();
    super.onInit();
  }

  @override
  void dispose() {
    tcUsername.dispose();
    tcPassword.dispose();
    super.dispose();
  }

  Future<bool> isAuthenticated() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return true;
    }

    return false;
  }

  void signIn() async {
    isLoading.value = true;
    errorMessage.value = "";

    final body = {
      "email": tcUsername.text,
      "password": tcPassword.text,
    };
    await authRepository.signIn(body).then(
      (usr) async {
        if (usr != null) {
          await authRepository.getUser(usr.uid).then(
            (data) {
              if (data != null) {
                isLoggedIn.value = true;
                prefs.setString("email", data.email);
                prefs.setInt("role", data.role);
                navigatorKey.currentContext!.goNamed(AppRouteName.home);
              } else {
                errorMessage.value = "Username atau password salah";
              }
            },
          );
        } else {
          errorMessage.value = "Username atau password salah";
        }
      },
    );
    isLoading.value = false;
  }

  void signOut() async {
    await authRepository.signOut();
  }
}

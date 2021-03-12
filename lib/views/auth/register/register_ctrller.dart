import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchme/apis/auth.dart';
import 'package:punchme/models/user_m.dart';
import 'package:punchme/overlays/snackbar.dart';
import 'package:punchme/routes/routes.dart';
import 'package:punchme/utils/date_time.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterCtrller extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final password2Ctrl = TextEditingController();
  AuthRepo authRepo = AuthApis();
  final isLoading = false.obs;

  void register() async {
    if (formKey.currentState.validate()) {
      try {
        isLoading.value = true;
        JxSnackBarLoading(isLoading.value);
        final userCred =
            await authRepo.register(emailCtrl.text, passwordCtrl.text);
        await createUserDetails(userCred);
        isLoading.value = false;
        JxSnackBarLoading(isLoading.value);
        print('dsds');
        Get.offAllNamed(Routes.phone);
      } catch (e) {
        isLoading.value = false;
        JxSnackBarLoading(isLoading.value);
        print(e);
        String error;
        if (e.toString().contains('The email address is already')) {
          error = 'Email already being used';
        } else {
          error = 'Something went wrong...';
        }
        JxSnackBarStatus(null, error);
      }
    }
  }

  void toLogin() => Get.toNamed(Routes.login);

  Future<void> googlelogin() async {
    try {
      JxSnackBarLoading(true);
      final userCred = await authRepo.googleLogin();
      await createUserDetails(userCred);
      JxSnackBarLoading(false);
      Get.offAllNamed(Routes.phone);
    } catch (e) {
      print(e);
      JxSnackBarLoading(isLoading.value);
      JxSnackBarStatus(null, null);
    }
  }

  Future<void> faceboooklogin() async {}

  Future<void> createUserDetails(UserCredential userCred) async {
    final fbm = FirebaseMessaging();
    String token = await fbm.getToken();
    final userM = UserM(
        id: userCred.user.uid,
        email: emailCtrl.text,
        date: setDate(),
        token: token);
    await authRepo.createUserDetails(userM);
    final saver = await SharedPreferences.getInstance();
    saver.setString('email', emailCtrl.text);
    saver.setString('id', userCred.user.uid);
    saver.setString('token', token);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchme/apis/auth.dart';
import 'package:punchme/overlays/snackbar.dart';
import 'package:punchme/routes/routes.dart';
import 'package:punchme/views/auth/register/register_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  AuthRepo authRepo = AuthApis();
  final isLoading = false.obs;
  final showPassword = false.obs;

  final RegisterController registerController = Get.find();

   void togglePassword() {
      showPassword.value = showPassword.value ? false : true;

  }

  void login() async {
    if (formKey.currentState.validate()) {
      try {
        isLoading.value = true;
        JxSnackBarLoading(isLoading.value);
        await authRepo.login(emailCtrl.text, passwordCtrl.text);
        final userM = await authRepo.getUserDetails();
        final saver = await SharedPreferences.getInstance();
        saver.setString('id', userM.id);
        saver.setString('token', userM.token);
        saver.setString('image', userM.image);
        saver.setString('email', userM.email);
        saver.setString('name', userM.name);
        saver.setString('phone', userM.phone);
        isLoading.value = false;
        JxSnackBarLoading(isLoading.value);
        Get.offAllNamed(Routes.pager, arguments: userM);
      } catch (e) {
        isLoading.value = false;
        JxSnackBarLoading(isLoading.value);
        String error;
        switch (e.code) {
          case 'wrong-password':
            error = 'Invalid password';
            break;
          case 'user-not-found':
            error = 'Email not found';
            break;
          default:
            error = 'Something went wrong...';
            break;
        }
        JxSnackBarStatus(null, error);
      }
    }
  }

  void toForgotPassword() => Get.toNamed(Routes.forgotPassword);

  void toRegister() => Get.back();

  void googlelogin() async {
    await registerController.googlelogin();
  }

  void faceboooklogin() async {
    await registerController.faceboooklogin();
  }
}

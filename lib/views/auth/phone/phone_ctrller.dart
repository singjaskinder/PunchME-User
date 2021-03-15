import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:punchme/apis/auth.dart';
import 'package:punchme/overlays/snackbar.dart';
import 'package:punchme/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneCtrller extends GetxController {
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final dropdownValue = '+91'.obs;
  final List<String> phoneCodes = ['+91', '+61'];
  String phoneNo;

  String verId;
  Timer timer;
  final count = 60.obs;
  AuthRepo authRepo = AuthApis();

  void checkPhoneNo() {
    if (formKey.currentState.validate()) {
      phoneNo = dropdownValue.value + ' ' + phoneCtrl.text;
      print(phoneNo);
      Get.toNamed(Routes.otp);
      sendOTPCode();
    }
  }

  void sendOTPCode() async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) async {
      try {
        JxSnackBarLoading(true);
        await auth.currentUser.linkWithCredential(phoneAuthCredential);
        await updatePhone();
        JxSnackBarLoading(false);
        Get.offAllNamed(Routes.pager);
      } catch (e) {
        String error;
        cancelTimer();
        if (e.toString().contains('User has already been linked')) {
          error = 'Phone number already in use';
          Future.delayed(Duration(seconds: 2), () {
            Get.back(closeOverlays: true);
          });
        }
        JxSnackBarStatus(null, error);
      }
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      JxSnackBarStatus(null, 'OTP verification failed');
      cancelTimer();
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      verId = verificationId;
      startTimer();
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      cancelTimer();
    };

    await auth.verifyPhoneNumber(
        phoneNumber: dropdownValue.value + phoneCtrl.text,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void submitOTP(String otp) async {
    try {
      JxSnackBarLoading(true);
      AuthCredential _authCredential =
          PhoneAuthProvider.credential(verificationId: verId, smsCode: otp);
      await auth.currentUser.linkWithCredential(_authCredential);
      await updatePhone();
      JxSnackBarLoading(false);
      Get.offAllNamed(Routes.pager);
    } catch (e) {
      String error;
      cancelTimer();
      if (e.toString().contains('User has already been linked')) {
        error = 'Phone number already in use';
        Future.delayed(Duration(seconds: 2), () {
          Get.back(closeOverlays: true);
        });
      }
      JxSnackBarStatus(null, error);
    }
  }

  void startTimer() {
    count.value = 60;
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(oneSec, (Timer timer) {
      if (count.value == 0) {
        timer.cancel();
      } else {
        count.value = count.value - 1;
      }
    });
  }

  void cancelTimer() {
    timer.cancel();
    count.value = 0;
  }

  Future<void> updatePhone() async {
    cancelTimer();
    final data = {'name': nameCtrl.text, 'phone': phoneNo};
    await authRepo.updateUserDetails(data);
    final saver = await SharedPreferences.getInstance();
    saver.setString('name', nameCtrl.text);
    saver.setString('phone', phoneNo);
  }

  @override
  void onClose() {
    super.onClose();
    if (count.value != 60) {
      timer.cancel();
    }
  }
}

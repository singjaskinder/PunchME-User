import 'package:punchme/views/auth/forgot_password/forgot_password.dart';
import 'package:punchme/views/auth/login/login.dart';
import 'package:punchme/views/auth/phone/otp.dart';
import 'package:punchme/views/auth/phone/phone.dart';
import 'package:punchme/views/auth/register/register.dart';
import 'package:punchme/views/home/pager.dart';
import 'package:get/get.dart';
import 'package:punchme/views/landing/landing.dart';

class Routes {
  static const landing = '/landing';
  static const login = '/login';
  static const forgotPassword = '/forgotPassword';
  static const register = '/register';
  static const phone = '/phone';
  static const otp = '/otp';
  static const pager = '/pager';

  static routes() => [
        GetPage(name: landing, page: () => Landing()),
        GetPage(name: login, page: () => Login()),
        GetPage(name: forgotPassword, page: () => ForgotPassword()),
        GetPage(name: register, page: () => Register()),
        GetPage(name: phone, page: () => Phone()),
        GetPage(name: otp, page: () => OTP()),
        GetPage(name: pager, page: () => Pager()),
      ];
}

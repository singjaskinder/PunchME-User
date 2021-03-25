import 'package:get/get.dart';
import 'package:punchme/views/auth/forgot_password/forgot_password.dart';
import 'package:punchme/views/auth/login/login.dart';
import 'package:punchme/views/auth/phone/otp.dart';
import 'package:punchme/views/auth/phone/phone.dart';
import 'package:punchme/views/auth/register/register.dart';
import 'package:punchme/views/home/pager.dart';
import 'package:punchme/views/home/pages/requests/requests.dart';
import 'package:punchme/views/home/sub_pages/about/about.dart';
import 'package:punchme/views/home/sub_pages/collected_points/collected_points.dart';
import 'package:punchme/views/home/sub_pages/faq/faq.dart';
import 'package:punchme/views/home/sub_pages/help_support/help_support.dart';
import 'package:punchme/views/home/sub_pages/history/history.dart';
import 'package:punchme/views/home/sub_pages/punches/punches.dart';
import 'package:punchme/views/home/sub_pages/scan_QR/scan_QR.dart';
import 'package:punchme/views/home/sub_pages/store_details/store_details.dart';
import 'package:punchme/views/landing/landing.dart';
import 'package:punchme/views/user_location/user_location.dart';

class Routes {
  static const landing = '/landing';
  static const login = '/login';
  static const forgotPassword = '/forgotPassword';
  static const register = '/register';
  static const phone = '/phone';
  static const otp = '/otp';
  static const userLocation = '/userLocation';
  static const pager = '/pager';
  static const requests = '/requests';
  static const storeDetails = '/storeDetails';
  static const history = '/history';
  static const punches = '/punches';
  static const collectedPoints = '/collectedPoints';
  static const helpSupport = '/helpSupport';
  static const about = '/about';
  static const faq = '/faq';

  static routes() => [
        GetPage(name: landing, page: () => Landing()),
        GetPage(name: login, page: () => Login()),
        GetPage(name: forgotPassword, page: () => ForgotPassword()),
        GetPage(name: register, page: () => Register()),
        GetPage(name: phone, page: () => Phone()),
        GetPage(name: otp, page: () => OTP()),
        GetPage(name: pager, page: () => Pager()),
        GetPage(name: userLocation, page: () => UserLocation()),
        GetPage(name: requests, page: () => Requests()),
        GetPage(name: storeDetails, page: () => StoreDetails()),
        GetPage(name: history, page: () => History()),
        GetPage(name: collectedPoints, page: () => CollectedPoints()),
        GetPage(name: punches, page: () => Punches()),
        GetPage(name: helpSupport, page: () => HelpSupport()),
        GetPage(name: about, page: () => About()),
        GetPage(name: faq, page: () => Faq()),
      ];
}

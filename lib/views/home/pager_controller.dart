import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:punchme/apis/auth.dart';
import 'package:punchme/models/user_m.dart';
import 'package:punchme/overlays/dialog.dart';
import 'package:punchme/overlays/snackbar.dart';
import 'package:punchme/views/home/pages/requests/requests.dart';
import 'package:punchme/views/home/sub_pages/scan_QR/scan_QR.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/account/account.dart';
import 'pages/explore/explore.dart';
import 'pages/nearby/nearby.dart';
import 'pages/offers/offer.dart';

class PagerController extends GetxController {
  AuthRepo authRepo = AuthApis();
  final currIndex = 0.obs;
  final userM = UserM().obs;
  final name = ''.obs;
  final phone = ''.obs;
  final image = ''.obs;

  final List<JxPageView> pages = [
    JxPageView(page: Explore(), icon: Icons.explore, name: 'Explore'),
    JxPageView(page: NearBy(), icon: Icons.near_me, name: 'Nearby'),
    JxPageView(page: ScanQr(), icon: FontAwesomeIcons.qrcode, name: 'Scan QR'),
    JxPageView(page: Offer(), icon: Icons.local_offer, name: 'Offers'),
    JxPageView(page: Account(), icon: Icons.person, name: 'Account'),
  ];

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 1), () async {
      await getUserDetails();
    });
  }

  Future<void> getUserDetails() async {
    try {
      JxSnackBarLoading(true);
      final saved = await SharedPreferences.getInstance();
      userM.value = await authRepo.getUserDetails();
      name.value = saved.get('name') ?? 'Hello there!';
      phone.value = saved.get('phone') ?? '';
      image.value = saved.get('image');
      JxSnackBarLoading(false);
    } catch (e) {
      print(e);
      JxSnackBarLoading(false);
      JxSnackBarStatus(null, null);
      final doExit = () => SystemNavigator.pop();
      JxDialog(null, null, 'Retry', 'Exit', getUserDetails, doExit);
    }
  }
}

class JxPageView {
  JxPageView({this.page, this.icon, this.name});
  final Widget page;
  final IconData icon;
  final String name;
}

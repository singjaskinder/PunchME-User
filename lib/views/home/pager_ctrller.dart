import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/account/account.dart';
import 'pages/explore/explore.dart';
import 'pages/nearby/nearby.dart';
import 'pages/offers/offer.dart';
import 'pages/qr_scan/qr_scan.dart';

class PageCtrller extends GetxController {
  final currIndex = 0.obs;
  final name = ''.obs;
  final phone = ''.obs;
  final image = ''.obs;

  final List<JxPageView> pages = [
    JxPageView(page: Explore(), icon: Icons.explore, name: 'Explore'),
    JxPageView(page: NearBy(), icon: Icons.near_me, name: 'Nearby'),
    JxPageView(page: QRScan(), icon: FontAwesomeIcons.qrcode, name: 'Scan'),
    JxPageView(page: Offer(), icon: Icons.local_offer, name: 'Offer'),
    JxPageView(page: Account(), icon: Icons.person, name: 'account'),
  ];

  @override
  void onInit() {
    super.onInit();
    getUserDetails();
  }

  void getUserDetails() async {
    final saved = await SharedPreferences.getInstance();
    name.value = saved.get('name') ?? 'Hello there!';
    phone.value = saved.get('phone') ?? '';
    image.value = saved.get('image');
  }
}

class JxPageView {
  JxPageView({this.page, this.icon, this.name});
  final Widget page;
  final IconData icon;
  final String name;
}

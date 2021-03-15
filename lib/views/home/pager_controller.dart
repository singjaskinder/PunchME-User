import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchme/apis/auth.dart';
import 'package:punchme/models/user_m.dart';
import 'package:punchme/views/home/pages/requests/requests.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/account/account.dart';
import 'pages/explore/explore.dart';
import 'pages/nearby/nearby.dart';
import 'pages/offers/offer.dart';

class PageCtrller extends GetxController {
  AuthRepo authRepo = AuthApis();
  final currIndex = 0.obs;
  final userM = UserM().obs;
  final name = ''.obs;
  final phone = ''.obs;
  final image = ''.obs;

  final List<JxPageView> pages = [
    JxPageView(page: Explore(), icon: Icons.explore, name: 'Explore'),
    JxPageView(page: NearBy(), icon: Icons.near_me, name: 'Nearby'),
    JxPageView(
        page: Requests(),
        icon: Icons.remove_from_queue_sharp,
        name: 'Requests'),
    JxPageView(page: Offer(), icon: Icons.local_offer, name: 'Offers'),
    JxPageView(page: Account(), icon: Icons.person, name: 'Account'),
  ];

  @override
  void onInit() {
    super.onInit();
    getUserDetails();
  }

  void getUserDetails() async {
    final saved = await SharedPreferences.getInstance();
    userM.value = await authRepo.getUserDetails();
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

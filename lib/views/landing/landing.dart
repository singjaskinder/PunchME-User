import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchme/core/size_config.dart';
import 'package:punchme/res/app_colors.dart';
import 'package:punchme/res/app_styles.dart';
import 'package:punchme/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing extends StatefulWidget {
  static const id = 'landing';
  Landing({Key key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() async {
    User user = FirebaseAuth.instance.currentUser;

    Future.delayed(Duration(seconds: 1), () async {
      if (user == null) {
        Get.offAndToNamed(Routes.register);
      } else {
        final saved = await SharedPreferences.getInstance();
        if (saved.get('phone') != null) {
          Get.offAndToNamed(Routes.phone);
        } else {
          Get.offAndToNamed(Routes.pager);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Center(
      child: Text('Punch ME',
          style: AppStyles.idleTxt.copyWith(color: AppColors.yellow)),
    ));
  }
}

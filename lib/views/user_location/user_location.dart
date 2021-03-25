import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchme/common/sizedbox.dart';
import 'package:punchme/common/text.dart';
import 'package:punchme/res/app_colors.dart';
import 'package:punchme/views/auth/login/login_controller.dart';

class UserLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Container();
    return Scaffold(
        backgroundColor: AppColors.darkerGrey,
        body: Container(
          child: Obx(
            () => Visibility(
              visible: true,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      JxText('Location Service is Disabled', size: 10),
                      JxSizedBox(),
                      GestureDetector(
                        onTap: null,
                        child: Obx(() => JxText(
                              'Please wait...',
                              size: 12,
                              color: AppColors.yellow,
                              isBold: true,
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

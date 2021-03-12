import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchme/common/buttons.dart';
import 'package:punchme/common/header.dart';
import 'package:punchme/common/sizedbox.dart';
import 'package:punchme/common/social_connect.dart';
import 'package:punchme/common/text.dart';
import 'package:punchme/core/size_config.dart';
import 'package:punchme/res/app_colors.dart';
import 'package:punchme/res/app_styles.dart';

import 'forgot_password_ctrller.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ctrller = Get.put(ForgotPasswordCtrller());
    return Scaffold(
      backgroundColor: AppColors.darkerGrey,
      body: SafeArea(
          child: Stack(
        children: [
          BackgroundImage(),
          HeaderClipped(),
          Padding(
            padding: EdgeInsets.all(SizeConfig.width * 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.height * 20,
                ),
                JxText('Forgot Password',
                    size: 6, color: AppColors.yellow, isBold: true),
                JxSizedBox(),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Form(
                    key: ctrller.formKey,
                    child: TextFormField(
                        controller: ctrller.emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            labelText: 'Enter Email',
                            prefixIcon: Icon(Icons.email)),
                        validator: (val) =>
                            val.isEmail ? null : 'Enter valid email address'),
                  ),
                ),
                JxSizedBox(height: 2),
                Obx(
                  () => TextIconBTN(
                    enabled: !ctrller.isLoading.value,
                    onPressed: () => ctrller.sendPasswordResetLink(),
                    label: 'Submit',
                    icondata: Icons.navigate_next,
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}

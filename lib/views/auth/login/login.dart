import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:punchme/common/buttons.dart';
import 'package:punchme/common/header.dart';
import 'package:punchme/common/sizedbox.dart';
import 'package:punchme/common/social_connect.dart';
import 'package:punchme/common/text.dart';
import 'package:punchme/res/app_colors.dart';
import 'package:punchme/res/app_styles.dart';
import 'package:punchme/utils/size_config.dart';
import 'package:punchme/views/auth/login/login_controller.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: AppColors.darkerGrey,
      body: SafeArea(
          child: Stack(
        children: [
          BackgroundImage(),
          HeaderClipped(),
          Padding(
            padding: EdgeInsets.all(SizeConfig.width * 5),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: SizeConfig.height * 18,
                  ),
                  JxText('Login',
                      size: 8, color: AppColors.yellow, isBold: true),
                  SizedBox(
                    height: SizeConfig.width,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                        controller: controller.emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            labelText: 'Enter Email',
                            prefixIcon: Icon(Icons.email)),
                        validator: (val) =>
                            val.isEmail ? null : 'Enter valid email address'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Obx(
                      () => TextFormField(
                          controller: controller.passwordCtrl,
                          obscureText: !controller.showPassword.value,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              labelText: 'Enter Password',
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: GestureDetector(
                                onTap: () => controller.togglePassword(),
                                child: Icon(controller.showPassword.value
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash),
                              )),
                          validator: (val) => val.length >= 6
                              ? null
                              : 'Password should contain atleast 6 characters'),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: MaterialButton(
                        onPressed: () => controller.toForgotPassword(),
                        shape: AppStyles.minimalBorder,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: JxText('Forgot password?',
                              size: 4, color: AppColors.yellow),
                        )),
                  ),
                  SizedBox(
                    height: SizeConfig.width * 3,
                  ),
                  Row(children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          JxText(
                            'Hello! New Here?,',
                            size: 4.5,
                          ),
                          GestureDetector(
                            onTap: () => controller.toRegister(),
                            child: JxText(
                              'Register here,',
                              size: 4,
                              color: AppColors.yellow,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => TextIconBTN(
                          enabled: !controller.isLoading.value,
                          onPressed: () => controller.login(),
                          label: 'Login',
                          icondata: Icons.navigate_next,
                        ),
                      ),
                    )
                  ]),
                  JxSizedBox(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text('or\nConnect with',
                        textAlign: TextAlign.center,
                        style: AppStyles.idleTxt.copyWith(
                          color: AppColors.white,
                        )),
                  ),
                  SizedBox(
                    height: SizeConfig.width * 4,
                  ),
                  SocialConnect(
                    onGoogleTap: () => controller.googlelogin(),
                    onFacebookTap: () => controller.faceboooklogin(),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

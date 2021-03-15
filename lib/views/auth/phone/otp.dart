import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:punchme/common/header.dart';
import 'package:punchme/common/sizedbox.dart';
import 'package:punchme/common/text.dart';
import 'package:punchme/res/app_colors.dart';
import 'package:punchme/res/app_styles.dart';

import 'file:///C:/work/punchme/punchme/lib/utils/size_config.dart';

import 'phone_ctrller.dart';

class OTP extends StatelessWidget {
  const OTP({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PhoneCtrller ctrller = Get.find();
    return WillPopScope(
        onWillPop: () async {
          ctrller.cancelTimer();
          return true;
        },
        child: Scaffold(
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
                    JxSizedBox(
                      height: 25,
                    ),
                    JxText('Please enter OTP you received',
                        size: 6, color: AppColors.yellow, isBold: true),
                    SizedBox(
                      height: SizeConfig.width * 2,
                    ),
                    JxText(
                      'OTP has been sent to number:\n${ctrller.phoneNo}',
                      size: 4,
                      isBold: true,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: SizeConfig.width * 8,
                    ),
                    Center(
                      child: Container(
                        width: double.infinity,
                        child: OTPTextField(
                          length: 6,
                          fieldWidth: 20,
                          textFieldAlignment: MainAxisAlignment.spaceEvenly,
                          keyboardType: TextInputType.number,
                          onChanged: (val) {},
                          style: AppStyles.idleTxt.copyWith(
                              color: AppColors.yellow,
                              fontSize: SizeConfig.width * 6),
                          onCompleted: (val) => ctrller.submitOTP(val),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.width * 10,
                    ),
                    Center(
                      child: Obx(
                        () => GestureDetector(
                          onTap: ctrller.count.value == 0
                              ? () => ctrller.sendOTPCode()
                              : null,
                          child: Text(
                              ctrller.count.value == 0
                                  ? 'Resend'
                                  : 'Resend OTP in ${ctrller.count.value}',
                              textAlign: TextAlign.left,
                              style: AppStyles.idleTxt.copyWith(
                                  fontSize: SizeConfig.width * 4,
                                  color: ctrller.count.value == 0
                                      ? AppColors.yellow
                                      : AppColors.white,
                                  fontWeight: ctrller.count.value == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchme/common/buttons.dart';
import 'package:punchme/common/sizedbox.dart';
import 'package:punchme/common/text.dart';
import 'package:punchme/res/app_colors.dart';
import 'package:punchme/utils/size_config.dart';

class JxDialog {
  JxDialog(String title, String text, String posLabel, String negLabel,
      Function onPos, Function onNeg) {
    Get.dialog(
        Scaffold(
            backgroundColor: AppColors.transparent,
            body: Center(
              child: Container(
                width: SizeConfig.width * 80,
                padding: EdgeInsets.all(15),
                color: AppColors.darkGrey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    JxText(title ?? 'Oops',
                        size: 6, isBold: true, color: AppColors.yellow),
                    JxSizedBox(),
                    JxText(
                      text ?? 'Something went wrong ...',
                      size: 4,
                      maxLines: 4,
                    ),
                    JxSizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Visibility(
                            visible: negLabel != null,
                            child: TextBTN(
                              onPressed: () =>
                                  onNeg == null ? Get.back() : onNeg(),
                              enabled: true,
                              label: negLabel ?? '',
                              isDark: true,
                              textSize: 4,
                            )),
                        JxSizedBox(),
                        TextBTN(
                          onPressed: () => onPos == null ? Get.back() : onPos(),
                          enabled: true,
                          label: posLabel ?? 'OK',
                          isDark: true,
                          textSize: 4,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
        barrierDismissible: false);
  }
}

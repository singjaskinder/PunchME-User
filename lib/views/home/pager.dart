import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchme/res/app_colors.dart';
import 'package:punchme/res/app_styles.dart';
import 'package:punchme/utils/size_config.dart';

import 'pager_controller.dart';

class Pager extends StatelessWidget {
  const Pager({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final controller = Get.put(PageCtrller());
    return Scaffold(
      backgroundColor: AppColors.darkerGrey,
      body: SafeArea(
        child: Obx(
          () => IndexedStack(
            index: controller.currIndex.value,
            children: [for (JxPageView view in controller.pages) view.page],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: SizeConfig.height * 9,
        child: Row(
          children: [
            for (int i = 0; i < controller.pages.length; i++)
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.currIndex.value = i,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(
                        () => Icon(controller.pages[i].icon,
                            size: i == controller.currIndex.value
                                ? SizeConfig.width * 8
                                : SizeConfig.width * 6.5,
                            color: i == controller.currIndex.value
                                ? AppColors.yellow
                                : AppColors.white),
                      ),
                      Obx(
                        () => Text(controller.pages[i].name,
                            style: AppStyles.idleTxt.copyWith(
                                color: i == controller.currIndex.value
                                    ? AppColors.yellow
                                    : AppColors.white,
                                fontSize: SizeConfig.width * 3.5)),
                      )
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

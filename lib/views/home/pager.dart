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
    final controller = Get.put(PagerController());
    return Scaffold(
      backgroundColor: AppColors.darkerGrey,
      body: Stack(children: [
        SafeArea(
          child: Obx(
            () => IndexedStack(
              index: controller.currIndex.value,
              children: [for (JxPageView view in controller.pages) view.page],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipPath(
              clipper: TrapeziumClipper(),
              child: Container(
                width: double.infinity,
                height: SizeConfig.height * 9,
                color: AppColors.black,
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: SizeConfig.height * 11,
            child: Row(
              children: [
                for (int i = 0; i < controller.pages.length; i++)
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.currIndex.value = i,
                      child: Align(
                        alignment: 2 == i
                            ? Alignment.topCenter
                            : Alignment.bottomCenter,
                        child: Padding(
                          padding: 2 == i
                              ? EdgeInsets.zero
                              : EdgeInsets.only(bottom: 11),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 2 == i
                                    ? SizeConfig.width * 8
                                    : SizeConfig.width * 4,
                                backgroundColor: 2 == i
                                    ? AppColors.black.withOpacity(0.2)
                                    : Colors.transparent,
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    child: Icon(controller.pages[i].icon,
                                        size: 2 == i
                                            ? SizeConfig.width * 14.5
                                            : i == controller.currIndex.value
                                                ? SizeConfig.width * 8
                                                : SizeConfig.width * 6.5,
                                        color: 2 == i
                                            ? AppColors.yellow.withOpacity(0.6)
                                            : i == controller.currIndex.value
                                                ? AppColors.white
                                                : AppColors.white)),
                              ),
                              Visibility(
                                visible: !(2 == i),
                                child: Obx(
                                  () => Text(controller.pages[i].name,
                                      style: AppStyles.idleTxt.copyWith(
                                          color: i == controller.currIndex.value
                                              ? AppColors.yellow
                                              : AppColors.white,
                                          fontSize: SizeConfig.width * 3.5)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class TrapeziumClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double loc = 0.4;
    double s = 0.2;
    path.moveTo(0, 0);
    path.lineTo((loc - 0.1) * size.width, 0);
    path.cubicTo(
      (loc + s * 0.20) * size.width,
      size.height * 0.05,
      loc * size.width,
      size.height * 0.60,
      (loc + s * 0.50) * size.width,
      size.height * 0.70,
    );
    path.cubicTo(
      (loc + s) * size.width,
      size.height * 0.60,
      (loc + s - s * 0.20) * size.width,
      size.height * 0.08,
      (loc + s + 0.1) * size.width,
      0,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TrapeziumClipper oldClipper) => false;
}

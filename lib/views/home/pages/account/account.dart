import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meet_network_image/meet_network_image.dart';
import 'package:punchme/common/buttons.dart';
import 'package:punchme/common/image_picker.dart';
import 'package:punchme/common/sizedbox.dart';
import 'package:punchme/common/text.dart';
import 'package:punchme/res/app_colors.dart';
import 'package:punchme/res/app_styles.dart';
import 'package:punchme/utils/size_config.dart';

import '../../pager_controller.dart';
import 'account_controller.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountController());
    final PagerController pageController = Get.find();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Obx(() => Container(
                  child: pageController.image.value.isEmpty
                      ? CircleAvatar(
                          radius: SizeConfig.width * 12,
                          backgroundColor: AppColors.black.withOpacity(0.5),
                          child: Icon(Icons.person,
                              color: AppColors.yellow.withOpacity(0.8)),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(80)),
                          child: MeetNetworkImage(
                              imageUrl: pageController.image.value,
                              width: SizeConfig.width * 23,
                              loadingBuilder: (_) {
                                return CircularProgressIndicator();
                              },
                              errorBuilder: (_, e) {
                                print(e.toString);
                                return Icon(Icons.person,
                                    color: AppColors.yellow.withOpacity(0.8));
                              }),
                        ))),
              SizedBox(
                width: SizeConfig.width * 4,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      pageController.name.value,
                      style: AppStyles.idleTxt.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.width * 5,
                          letterSpacing: 2),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.width,
                  ),
                  Obx(
                    () => Text(
                      pageController.phone.value,
                      style: AppStyles.idleTxt.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.width * 3.5,
                          letterSpacing: 2),
                    ),
                  )
                ],
              ),
              Spacer(),
              Visibility(
                visible: true,
                child: IconButton(
                  onPressed: () => controller.showEditProfileModal(context),
                  icon: Icon(
                    Icons.edit,
                    size: SizeConfig.width * 6,
                    color: AppColors.yellow,
                  ),
                ),
              )
            ],
          ),
        ),
        JxSizedBox(),
        Expanded(
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.black.withOpacity(0.3),
                borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  for (int i = 0; i < controller.menus.length; i++)
                    ListTile(
                      onTap: () =>
                          controller.toView(controller.menus[i].routeName),
                      leading: Icon(controller.menus[i].icon),
                      title: JxText(controller.menus[i].name,
                          size: 4, isBold: true),
                      trailing: Icon(
                        Icons.navigate_next,
                        color: AppColors.yellow,
                      ),
                    ),
                  ListTile(
                      onTap: () => controller.logout(),
                      leading: Icon(Icons.exit_to_app_outlined),
                      title: JxText('Sign out', size: 4, isBold: true)),
                  Divider(
                      thickness: 5,
                      height: 10,
                      color: AppColors.darkGrey.withOpacity(0.5)),
                  ListTile(
                      onTap: null,
                      title: JxText('App Version', size: 4),
                      trailing: JxText('v0.0.1', size: 3)),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

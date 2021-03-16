import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchme/common/buttons.dart';
import 'package:punchme/common/sizedbox.dart';
import 'package:punchme/common/snapshot_status.dart';
import 'package:punchme/common/text.dart';
import 'package:punchme/models/service_history_m.dart';
import 'package:punchme/res/app_colors.dart';
import 'package:punchme/utils/size_config.dart';

import 'requests_ctrller.dart';

class PointsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RequestsController controller = Get.find();
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Center(
        child: StreamBuilder<DocumentSnapshot>(
          stream: controller.getServiceDetails(),
          builder: (_, snap) {
            if (snap.hasData) {
              final serviceHistoryPointM =
                  ServiceHistoryPointM.fromJson(snap.data.data());
              final remaining =
                  controller.requestM.doIt - serviceHistoryPointM.total;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: SizeConfig.width * 65,
                    color: AppColors.darkGrey,
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        JxSizedBox(
                          height: 2,
                        ),
                        JxText(
                          'Whoo!',
                          size: 5,
                          maxLines: 3,
                          isBold: true,
                          isCenter: true,
                          color: AppColors.yellow,
                        ),
                        JxSizedBox(
                          height: 1.5,
                        ),
                        JxText(
                          'Punched!',
                          size: 8,
                          isBold: true,
                          color: AppColors.yellow,
                        ),
                        JxSizedBox(
                          height: 4,
                        ),
                        remaining != 0
                            ? JxText(
                                '$remaining points Remaining',
                                size: 5,
                                isBold: true,
                              )
                            : JxText(
                                'Points Collected!\nYou get Free!',
                                size: 5,
                                isBold: true,
                              ),
                      ],
                    ),
                  ),
                  JxSizedBox(),
                  Container(
                    width: SizeConfig.width * 65,
                    child: TextIconBTN(
                        onPressed: () =>
                            remaining != 0 ? Get.back() : controller.doRedeem(),
                        label: remaining != 0 ? 'OK' : 'Redeem',
                        icondata: Icons.done,
                        enabled: true),
                  )
                ],
              );
            } else if (snap.hasError) {
              return SnapshotError();
            } else {
              return SnapshotLoading();
            }
          },
        ),
      ),
    );
  }
}

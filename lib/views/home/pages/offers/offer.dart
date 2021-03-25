import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchme/common/service_tile.dart';
import 'package:punchme/common/snapshot_status.dart';
import 'package:punchme/models/service_m.dart';
import 'package:punchme/res/app_colors.dart';
import 'package:punchme/utils/size_config.dart';
import 'package:punchme/views/home/pages/offers/offer_controller.dart';

class Offer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final controller = Get.put(OfferController());
    return Column(
      children: [
        Expanded(
            child: StreamBuilder<List<DocumentSnapshot>>(
          stream: controller.getServices(),
          builder: (_, snap) {
            if (snap.hasData) {
              if (snap.data.isEmpty) {
                return SnapshotEmpty('No services found');
              }
              return ListView.separated(
                  itemCount: snap.data.length,
                  separatorBuilder: (_, i) {
                    return Container(
                      color: AppColors.lightGrey,
                      padding: EdgeInsets.all(4),
                    );
                  },
                  itemBuilder: (_, i) {
                    final serviceM = ServiceM.fromJson(snap.data[i].data());
                    return ServiceTile(serviceM,toApply: false);
                  });
            } else if (snap.hasError) {
              return SnapshotError();
            } else {
              return SnapshotLoading();
            }
          },
        ))
      ],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchme/common/request_tile.dart';
import 'package:punchme/common/snapshot_status.dart';
import 'package:punchme/models/requests_m.dart';
import 'package:punchme/res/app_colors.dart';

import 'requests_controller.dart';

class Requests extends StatelessWidget {
  const Requests({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RequestsController());
    return Column(
      children: [
        Expanded(
            child: StreamBuilder<QuerySnapshot>(
          stream: controller.get(),
          builder: (_, snap) {
            if (snap.hasData) {
              if (snap.data.docs.isEmpty) {
                Get.back();
                return SnapshotEmpty('No Request at moment');
              }
              return ListView.separated(
                  itemCount: snap.data.docs.length,
                  separatorBuilder: (_, i) {
                    return Container(
                      color: AppColors.darkGrey,
                      padding: EdgeInsets.all(4),
                    );
                  },
                  itemBuilder: (_, i) {
                    final requestM =
                        RequestM.fromJson(snap.data.docs[i].data());
                    return RequestTile(requestM);
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

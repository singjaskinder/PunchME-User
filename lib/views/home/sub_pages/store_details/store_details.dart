import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchme/common/minimal_scaffold.dart';
import 'package:punchme/common/service_tile.dart';
import 'package:punchme/common/sizedbox.dart';
import 'package:punchme/common/snapshot_status.dart';
import 'package:punchme/common/text.dart';
import 'package:punchme/models/service_m.dart';
import 'package:punchme/models/store_m.dart';
import 'package:punchme/res/app_colors.dart';
import 'package:punchme/res/app_styles.dart';
import 'package:punchme/utils/size_config.dart';
import 'store_details_controller.dart';

class StoreDetails extends StatelessWidget {
  const StoreDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StoreDetailsController());
    final res = Get.arguments;
    final StoreM storeM = res[0];
    final String tag = res[1];
    final toApply = res.length == 3;
    return Scaffold(
        backgroundColor: AppColors.darkerGrey,
        appBar: AppBar(
            iconTheme: IconThemeData().copyWith(color: AppColors.yellow),
            elevation: 0,
            title: JxText('Details',
                color: AppColors.yellow, size: 8, isBold: true),
            backgroundColor: Colors.transparent),
        body: Column(
          children: [
            Hero(
              tag: tag,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.all(
                            Radius.circular(SizeConfig.width * 20)),
                        child: Image.network(
                          storeM.images[0],
                          width: SizeConfig.width * 30,
                          height: SizeConfig.width * 30,
                          fit: BoxFit.cover,
                        )),
                    SizedBox(
                      width: SizeConfig.width * 4,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        JxText(
                          storeM.name,
                          size: 5,
                          maxLines: 2,
                          isBold: true,
                          color: AppColors.yellow,
                        ),
                        SizedBox(height: 2),
                        Container(
                          width: SizeConfig.width * 60,
                          child: Text(storeM.description,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: AppStyles.idleTxt),
                        ),
                        SizedBox(height: 6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(storeM.province, style: AppStyles.idleTxt),
                            Visibility(
                                visible: false,
                                child: Text('0.9 Km away',
                                    style: AppStyles.idleTxt)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            JxSizedBox(),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: controller.getServicesBySid(storeM.id),
                    builder: (_, snap) {
                      if (snap.hasData) {
                        if (snap.data.docs.isEmpty) {
                          return SnapshotEmpty('No services found');
                        }
                        return ListView.separated(
                            itemCount: snap.data.docs.length,
                            separatorBuilder: (_, i) {
                              return Container(
                                color: AppColors.lightGrey,
                                padding: EdgeInsets.all(4),
                              );
                            },
                            itemBuilder: (_, i) {
                              final serviceM =
                                  ServiceM.fromJson(snap.data.docs[i].data());
                              return ServiceTile(serviceM, toApply: toApply);
                            });
                      } else if (snap.hasError) {
                        return SnapshotError();
                      } else {
                        return SnapshotLoading();
                      }
                    }))
          ],
        ));
  }
}

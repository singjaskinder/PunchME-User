import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchme/common/snapshot_status.dart';
import 'package:punchme/common/text.dart';
import 'package:punchme/models/store_m.dart';
import 'package:punchme/res/app_colors.dart';
import 'package:punchme/res/app_styles.dart';
import 'package:punchme/utils/size_config.dart';

import 'nearby_controller.dart';

class NearBy extends StatelessWidget {
  const NearBy({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NearByController());
    return Container(
      child: Column(
        children: [
          Expanded(
              child: StreamBuilder<List<DocumentSnapshot>>(
            stream: controller.getStores(),
            builder: (_, snap) {
              if (snap.hasData) {
                if (snap.data.isEmpty) {
                  return SnapshotEmpty('No nearby stores found');
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
                      final storeM = StoreM.fromJson(snap.data[i].data());
                      return StoreTile(storeM, 'store$i');
                    });
              } else if (snap.hasError) {
                return SnapshotError();
              } else {
                return SnapshotLoading();
              }
            },
          ))
        ],
      ),
    );
  }
}

class StoreTile extends StatelessWidget {
  const StoreTile(this.storeM, this.tag, {Key key}) : super(key: key);
  final StoreM storeM;
  final String tag;
  @override
  Widget build(BuildContext context) {
    final NearByController controller = Get.find();
    return GestureDetector(
      onTap: () => controller.toStoreDetails(storeM, tag),
      child: Hero(
        tag: tag,
        child: Container(
          color: AppColors.black,
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    storeM.images[0],
                    width: SizeConfig.width * 25,
                    height: SizeConfig.width * 25,
                    fit: BoxFit.cover,
                  )),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(storeM.name,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.idleTxt.copyWith(
                          color: AppColors.yellow,
                          fontSize: SizeConfig.width * 6)),
                  SizedBox(height: 2),
                  Container(
                    width: SizeConfig.width * 60,
                    child: Text(storeM.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: AppStyles.idleTxt),
                  ),
                  SizedBox(height: 6),
                  Visibility(
                    visible: false,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('BrisBane', style: AppStyles.idleTxt),
                        Visibility(
                            visible: false,
                            child:
                                Text('0.9 Km away', style: AppStyles.idleTxt)),
                      ],
                    ),
                  )
                ],
              ),
              Spacer(),
              Icon(
                Icons.navigate_next,
                color: AppColors.yellow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

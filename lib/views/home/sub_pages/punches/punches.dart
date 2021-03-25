import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchme/common/minimal_scaffold.dart';
import 'package:punchme/common/snapshot_status.dart';
import 'package:punchme/models/offer_history.dart';
import 'package:punchme/res/app_colors.dart';
import 'package:punchme/res/app_styles.dart';
import 'package:punchme/utils/size_config.dart';
import 'punches_controller.dart';

class Punches extends StatelessWidget {
  const Punches({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PunchesController());
    return JxMinimalScaffold(
      titleText: 'Punches',
      body: Expanded(
          child: StreamBuilder<QuerySnapshot>(
        stream: controller.getPunches(),
        builder: (_, snap) {
          if (snap.hasData) {
            if (snap.data.docs.isEmpty) {
              return SnapshotEmpty('No stores founnd');
            }
            return ListView.builder(
                itemCount: snap.data.docs.length,
                itemBuilder: (_, i) {
                  final offerHistory =
                      OfferHistory.fromJson(snap.data.docs[i].data());
                  return Container(
                    color: AppColors.black,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: false,
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: Image.network(
                                'https://bakingamoment.com/wp-content/uploads/2019/02/IMG_3165-best-white-chocolate-mocha-recipe.jpg',
                                width: SizeConfig.width * 25,
                                height: SizeConfig.width * 25,
                                fit: BoxFit.cover,
                              )),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(offerHistory.offerName,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles.idleTxt.copyWith(
                                    color: AppColors.yellow,
                                    fontSize: SizeConfig.width * 4.5)),
                            SizedBox(height: 4),
                            Container(
                              child: Text(
                                  '${offerHistory.doIt - offerHistory.lapse.length} punches remaining',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: AppStyles.idleTxt),
                            ),
                            SizedBox(height: 8),
                            Visibility(
                              visible: offerHistory.doIt -
                                      offerHistory.lapse.length ==
                                  0,
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: GestureDetector(
                                  onTap: () => controller.redeem(offerHistory),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: SizeConfig.width * 8),
                                    child: Text('Redeem',
                                        style: AppStyles.idleTxt.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: SizeConfig.width * 5)),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.transparent,
                                            AppColors.blue
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          stops: [0.0, 1.0],
                                          tileMode: TileMode.clamp),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                });
          }
          if (snap.hasData) {
            return SnapshotError();
          } else {
            return SnapshotLoading();
          }
        },
      )),
    );
  }
}

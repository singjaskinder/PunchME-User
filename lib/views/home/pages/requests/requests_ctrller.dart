import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchme/apis/requests.dart';
import 'package:punchme/common/sizedbox.dart';
import 'package:punchme/common/snapshot_status.dart';
import 'package:punchme/common/text.dart';
import 'package:punchme/models/requests_m.dart';
import 'package:punchme/models/service_history_m.dart';
import 'package:punchme/res/app_colors.dart';
import 'package:punchme/utils/infos.dart';

class RequestsController extends GetxController {
  RequestsRepo requestsRepo = RequestsApis();
  RequestM requestM;

  String requestStatus(RequestM requestM) {
    if (requestM.status == null) {
      return 'Waiting for confirmation';
    }
    if (requestM.status) {
      return 'Accepted';
    } else {
      return 'Rejected';
    }
  }

  Stream<QuerySnapshot> get() async* {
    yield* requestsRepo.get();
  }

  Stream<DocumentSnapshot> getServiceDetails() async* {
    yield* requestsRepo.getServiceDetails(requestM.sid);
  }

  String getServiceInfos(RequestM requestM) {
    if (requestM.status != null) {
      if (requestM.status) {
        this.requestM = requestM;
        Future.delayed(Duration(seconds: 1), () async {
          Get.dialog(PunchDialog(), barrierDismissible: true);
          Future.delayed(Duration(seconds: 4), () async {
            Get.back();
          });
        });
      }
    }

    return getServiceInfo(requestM);
  }
}

class PunchDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RequestsController controller = Get.find();
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Center(
        child: Container(
          color: AppColors.darkGrey,
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
            stream: controller.getServiceDetails(),
            builder: (_, snap) {
              if (snap.hasData) {
                final serviceHistoryM =
                    ServiceHistoryM.fromJson(snap.data.data());
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    JxText(
                      'Punched!',
                      size: 8,
                      isBold: true,
                      color: AppColors.yellow,
                    ),
                    JxSizedBox(
                      height: 4,
                    ),
                    controller.requestM.punch
                        ? (controller.requestM.doIt -
                                    serviceHistoryM.lapse.length) ==
                                0
                            ? JxText(
                                (controller.requestM.doIt -
                                            serviceHistoryM.lapse.length)
                                        .toString() +
                                    ' Remaining',
                                size: 5,
                                isBold: true,
                              )
                            : JxText(
                                'Punch Completed!\nYou get Free!',
                                size: 5,
                                isBold: true,
                              )
                        : JxText(
                            (controller.requestM.doIt).toString() +
                                ' Points collected',
                            size: 5,
                            isBold: true,
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
      ),
    );
  }
}

// Column(
// mainAxisAlignment: MainAxisAlignment.center,
// mainAxisSize: MainAxisSize.min,
// children: [
// E
// ],
// )

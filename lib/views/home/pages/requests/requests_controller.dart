import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchme/apis/requests.dart';
import 'package:punchme/models/requests_m.dart';
import 'package:punchme/overlays/progress_dialog.dart';
import 'package:punchme/utils/infos.dart';
import 'package:punchme/views/home/pages/requests/points_dialog.dart';
import 'package:punchme/views/home/pages/requests/punch_dialog.dart';

class RequestsController extends GetxController {
  RequestsRepo requestsRepo = RequestsApis();
  RequestM requestM = RequestM();

  @override
  onInit() {
    super.onInit();
    requestM.punch = true;
  }

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

  void doRedeem() async {
    try {
      isLoading(true);
      dynamic serviceHistoryM;
      if (requestM.punch) {
        serviceHistoryM = {'times': FieldValue.increment(1), 'lapse': []};
      } else {
        serviceHistoryM = {
          'times': FieldValue.increment(1),
          'lapse': [],
          'total': 0
        };
      }

      await requestsRepo.redeem(requestM, serviceHistoryM);
      Get.back();
      isLoading(false);
    } catch (e) {
      isLoading(false);
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
        Future.delayed(Duration(milliseconds: 5), () async {
          Get.dialog(AfterScannedDialog(), barrierDismissible: false);
        });
      }
    }

    return getServiceInfo(requestM);
  }
}

class AfterScannedDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RequestsController controller = Get.find();
    return controller.requestM.punch ? PunchDialog() : PointsDialog();
  }
}

// Column(
// mainAxisAlignment: MainAxisAlignment.center,
// mainAxisSize: MainAxisSize.min,
// children: [
// E
// ],
// )

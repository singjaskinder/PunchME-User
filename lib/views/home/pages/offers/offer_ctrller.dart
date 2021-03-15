import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:punchme/apis/requests.dart';
import 'package:punchme/apis/services.dart';
import 'package:punchme/models/requests_m.dart';
import 'package:punchme/models/service_m.dart';
import 'package:punchme/overlays/progress_dialog.dart';
import 'package:punchme/overlays/snackbar.dart';
import 'package:punchme/routes/routes.dart';
import 'package:punchme/utils/date_time.dart';
import 'package:punchme/views/home/pager_controller.dart';

class OfferCtrller extends GetxController {
  ServicesRepo servicesRepo = ServicesApis();
  RequestsRepo requestsRepo = RequestsApis();
  final PageCtrller pageCtrller = Get.find();

  Future<void> toScanQR(ServiceM serviceM) async {
    final res = await Get.toNamed(Routes.scanQr);
    if (res != null) {
      final userM = pageCtrller.userM.value;
      final requestM = RequestM(
          date: setDate(),
          uid: userM.id,
          userName: userM.name,
          oid: serviceM.sid,
          storeName: serviceM.storeName,
          sid: serviceM.id,
          serviceName: serviceM.name,
          price: serviceM.price,
          doIt: serviceM.doIt,
          getIt: serviceM.getIt,
          punch: serviceM.punch,
          status: null);
      createRequest(requestM);
    }
  }

  Stream<QuerySnapshot> get() async* {
    yield* servicesRepo.get();
  }

  void createRequest(RequestM requestM) async {
    try {
      isLoading(true);
      await requestsRepo.create(requestM);
      pageCtrller.currIndex.value = 2;
      isLoading(false);
    } catch (e) {
      print(e);
      isLoading(false);
      JxSnackBarStatus(null, null);
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:punchme/apis/nearby.dart';
import 'package:punchme/apis/requests.dart';
import 'package:punchme/models/requests_m.dart';
import 'package:punchme/models/service_m.dart';
import 'package:punchme/overlays/progress_dialog.dart';
import 'package:punchme/overlays/snackbar.dart';
import 'package:punchme/routes/routes.dart';
import 'package:punchme/utils/date_time.dart';
import 'package:punchme/views/home/pager_controller.dart';
import 'package:punchme/views/home/pages/explore/explore_controller.dart';

class OfferController extends GetxController {
  NearByRepo nearByRepo = NearByApis();
  RequestsRepo requestsRepo = RequestsApis();
  final PagerController pageController = Get.find();
  final ExploreController exploreController = Get.find();

  Stream<List<DocumentSnapshot>> getServices() async* {
    yield* nearByRepo.getServices(exploreController.currLocation.value);
  }

  void createRequest(ServiceM serviceM) async {
    try {
      final userM = pageController.userM.value;
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
      isLoading(true);
      await requestsRepo.create(requestM);
      isLoading(false);
      Get.toNamed(Routes.requests);
    } catch (e) {
      print(e);
      isLoading(false);
      JxSnackBarStatus(null, null);
    }
  }
}

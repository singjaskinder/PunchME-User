import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:punchme/apis/nearby.dart';
import 'package:punchme/models/store_m.dart';
import 'package:punchme/routes/routes.dart';
import 'package:punchme/views/home/pages/explore/explore_controller.dart';

class NearByController extends GetxController {
  NearByRepo nearByRepo = NearByApis();
  final ExploreController exploreController = Get.find();

  Stream<List<DocumentSnapshot>> getStores() async* {
    print('exploreController.currLocation.value');
    print('exploreController.currLocation.value');
    print(exploreController.currLocation.value);
    print('exploreController.currLocation.value');
    yield* nearByRepo.getStores(exploreController.currLocation.value);
  }

  void toStoreDetails(StoreM storeM, String tag) =>
      Get.toNamed(Routes.storeDetails, arguments: [storeM, tag]);
}

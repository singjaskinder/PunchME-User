import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:punchme/apis/nearby.dart';

class StoreDetailsController extends GetxController {
  NearByRepo nearByRepo = NearByApis();

  Stream<QuerySnapshot> getServicesBySid(String sid) async* {
    yield* nearByRepo.getServicesBySid(sid);
  }
}

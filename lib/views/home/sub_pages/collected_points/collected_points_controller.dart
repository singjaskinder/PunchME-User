import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:punchme/apis/history.dart';
import 'package:punchme/models/offer_history.dart';
import 'package:punchme/models/point_history.dart';
import 'package:punchme/overlays/progress_dialog.dart';
import 'package:punchme/overlays/snackbar.dart';

class CollectedPointsController extends GetxController {
  HistoryRepo historyRepo = HistoryApis();

  Stream<QuerySnapshot> getCollectedPoints() async* {
    yield* historyRepo.getCollectedPoints();
  }

  void redeem(PointHistory pointHistory) async {
    try {
      isLoading(true);
      // await historyRepo.deleteUserDetails(offerHistory.sid);
      // await historyRepo.deleteOfferDetails(offerHistory.sid, false);
      isLoading(false);
      JxSnackBarStatus('Confirmation', 'Offer redeemed');
    } catch (e) {
      print(e);
      isLoading(false);
      JxSnackBarStatus(null, null);
    }
  }
}

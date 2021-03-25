import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:punchme/apis/history.dart';
import 'package:punchme/models/offer_history.dart';
import 'package:punchme/overlays/progress_dialog.dart';
import 'package:punchme/overlays/snackbar.dart';

class PunchesController extends GetxController {
  HistoryRepo historyRepo = HistoryApis();

  Stream<QuerySnapshot> getPunches() async* {
    yield* historyRepo.getPunches();
  }

  void redeem(OfferHistory offerHistory) async {
    try {
      isLoading(true);
      await historyRepo.deleteUserDetails(offerHistory.sid);
      await historyRepo.deleteOfferDetails(offerHistory.sid, true);
      isLoading(false);
      JxSnackBarStatus('Confirmation', 'Offer redeemed');
    } catch (e) {
      print(e);
      isLoading(false);
      JxSnackBarStatus(null, null);
    }
  }
}

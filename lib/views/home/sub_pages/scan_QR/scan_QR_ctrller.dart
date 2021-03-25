import 'package:get/get.dart';
import 'package:punchme/apis/nearby.dart';
import 'package:punchme/models/store_m.dart';
import 'package:punchme/overlays/progress_dialog.dart';
import 'package:punchme/overlays/snackbar.dart';
import 'package:punchme/routes/routes.dart';

class ScanQrController extends GetxController {
  NearByRepo nearByRepo = NearByApis();

  void checkScannedData(String qrData) async {
    if (qrData != null) {
      try {
        final data = await nearByRepo.getStoreByid(qrData);
        if (data != null) {
          final storeM = StoreM.fromJson(data.data());
          Get.toNamed(Routes.storeDetails, arguments: [storeM, 'tag', true]);
        } else {
          JxSnackBarStatus(null, 'Invalid QR code');
        }
      } catch (e) {
        print(e);
        isLoading(false);
        JxSnackBarStatus(null, null);
      }
    } else {
      JxSnackBarStatus(null, 'Invalid QR code');
    }
  }
}

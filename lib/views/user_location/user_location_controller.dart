import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as places;
import 'package:punchme/overlays/progress_dialog.dart';
import 'package:punchme/routes/routes.dart';

class UserLocationController extends GetxController {
  LocationData locationData;
  final curLocation = LatLng(0, 0).obs;
  final curAddress = ''.obs;
  final locationLoading = true.obs;
  final locationEnabled = false.obs;

  @override
  void onInit() async {
    super.onInit();
    isLoading(true);
    try {
      await getLocation();
      isLoading(false);
      Get.toNamed(Routes.pager);
    } catch (e) {
      isLoading(false);
    }
  }

  void retryLocation() {}

  Future<void> getLocation() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    isLoading(true);
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        locationEnabled.value = false;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        locationEnabled.value = false;
      }
    }

    // aus
    // final currLocation = LatLng(-27.4962461, 153.0585295);
    locationData = await location.getLocation();
    final currLocation = LatLng(locationData.latitude, locationData.longitude);
    curLocation.value = currLocation;
    curAddress.value = await getAddressTextAll(currLocation);
  }

  static Future<String> getAddressTextAll(LatLng location) async {
    List<places.Placemark> placemarks;
    placemarks = null;
    placemarks = await places.placemarkFromCoordinates(
        location.latitude, location.longitude);
    return (placemarks[0].street.isNotEmpty
            ? placemarks[0].street + ', '
            : '') +
        (placemarks[0].subLocality.isNotEmpty
            ? placemarks[0].subLocality + ', '
            : '') +
        placemarks[0].subAdministrativeArea +
        ', ' +
        placemarks[0].administrativeArea +
        ', ' +
        placemarks[0].postalCode;
  }
}

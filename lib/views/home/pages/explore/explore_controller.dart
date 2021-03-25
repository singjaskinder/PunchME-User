import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ExploreController extends GetxController {
  GoogleMapController googleMapController;
  String mapStyle;
  final mapLoaded = false.obs;
  final initialPos = CameraPosition(
    target: LatLng(-27.46734279806083, 153.02699760251284),
    zoom: 12,
  );

  LocationData locationData;
  final currLocation = LatLng(18.958213421987228, 72.82699919284576).obs;
  final curAddress = ''.obs;

  @override
  void onInit() {
    super.onInit();
    rootBundle.loadString('maps/map_style.txt').then((string) {
      mapStyle = string;
    });
  }


  void animateToLocation(LatLng latLng) {
    final cameraPosition = CameraPosition(
      target: latLng,
      zoom: 12,
    );
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }


}

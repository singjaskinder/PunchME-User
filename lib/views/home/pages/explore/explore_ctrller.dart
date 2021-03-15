import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ExploreCtrller extends GetxController {
  GoogleMapController controller;
  String mapStyle;
  bool mapLoaded = false;
  bool locationdisabled = true;
  final enabling = false.obs;

  final initialPos = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 1,
  );

  @override
  void onInit() {
    super.onInit();
    rootBundle.loadString('maps/map_style.txt').then((string) {
      mapStyle = string;
    });
  }
}

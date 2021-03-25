import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:punchme/common/sizedbox.dart';
import 'package:punchme/common/text.dart';
import 'package:punchme/res/app_colors.dart';

import 'explore_controller.dart';

class Explore extends StatelessWidget {
  const Explore({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExploreController());
    return Scaffold(
      body: Stack(children: [
        Obx(
          () => GoogleMap(
            scrollGesturesEnabled: controller.mapLoaded.value,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            initialCameraPosition: controller.initialPos,
            onMapCreated: (GoogleMapController googleMapController) {
              controller.googleMapController = googleMapController;
              controller.mapLoaded.value = true;
              googleMapController.setMapStyle(controller.mapStyle);
            },
          ),
        ),
        
      ]),
    );
  }
}

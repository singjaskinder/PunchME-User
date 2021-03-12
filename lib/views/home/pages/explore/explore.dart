import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:punchme/common/sizedbox.dart';
import 'package:punchme/common/text.dart';
import 'package:punchme/res/app_colors.dart';

import 'explore_ctrller.dart';

class Explore extends StatelessWidget {
  const Explore({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrller = Get.put(ExploreCtrller());
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          scrollGesturesEnabled: ctrller.mapLoaded,
          buildingsEnabled: false,
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          initialCameraPosition: ctrller.initialPos,
          onMapCreated: (GoogleMapController controller) {
            ctrller.controller = controller;
            controller.setMapStyle(ctrller.mapStyle);
          },
        ),
        Visibility(
          visible: ctrller.mapLoaded,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  JxText('Location Service is Disabled', size: 10),
                  JxSizedBox(),
                  GestureDetector(
                    onTap: null,
                    child: Obx(() => JxText(
                          ctrller.enabling.value ? 'Please wait...' : 'Enable',
                          size: 12,
                          color: AppColors.yellow,
                          isBold: true,
                        )),
                  )
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}

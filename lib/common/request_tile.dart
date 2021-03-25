import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchme/models/requests_m.dart';
import 'package:punchme/res/app_colors.dart';
import 'package:punchme/utils/date_time.dart';
import 'package:punchme/views/home/pages/requests/requests_controller.dart';

import 'marker.dart';
import 'text.dart';

class RequestTile extends StatelessWidget {
  RequestTile(this.requestM);
  final RequestM requestM;
  @override
  Widget build(BuildContext context) {
    final RequestsController requestsController = Get.find();
    return Container(
      padding: EdgeInsets.all(5),
      color: AppColors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: JxText(
              getDateFromSTMP(requestM.date),
              size: 3.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: JxText(
              requestM.storeName.capitalize,
              size: 4,
              isBold: true,
              color: AppColors.yellow,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: JxText(
              requestM.serviceName,
              size: 5,
              isBold: true,
              maxLines: 2,
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: JxText(
                  requestsController.getServiceInfos(requestM),
                  size: 4,
                  color: AppColors.yellow,
                ),
              ),
              Spacer(),
              JxMarker(requestM.punch),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: JxText(
                  requestsController.requestStatus(requestM),
                  size: 5,
                  color: AppColors.lightGrey,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

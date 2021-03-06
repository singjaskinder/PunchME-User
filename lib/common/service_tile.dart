import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:punchme/common/buttons.dart';
import 'package:punchme/models/service_m.dart';
import 'package:punchme/res/app_colors.dart';
import 'package:punchme/res/app_styles.dart';
import 'package:punchme/utils/currency.dart';
import 'package:punchme/utils/size_config.dart';
import 'package:punchme/views/home/pages/offers/offer_controller.dart';

import 'sizedbox.dart';
import 'text.dart';

class ServiceTile extends StatefulWidget {
  ServiceTile(this.serviceM, {@required this.toApply, Key key})
      : super(key: key);
  final ServiceM serviceM;
  final bool toApply;

  @override
  _ServiceState createState() => _ServiceState();
}

class _ServiceState extends State<ServiceTile>
    with SingleTickerProviderStateMixin {
  bool isSelected = false;
  AnimationController _controller;
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.25);
  Animation<double> _iconTurns;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String offerInfo(ServiceM serviceM) {
    return '${serviceM.punch ? 'Punch' : 'Collect'} ${serviceM.doIt} ${serviceM.punch ? 'and get' : 'points and get'},\n${serviceM.getIt} for free ';
  }

  @override
  Widget build(BuildContext context) {
    animation = Tween(begin: -20.0, end: 40.0).animate(_controller);
    final serviceM = widget.serviceM;
    final toApply = widget.toApply;
    final OfferController controller = Get.find();
    return Material(
      color: AppColors.black,
      child: InkWell(
        splashColor: AppColors.yellow.withOpacity(0.6),
        onTap: () {
          setState(() {
            isSelected = !isSelected;
            if (isSelected) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
          });
        },
        child: ClipRRect(
          child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              height:
                  isSelected ? SizeConfig.height * 38 : SizeConfig.height * 13,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.network(serviceM.images[0],
                              width: SizeConfig.width * 25)),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          JxText(
                            serviceM.name,
                            color: AppColors.yellow,
                            isBold: true,
                          ),
                          SizedBox(height: 2),
                          JxText(
                            offerInfo(serviceM),
                            maxLines: 2,
                            size: 3.8,
                          ),
                        ],
                      ),
                      Spacer(),
                      AnimatedOpacity(
                        opacity: isSelected ? 0.2 : 1.0,
                        duration: Duration(milliseconds: 800),
                        child: RotationTransition(
                          turns: _iconTurns,
                          //angle: isSelected ? math.pi / 2 : -math.pi / 120,
                          child: Icon(
                            Icons.navigate_next,
                            color: AppColors.yellow,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      JxSizedBox(
                        height: 1.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(3, 12, 0, 0),
                        child: JxText(
                          serviceM.description,
                          maxLines: 5,
                          size: 4,
                        ),
                      ),
                      JxSizedBox(),
                      Row(
                        children: [
                          Expanded(child: PriceBox(serviceM)),
                          Expanded(
                              child: DoItBox(
                            serviceM,
                          )),
                          Expanded(child: GetItBox(serviceM)),
                        ],
                      ),
                      JxSizedBox(),
                      Row(
                        children: [
                          Visibility(
                            visible: !serviceM.punch,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              child: JxText(
                                'Per scan 1 point will be collected',
                                size: 3,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 8),
                            decoration: BoxDecoration(
                                color: AppColors.yellow,
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(10))),
                            child: JxText(
                              serviceM.punch ? 'Punch' : 'Points',
                              size: 3,
                              isBold: true,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                      JxSizedBox(),
                      Visibility(
                        visible: toApply,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: SizeConfig.width * 50,
                            child: TextIconBTN(
                                onPressed: () =>
                                    controller.createRequest(serviceM),
                                label: 'Get offer',
                                icondata: Icons.navigate_next,
                                enabled: true),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}

class PriceBox extends StatelessWidget {
  PriceBox(this.serviceM);
  final ServiceM serviceM;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: AppStyles.minimalBorderRadius,
          border: Border.all(width: 1, color: AppColors.yellow)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          JxText(
            'Price:',
            maxLines: 5,
            size: 3.5,
          ),
          JxText(
            getCurrency(serviceM.price),
            maxLines: 5,
            size: 7,
            isBold: true,
            color: AppColors.yellow,
          ),
        ],
      ),
    );
  }
}

class DoItBox extends StatelessWidget {
  DoItBox(this.serviceM);
  final ServiceM serviceM;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.yellow.withOpacity(0.15),
        borderRadius: AppStyles.minimalBorderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          JxText(
            serviceM.punch ? 'Scan:' : 'Collect:',
            maxLines: 5,
            size: 3.5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              JxText(
                serviceM.doIt.toString(),
                maxLines: 5,
                size: 7.5,
                isBold: true,
                color: AppColors.yellow,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, bottom: 3),
                child: JxText(
                  serviceM.punch ? 'times' : 'points',
                  size: 3,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class GetItBox extends StatelessWidget {
  GetItBox(this.serviceM);
  final ServiceM serviceM;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.yellow.withOpacity(0.15),
        borderRadius: AppStyles.minimalBorderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          JxText(
            'And get:',
            maxLines: 5,
            size: 3.5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              JxText(
                serviceM.getIt.toString(),
                maxLines: 5,
                size: 7.5,
                isBold: true,
                color: AppColors.yellow,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, bottom: 3),
                child: JxText(
                  'free',
                  size: 3,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

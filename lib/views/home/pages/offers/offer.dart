import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchme/core/size_config.dart';
import 'package:punchme/models/punch_m.dart';
import 'package:punchme/res/app_colors.dart';
import 'package:punchme/res/app_styles.dart';
import 'package:punchme/views/home/pages/offers/offer_ctrller.dart';

class Offer extends StatefulWidget {
  Offer({Key key}) : super(key: key);

  @override
  _OfferState createState() => _OfferState();
}

class _OfferState extends State<Offer> with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    final ctrller = Get.put(OfferCtrller());
    animation = Tween(begin: -20.0, end: 40.0).animate(_controller);
    return Container(
      child: StreamBuilder<List<PunchM>>(
        stream: ctrller.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: 4,
              padding: EdgeInsets.only(bottom: SizeConfig.height * 15),
              separatorBuilder: (_, i) {
                return SizedBox(
                  height: 2,
                );
              },
              itemBuilder: (_, i) {
                final offer = snapshot.data[i];
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
                          height: isSelected
                              ? SizeConfig.height * 30
                              : SizeConfig.height * 12,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      child: Image.network(offer.image,
                                          width: SizeConfig.width * 15)),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(offer.name,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppStyles.idleTxt.copyWith(
                                              color: AppColors.yellow,
                                              fontSize:
                                                  SizeConfig.width * 4.5)),
                                      SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Text(
                                              offer.punch
                                                  ? 'Punch '
                                                  : 'Collect ',
                                              style: AppStyles.idleTxt),
                                          Transform.translate(
                                            offset: isSelected
                                                ? Offset(animation.value,
                                                    SizeConfig.width * 20)
                                                : Offset(0, 0),
                                            child: Text(
                                                offer.offerDo.toString(),
                                                style: AppStyles.idleTxt),
                                          ),
                                          Text(
                                              offer.punch
                                                  ? ' and get '
                                                  : ' points and get ',
                                              style: AppStyles.idleTxt),
                                          Text(offer.offerGet.toString(),
                                              style: AppStyles.idleTxt),
                                          Text(' for free! ',
                                              style: AppStyles.idleTxt),
                                        ],
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
                            ],
                          )),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('SSW');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

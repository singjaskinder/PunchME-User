import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchme/common/minimal_scaffold.dart';
import 'package:punchme/common/text.dart';
import 'package:punchme/res/app_colors.dart';
import 'package:punchme/res/app_styles.dart';
import 'package:punchme/utils/size_config.dart';
import 'history_controller.dart';

class History extends StatelessWidget {
  const History({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HistoryController());
    return JxMinimalScaffold(
      titleText: 'History',
      body: Expanded(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Visibility(
              visible: true,
              child: Container(
                color: AppColors.black,
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.network(
                          'https://lh3.googleusercontent.com/lAJPinE4zkFc2Im7tQfKYVddiYwj_BiaA2C0ZSu2txv4g5sTl3OMKSTK0snsyQMT_3tPRKxTBVpmxhQMAq6x5TQ-EA=w800',
                          width: SizeConfig.width * 25,
                          height: SizeConfig.width * 25,
                          fit: BoxFit.cover,
                        )),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hot Chocolate Coffee',
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.idleTxt.copyWith(
                                color: AppColors.yellow,
                                fontSize: SizeConfig.width * 4.5)),
                        SizedBox(height: 4),
                        Container(
                          child: Text('5 punches remaining for\n1 free coffee',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: AppStyles.idleTxt),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: true,
              child: Container(
                color: AppColors.black,
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.network(
                          'https://i.pinimg.com/originals/78/f1/a5/78f1a5696aeadad40a27f85251fef9c3.jpg',
                          width: SizeConfig.width * 25,
                          height: SizeConfig.width * 25,
                          fit: BoxFit.cover,
                        )),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Fresh Hair Cut',
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.idleTxt.copyWith(
                                color: AppColors.yellow,
                                fontSize: SizeConfig.width * 4.5)),
                        SizedBox(height: 4),
                        Container(
                          child: Text(
                              '200 points remaining for\n1 free hair Cut',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: AppStyles.idleTxt),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Visibility(
              visible: true,
              child: Container(
                color: AppColors.black,
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.network(
                          'https://media4.s-nbcnews.com/j/newscms/2020_09/3246761/plain_pizza_f431dcc55520ce41f835a97a5383f171.fit-760w.jpg',
                          width: SizeConfig.width * 25,
                          height: SizeConfig.width * 25,
                          fit: BoxFit.cover,
                        )),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cheese Pizza',
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.idleTxt.copyWith(
                                color: AppColors.yellow,
                                fontSize: SizeConfig.width * 4.5)),
                        SizedBox(height: 4),
                        Container(
                          child: Text('11 punches completed',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: AppStyles.idleTxt),
                        ),
                        SizedBox(height: 8),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: SizeConfig.width * 8),
                            child: Text('REDEEMED',
                                style: AppStyles.idleTxt.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.width * 4)),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                    color: AppColors.blue, width: 0.8)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: true,
              child: Container(
                color: AppColors.black,
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.network(
                          'https://www.liquor.com/thmb/tVgTKmhOqMwIZtqE_CYlbVwoKnY=/735x0/__opt__aboutcom__coeus__resources__content_migration__liquor__2019__12__31103100__Shirley-Temple-720x720-recipe-659e8198a2e840fc8ab7f48d9de60ad5.jpg',
                          width: SizeConfig.width * 25,
                          height: SizeConfig.width * 25,
                          fit: BoxFit.contain,
                        )),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Refreshing Berry Drink',
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.idleTxt.copyWith(
                                color: AppColors.yellow,
                                fontSize: SizeConfig.width * 4.5)),
                        SizedBox(height: 4),
                        Container(
                          child: Text('8 punches remaining for\n1 free drink',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: AppStyles.idleTxt),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meet_network_image/meet_network_image.dart';
import 'package:punchme/common/sizedbox.dart';
import 'package:punchme/common/text.dart';
import 'package:punchme/res/app_colors.dart';
import 'package:punchme/res/app_styles.dart';
import 'package:punchme/utils/image.dart';
import 'package:punchme/utils/size_config.dart';

import 'buttons.dart';

class JxImagePicker extends StatelessWidget {
  JxImagePicker({
    @required this.onSelected,
    @required this.onRemoved,
    @required this.imageData,
    @required this.isEmpty,
  });

  final Function onSelected;
  final Function onRemoved;
  final String imageData;
  final isEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          JxSizedBox(
            width: 5,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                  child: Container(
                    width: SizeConfig.width * 40,
                    height: SizeConfig.width * 40,
                    decoration: BoxDecoration(
                        color: AppColors.darkerGrey.withOpacity(0.15),
                        borderRadius: AppStyles.minimalBorderRadius,
                        border: Border.all(
                            width: 1.5,
                            color: isEmpty
                                ? AppColors.red
                                : AppColors.darkerGrey.withOpacity(0.15))),
                    child: imageData.contains('http')
                        ? MeetNetworkImage(
                            errorBuilder: (_, e) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: JxText('E',
                                    size: 1.2, color: AppColors.yellow),
                              );
                            },
                            loadingBuilder: (_) {
                              return Padding(
                                padding: const EdgeInsets.all(60),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              );
                            },
                            imageUrl: imageData,
                            width: SizeConfig.width * 14,
                            height: SizeConfig.width * 10,
                            fit: BoxFit.cover,
                          )
                        : Image.memory(base64Decode(imageData),
                            width: SizeConfig.width * 14,
                            height: SizeConfig.width * 10,
                            fit: BoxFit.cover),
                  )),
              Visibility(
                  visible: imageData.isEmpty,
                  child: Icon(Icons.person,
                      color: AppColors.yellow.withOpacity(0.8),
                      size: SizeConfig.width * 10))
            ],
          ),
          JxSizedBox(
            width: 4,
          ),
          Column(
            children: [
              Visibility(
                visible: imageData.isEmpty,
                child: RoundIconBTN(
                  onTap: onSelected,
                  iconData: Icons.attach_file,
                ),
              ),
              JxSizedBox(
                height: 2,
              ),
              Visibility(
                visible: imageData.isNotEmpty,
                child: RoundIconBTN(
                  onTap: onRemoved,
                  iconData: Icons.close,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

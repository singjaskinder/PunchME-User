import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:punchme/common/buttons.dart';
import 'package:punchme/common/header.dart';
import 'package:punchme/res/app_colors.dart';
import 'package:punchme/res/app_styles.dart';

import 'file:///C:/work/punchme/punchme/lib/utils/size_config.dart';

import 'phone_ctrller.dart';

class Phone extends StatelessWidget {
  const Phone({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrller = Get.put(PhoneCtrller());
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          backgroundColor: AppColors.darkerGrey,
          body: SafeArea(
              child: Stack(
            children: [
              BackgroundImage(),
              HeaderClipped(),
              Padding(
                padding: EdgeInsets.all(SizeConfig.width * 5),
                child: Form(
                  key: ctrller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: SizeConfig.height * 16,
                      ),
                      Text('One Last Step',
                          style: AppStyles.idleTxt.copyWith(
                              fontSize: SizeConfig.width * 8,
                              color: AppColors.yellow,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: SizeConfig.width,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                            controller: ctrller.nameCtrl,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                labelText: 'Enter your full name',
                                prefixIcon: Icon(Icons.person)),
                            validator: (val) =>
                                val.isNotEmpty ? null : 'Your full name'),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    right: SizeConfig.width * 5),
                                width: SizeConfig.width * 20,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.5,
                                        color: Colors.grey.withOpacity(0.6)),
                                  ),
                                ),
                                child: Center(
                                  child: Obx(
                                    () => DropdownButton(
                                        value: ctrller.dropdownValue.value,
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.grey.withOpacity(0.6),
                                        ),
                                        items: ctrller.phoneCodes
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (val) =>
                                            ctrller.dropdownValue.value = val),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: TextFormField(
                                    controller: ctrller.phoneCtrl,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        labelText: 'Phone number',
                                        prefixIcon: Icon(Icons.phone)),
                                    validator: (val) => val.isPhoneNumber &&
                                            val.length == 10
                                        ? null
                                        : 'Please enter valid phone number'),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: SizeConfig.width * 3,
                      ),
                      TextIconBTN(
                        enabled: true,
                        onPressed: () => ctrller.checkPhoneNo(),
                        label: 'Send OTP',
                        icondata: Icons.navigate_next,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}

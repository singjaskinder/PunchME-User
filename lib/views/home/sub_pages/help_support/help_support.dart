import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchme/common/minimal_scaffold.dart';
import 'help_support_controller.dart';

class HelpSupport extends StatelessWidget {
  const HelpSupport({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HelpSupportController());
    return JxMinimalScaffold(titleText: 'Help & Support', body: Container());
  }
}

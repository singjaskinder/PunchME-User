import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchme/common/minimal_scaffold.dart';
import 'faq_controller.dart';

class Faq extends StatelessWidget {
  const Faq({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FaqController());
    return JxMinimalScaffold(titleText: 'FAQs', body: Container());
  }
}

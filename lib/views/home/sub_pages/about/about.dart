import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchme/common/minimal_scaffold.dart';
import 'about_controller.dart';

class About extends StatelessWidget {
  const About({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AboutController());
    return JxMinimalScaffold(titleText: 'About', body: Container());
  }
}

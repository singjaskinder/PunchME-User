import 'package:flutter/material.dart';
import 'package:punchme/common/text.dart';
import 'package:punchme/res/app_colors.dart';

class JxMinimalScaffold extends StatelessWidget {
  const JxMinimalScaffold(
      {@required this.titleText, @required this.body, Key key})
      : super(key: key);
  final String titleText;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkerGrey,
      appBar: AppBar(
          iconTheme: IconThemeData().copyWith(color: AppColors.yellow),
          elevation: 0,
          title:
              JxText(titleText, color: AppColors.yellow, size: 8, isBold: true),
          backgroundColor: Colors.transparent),
      body: Container(
        padding: EdgeInsets.only(top: 15),
        height: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.black.withOpacity(0.3),
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [body],
        ),
      ),
    );
  }
}

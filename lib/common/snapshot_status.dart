import 'package:flutter/material.dart';
import 'package:punchme/common/text.dart';
import 'package:punchme/res/app_styles.dart';

class SnapshotEmpty extends StatelessWidget {
  const SnapshotEmpty(this.text, {Key key}) : super(key: key);
  final text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: JxText(
        text,
        size: 5,
        isCenter: true,
      ),
    );
  }
}

class SnapshotLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

class SnapshotError extends StatelessWidget {
  const SnapshotError({this.text, Key key}) : super(key: key);
  final text;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(text ?? 'Something went wrong...',
            textAlign: TextAlign.center, style: AppStyles.idleTxt));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:punchme/res/app_colors.dart';
import 'package:punchme/res/app_styles.dart';

class TextIconBTN extends StatelessWidget {
  const TextIconBTN({
    @required this.onPressed,
    @required this.label,
    @required this.icondata,
    @required this.enabled,
    Key key,
  }) : super(key: key);
  final Function onPressed;
  final String label;
  final IconData icondata;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => enabled ? onPressed() : null,
      splashColor: AppColors.black.withOpacity(0.4),
      color: enabled ? AppColors.yellow : AppColors.yellow.withOpacity(0.4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            label,
            style: AppStyles.btnTxt,
          ),
          Icon(
            icondata,
            color: AppColors.black,
          )
        ]),
      ),
    );
  }
}

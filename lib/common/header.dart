import 'package:flutter/cupertino.dart';
import 'package:punchme/clippers/trapezium_clipper.dart';
import 'package:punchme/core/size_config.dart';
import 'package:punchme/res/app_colors.dart';
import 'package:punchme/res/app_styles.dart';

class HeaderClipped extends StatelessWidget {
  const HeaderClipped({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TrapeziumClipper(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.18,
        color: AppColors.yellow,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(' Punch  ',
                  style: AppStyles.idleTxt.copyWith(
                      backgroundColor: AppColors.black,
                      fontSize: SizeConfig.width * 8)),
              Text(' ME  ',
                  style: AppStyles.idleTxt.copyWith(
                      backgroundColor: AppColors.black,
                      fontSize: SizeConfig.width * 8))
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: 0.1,
        child: Image.asset(
          'assets/images/seamless.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ));
  }
}

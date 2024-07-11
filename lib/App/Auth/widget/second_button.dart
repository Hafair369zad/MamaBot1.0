import 'package:flutter/material.dart';
import 'package:trestapkmamabot/App/Auth/model/text_style.dart';
import 'package:trestapkmamabot/App/Auth/model/colors.dart';

class Secondbutton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final String? image;
  final Color? txtSecondColor;
  final Color btnSecondColor;
  const Secondbutton({
    Key? key,
    required this.onTap,
    required this.text,
    this.image,
    this.txtSecondColor,
    required this.btnSecondColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        decoration: BoxDecoration(
          color: btnSecondColor,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 1.0, color: borderSplashColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null)
              Image.asset(
                'assets/image/$image',
                height: 25.0,
                width: 60.0,
              ),
            Text(
              text,
              style: txtSecondColor != null
                  ? headline2Sec.copyWith(color: txtSecondColor)
                  : headline2Sec,
            )
          ],
        ),
      ),
    );
  }
}

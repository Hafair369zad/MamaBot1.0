import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trestapkmamabot/App/Auth/model/colors.dart';
import 'package:trestapkmamabot/App/Auth/model/text_style.dart';

Widget textFild({
  required String hintTxt,
  required String image,
  required TextEditingController controller,
  bool isObs = false,
  TextInputType? keyBordType,
  VoidCallback? onTapVisibility,
  double emailIconHeight = 15.0,
  double showHideIconHeight = 20.0,
}) {
  return Container(
    height: 60.0,
    padding: EdgeInsets.symmetric(horizontal: 30.0),
    margin: EdgeInsets.symmetric(
      horizontal: 25.0,
      vertical: 10.0,
    ),
    decoration: BoxDecoration(
      color: blueButtonSplash,
      border: Border.all(width: 1.0, color: borderSplashColor),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 255.0,
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            controller: controller,
            obscureText: isObs,
            keyboardType: keyBordType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintTxt,
              hintStyle: hintStyle,
              contentPadding: EdgeInsets.symmetric(vertical: 16.0),
            ),
            style: fieldText,
          ),
        ),
        InkWell(
          onTap: onTapVisibility,
          child: SvgPicture.asset(
            'assets/icon/$image',
            height: image == 'mail.svg' ? emailIconHeight : showHideIconHeight,
            color: grayText,
          ),
        ),
      ],
    ),
  );
}

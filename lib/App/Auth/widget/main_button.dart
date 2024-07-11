import 'package:flutter/material.dart';
import 'package:trestapkmamabot/App/Auth/model/text_style.dart';

class Mainbutton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final String? image;
  final Color? txtColor;
  final Color btnColor;
  final bool isLoading;

  const Mainbutton({
    Key? key,
    required this.onTap,
    required this.text,
    this.image,
    this.txtColor,
    required this.btnColor,
    this.isLoading = false, required void Function() onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 54.0,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Row(
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
                      style: txtColor != null
                          ? headline2.copyWith(color: txtColor)
                          : headline2,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}

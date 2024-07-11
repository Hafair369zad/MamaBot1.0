import 'package:flutter/material.dart';
import 'package:trestapkmamabot/App/Onboarding/model/color.dart';

class PageBuilderWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imgurl;
  PageBuilderWidget(
      {Key? key,
      required this.title,
      required this.description,
      required this.imgurl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.only(left: 30, right: 30, top: 50),
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textTitleWhiteOnboarding,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textTitleWhiteOnboarding,
                  fontSize: 16,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: Image.asset(imgurl),
          ),
        ],
      ),
    );
  }
}

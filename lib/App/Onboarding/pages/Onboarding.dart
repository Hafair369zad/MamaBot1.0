import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trestapkmamabot/App/Onboarding/model/color.dart';
import 'package:trestapkmamabot/App/Onboarding/data/AllinOnboardModel.dart';
import 'package:trestapkmamabot/App/Auth/pages/SplashloginSignup.dart';
import 'package:trestapkmamabot/App/Onboarding/widget/PageBuilderWidget.dart';
import 'package:trestapkmamabot/App/Onboarding/widget/CustomPageBuilderWidget.dart';
import 'package:trestapkmamabot/App/Onboarding/widget/CustomSecondPageBuilderWidget.dart';

class OnboardScreen extends StatefulWidget {
  OnboardScreen({Key? key}) : super(key: key);

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  List<AllinOnboardModel> allinonboardlist = [
    AllinOnboardModel(
        "assets/images/onboardingAsset(1).png",
        "Akses dukungan dan jawaban kapan saja melalui aplikasi MamaBot",
        "Dukungan Setiap Saat"),
    AllinOnboardModel(
        "assets/images/onboardingAsset(2).png",
        "Dapatkan informasi terbaru dan terpercaya seputar tumbuh kembang anak langsung dari MamaBot",
        "Sumber Informasi Terupdate"),
    AllinOnboardModel(
        "assets/images/onboardingAsset(3).png",
        "Dapatkan konsultasi dengan mudah dan kapan saja melalui aplikasi MamaBot",
        "Konsultasi Dengan Mudah"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentIndex == 1 ? FillWhiteOnboarding : FillOnboarding,
      body: Stack(
        children: [
          Positioned(
            top: -160,
            left: -149,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                color: CirleBLurBlue,
                shape: BoxShape.circle,
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 620,
            left: 300,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                color: CirleBLurRed,
                shape: BoxShape.circle,
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              itemCount: allinonboardlist.length,
              itemBuilder: (context, index) {
                if (index == 1) {
                  return CustomSecondPageBuilderWidget(
                    title: allinonboardlist[index].titlestr,
                    description: allinonboardlist[index].description,
                    imgurl: allinonboardlist[index].imgStr,
                  );
                } else if (index == 2) {
                  return CustomPageBuilderWidget(
                    title: allinonboardlist[index].titlestr,
                    description: allinonboardlist[index].description,
                    imgurl: allinonboardlist[index].imgStr,
                  );
                } else {
                  return PageBuilderWidget(
                    title: allinonboardlist[index].titlestr,
                    description: allinonboardlist[index].description,
                    imgurl: allinonboardlist[index].imgStr,
                  );
                }
              }),
          currentIndex < allinonboardlist.length - 1
              ? Positioned(
                  bottom: 40,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                        child: ElevatedButton(
                          onPressed: () {
                            _pageController.nextPage(
                                duration: Duration(milliseconds: 800),
                                curve: Curves.ease);
                          },
                          child: Text(
                            "Lanjut",
                            style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                color: textButtonOnboarding),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(318, 60),
                            backgroundColor: currentIndex == 1
                                ? BlackButtonOnboarding
                                : BlueButtonOnboarding,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            allinonboardlist.length,
                            (index) => buildDot(index: index),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Positioned(
                  bottom: 40,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => SplashLoginSignup(),
                              ),
                            );
                          },
                          child: Text(
                            "Mulai",
                            style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins',
                                color: textButtonOnboarding),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(318, 60),
                            backgroundColor: BlueButtonOnboarding,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            allinonboardlist.length,
                            (index) => buildDot(index: index),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

// Animasi listpage
  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5, top: 10),
      height: 6,
      width: currentIndex == index ? 36 : 6,
      decoration: BoxDecoration(
        color: currentIndex == 1
            ? currentIndex == index
                ? BlackButtonOnboarding
                : BlueButtonOnboarding
            : currentIndex == index
                ? BlueButtonOnboarding
                : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

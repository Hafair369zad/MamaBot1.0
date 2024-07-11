import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trestapkmamabot/App/Auth/model/colors.dart';
import 'package:trestapkmamabot/App/Auth/model/space.dart';
import 'package:trestapkmamabot/App/Auth/model/text_style.dart';
import 'package:trestapkmamabot/App/Auth/pages/LoginPage.dart';
import 'package:trestapkmamabot/App/Auth/pages/SignupPage.dart';
import 'package:trestapkmamabot/App/Auth/widget/main_buttonSecond.dart';
import 'package:trestapkmamabot/App/Auth/widget/second_button.dart';

class SplashLoginSignup extends StatelessWidget {
  const SplashLoginSignup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FillWhiteOnboarding,
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
          ///////// TEKS //////////
          Container(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.only(left: 30, right: 30, top: 50),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Selamat datang di ',
                            style: TextStyle(
                                color: textBlackButtonOnboarding,
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                height: 1.1,
                                fontFamily: 'Poppins'),
                          ),
                          TextSpan(
                            text: 'Mama',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              height: 1.1,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          TextSpan(
                            text: 'Bot',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              height: 1.1,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 25, right: 25),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      'teman setia Anda dalam memantau tumbuh kembang anak!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textBlackButtonOnboarding,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Image.asset('assets/images/Robot.png'),
                ),
              ],
            ),
          ),

          ///////// BUTTON //////////
          Positioned(
            bottom: 40,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SpaceVH(height: 59.0),
                MainbuttonSec(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  btnColor: BlackButtonOnboarding,
                  text: 'Daftar Sekarang',
                ),
                SpaceVH(height: 15.0),
                Padding(
                  padding: EdgeInsets.only(left: 90, right: 90),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Color.fromARGB(255, 118, 118, 118),
                          thickness: 1.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.0),
                        child: Text(
                          'Atau',
                          style: headlineDotCompSplash,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Color.fromARGB(255, 118, 118, 118),
                          thickness: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SpaceVH(height: 15.0),
                Secondbutton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  btnSecondColor: FillWhiteOnboarding,
                  text: 'Sudah punya akun? Masuk',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

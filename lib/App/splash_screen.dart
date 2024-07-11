import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'Onboarding/model/color.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      checkFirstRun();
    });
  }

  // Fixx sudah bisa pakai Get Storage
  void checkFirstRun() async {
    bool isFirstRun = box.read('isFirstRun') ?? true;

    if (isFirstRun) {
      // Set isFirstRun to false after the first run
      box.write('isFirstRun', false);

      // Navigate to OnboardScreen after the first run
      Navigator.of(context).pushReplacementNamed('/onboarding');
    } else {
      checkLoginStatus();
    }
  }

  // SharedPreferences
  // void checkFirstRun() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool isFirstRun = prefs.getBool('isFirstRun') ?? true;

  //   if (isFirstRun) {
  //     prefs.setBool('isFirstRun', false);

  //     Navigator.of(context).pushReplacementNamed('/onboarding');
  //   } else {
  //     checkLoginStatus();
  //   }
  // }

  void checkLoginStatus() async {
    User? user = _auth.currentUser;
    if (user != null) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      Navigator.of(context).pushReplacementNamed('/splashLoginSignUp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FillOnboarding,
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
            top: 620, // Agar lingkaran hanya terlihat setengah
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logoGradiasi.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 20), // Space between logo and text
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Mama',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextSpan(
                        text: 'Bot',
                        style: TextStyle(
                          color: Color(0xFF53B3E3),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white), // Atur warna sesuai kebutuhan
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

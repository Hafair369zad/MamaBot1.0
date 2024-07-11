library Login;

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trestapkmamabot/App/Auth/services/firebase_auth_services.dart';
import 'package:trestapkmamabot/App/Auth/model/colors.dart';
import 'package:trestapkmamabot/App/Auth/model/space.dart';
import 'package:trestapkmamabot/App/Auth/model/text_style.dart';
import 'package:trestapkmamabot/App/Auth/pages/SignupPage.dart';
import 'package:trestapkmamabot/App/Auth/widget/main_button.dart';
import 'package:trestapkmamabot/App/Auth/widget/text_fild.dart';
part '../widget/background_content.dart';
part '../widget/background_image.dart';
part '../widget/headerLogin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPass = TextEditingController();
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool isObscure = true;

  void toggleObscure() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  void dispose() {
    userEmail.dispose();
    userPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FillWhite,
      body: Stack(
        children: [
          _BackgroundImage(),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                _Header(),
                Align(
                  alignment: Alignment.topCenter,
                  child: _BackgroundContent(
                    child: Padding(
                      padding: EdgeInsets.only(top: 76.0),
                      child: Column(
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Halo',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'Poppins',
                                    height: 1.1,
                                    wordSpacing: 1.1,
                                  ),
                                ),
                                TextSpan(
                                  text: ' pengguna',
                                  style: TextStyle(
                                    color: BlueButtonOnboarding,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'Poppins',
                                    height: 1.1,
                                    wordSpacing: 1.1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SpaceVH(height: 5.0),
                          Container(
                            margin: const EdgeInsets.only(left: 25, right: 25),
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Text(
                              'Selamat datang kembali, kamu sudah lama dirindukan',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: textBlackButtonOnboarding,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          //

                          // MAIN FORM
                          SpaceVH(height: 100.0),
                          textFild(
                            controller: userEmail,
                            image: 'mail.svg',
                            hintTxt: 'Alamat Email',
                            emailIconHeight: 15.0,
                          ),
                          Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              textFild(
                                controller: userPass,
                                image: isObscure ? 'hide.svg' : 'show.svg',
                                isObs: isObscure,
                                hintTxt: 'Kata Sandi',
                                onTapVisibility: toggleObscure,
                                showHideIconHeight: 20.0,
                              ),
                            ],
                          ),
                          SpaceVH(height: 36.0),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              children: [
                                Mainbutton(
                                  onTap: () {
                                    _signIn();
                                  },
                                  isLoading: _isSigning,
                                  text: 'MASUK',
                                  btnColor: NewMainBgButton,
                                  onPressed: () {},
                                ),
                                SpaceVH(height: 25.0),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUpPage(),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Belum punya akun? ',
                                          style: headline4.copyWith(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' Daftar',
                                          style: headlineDot.copyWith(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Align
                        ],
                      ),
                    ),
                  ),
                  // Akhir Background Content
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = userEmail.text;
    String password = userPass.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      _showSnackBar("Anda berhasil masuk !!");
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/home",
        (Route<dynamic> route) => false, // This removes all the previous routes
      );
    } else {
      _showSnackBar("some error occured");
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

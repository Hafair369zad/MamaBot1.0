library Signup;

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trestapkmamabot/App/Main/Messages/services/firestore_service.dart';
import 'package:trestapkmamabot/App/Auth/services/firebase_auth_services.dart';
import 'package:trestapkmamabot/App/Auth/model/colors.dart';
import 'package:trestapkmamabot/App/Auth/model/space.dart';
import 'package:trestapkmamabot/App/Auth/model/text_style.dart';
import 'package:trestapkmamabot/App/Auth/widget/main_button.dart';
import 'package:trestapkmamabot/App/Auth/widget/text_fild.dart';
import 'package:trestapkmamabot/App/Auth/pages/LoginPage.dart';

part '../widget/background_contentSignup.dart';
part '../widget/background_imageSignup.dart';
part '../widget/headerSignup.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirestoreService _firestoreService = FirestoreService();

  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPass = TextEditingController();

  bool isSigningUp = false;
  bool isObscure = true; // For password visibility

  void toggleObscure() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  void dispose() {
    userName.dispose();
    userEmail.dispose();
    userPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FillOnboarding,
      body: Stack(
        children: [
          _BackgroundImageSignup(),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    _HeaderSignup(),
                    Align(
                      alignment: Alignment.topCenter,
                      child: _BackgroundContentSignup(
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
                                margin:
                                    const EdgeInsets.only(left: 25, right: 25),
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
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
                              SpaceVH(height: 25.0),
                              // MAIN FORM USERNAME
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 25),
                                    child: Text(
                                      'Nama Pengguna',
                                      style: headlineTextField,
                                    ),
                                  ),
                                  textFild(
                                    controller: userName,
                                    image: 'user.svg',
                                    keyBordType: TextInputType.name,
                                    hintTxt: 'Contoh : Hamdan Fairuz',
                                  ),
                                  //

                                  // MAIN FORM EMAIL
                                  Container(
                                    margin: EdgeInsets.only(left: 25),
                                    child: Text(
                                      'Alamat Email',
                                      style: headlineTextField,
                                    ),
                                  ),
                                  textFild(
                                    controller: userEmail,
                                    keyBordType: TextInputType.emailAddress,
                                    image: 'mail.svg',
                                    hintTxt: 'Contoh : User@gmail.com',
                                  ),
                                  //

                                  // MAIN FORM PASSWORD
                                  Container(
                                    margin: EdgeInsets.only(left: 25),
                                    child: Text(
                                      'Kata sandi',
                                      style: headlineTextField,
                                    ),
                                  ),
                                  textFild(
                                    controller: userPass,
                                    isObs: isObscure,
                                    image: isObscure ? 'hide.svg' : 'show.svg',
                                    onTapVisibility: toggleObscure,
                                    hintTxt: 'Masukkan kata sandi',
                                  ),
                                ],
                              ),
                              //

                              // MAIN BUTTON DAFTAR
                              SpaceVH(height: 25.0),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  children: [
                                    Mainbutton(
                                      onTap: () {
                                        _signUp();
                                      },
                                      text: 'DAFTAR',
                                      btnColor: blueButton,
                                      isLoading: isSigningUp,
                                      onPressed: () {},
                                    ),
                                    SpaceVH(height: 10.0),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()),
                                            (route) => false);
                                      },
                                      child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: 'Sudah punya akun? ',
                                            style: headline4.copyWith(
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' Masuk',
                                            style: headlineDot.copyWith(
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _signUp() async {
    String username = userName.text;
    String email = userEmail.text;
    String password = userPass.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      _showSnackBar("Masukkan data lengkap");
      return;
    }

    setState(() {
      isSigningUp = true;
    });

    try {
      User? user =
          await _auth.signUpWithEmailAndPassword(email, password, username);

      setState(() {
        isSigningUp = false;
      });

      if (user != null) {
        await _firestoreService.createUserDocument(user, username, '');
        _showSnackBar("User telah dibuat !!");
        Navigator.pushNamed(context, "/home");
      } else {
        _showSnackBar("Terjadi kesalahan");
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isSigningUp = false;
      });

      if (e.code == 'email-already-in-use') {
        _showSnackBar("Pengguna telah terdaftar");
      } else {
        _showSnackBar("Pengguna telah terdaftar ${e.message}");
      }
    } catch (e) {
      setState(() {
        isSigningUp = false;
      });
      _showSnackBar("Terjadi kesalahan: $e");
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

library profile;

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trestapkmamabot/App/Auth/model/colors.dart';
import 'package:trestapkmamabot/App/Auth/model/space.dart';
import 'package:trestapkmamabot/App/Main/Profile/screen/HelpInfo.dart';
import 'package:trestapkmamabot/App/Main/Profile/screen/info_aplikasi.dart';
import 'package:trestapkmamabot/App/Main/Profile/screen/update_profile_screen.dart';
import 'package:trestapkmamabot/App/Main/Messages/screen/MessageScreen.dart';
import 'package:trestapkmamabot/App/Main/Dashboard/screen/DashboardScreen.dart';
part '../widget/background_image.dart';
part '../widget/header.dart';
part '../widget/background_content.dart';
part '../widget/Bottom_navbar.dart';
part '../widget/Web_maintenance.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  String _photoURL = '';
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
      user = FirebaseAuth.instance.currentUser;

      setState(() {
        _usernameController.text = user?.displayName ?? '';
        _emailController.text = user?.email ?? '';
        _photoURL = user?.photoURL ?? '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FillOnboarding,
      body: Stack(
        children: [
          _BackgroundImage(),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: 50),
                _Header(),
                SizedBox(height: 20),
                _BackgroundContent(
                  child: Column(
                    children: [
                      // //////////////////////// info User ////////////////////////
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 25, bottom: 20),
                            child: Text(
                              'Profile',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 25, right: 25),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                _UserInfo(
                                  usernameController: _usernameController,
                                  emailController: _emailController,
                                  photoURL: _photoURL,
                                  onUpdateProfile: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateProfileScreen(),
                                      ),
                                    );
                                    _loadUserData();
                                  },
                                ),
                                SizedBox(width: 40),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // ////////////////////////// Info user //////////////////////////

                      // ////////////////////////// Profile Bar //////////////////////////
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => _WebMaintenance(),
                            ),
                          );
                        },
                        child: Container(
                          width: 650,
                          height: 250,
                          // padding: const EdgeInsets.only(right: 25.0, left: 15.0, top: 0),
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    right: 25.0, left: 25.0, top: 58),
                                child: Image.asset(
                                  'assets/images/profileBar(2).png',
                                  alignment: Alignment.center,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 50.0, right: 45.0, top: 80.0),
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                'Pantau Terus,                                                                                ', // jangan dihapus
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 0.5,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Website Kami !!!',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 0.5,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ],
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 50.0, top: 30.0),
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                'Dapatkan pembaruan aplikasi,                                                                               ', // jangan dihapus
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 0.5,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'secara berkala',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 0.5,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ],
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: -5,
                                right: 0,
                                width: 181.46,
                                height: 202.15,
                                child: Image.asset(
                                    'assets/images/NewRobotMamabot2.png'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // // /////////////// Profile Bar ///////////////////,

// ///////////////// Profile App ////////////////////
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InfoAplikasi(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 20, left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Icon(
                                      Icons.info,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Info Aplikasi',
                                      style: TextStyle(
                                        color: FillOnboarding,
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: blueButton,
                                thickness: 1.0,
                                indent: 20,
                                endIndent: 20,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SpaceVH(height: 10),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HelpInfo(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 20, left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Icon(
                                      Icons.headset,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Bantuan & Masukan',
                                      style: TextStyle(
                                        color: FillOnboarding,
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: blueButton,
                                thickness: 1.0,
                                indent: 20,
                                endIndent: 20,
                              ),
                            ],
                          ),
                        ),
                      ),

// /////////////// PROFILE APP ////////////////////
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: _BottomNavbar(),
    );
  }
}

class _UserInfo extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final String photoURL;
  final VoidCallback onUpdateProfile;

  _UserInfo({
    required this.usernameController,
    required this.emailController,
    required this.photoURL,
    required this.onUpdateProfile,
  });

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: BlueButtonOnboarding, width: 3),
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: photoURL.isNotEmpty
                      ? NetworkImage(photoURL)
                      : AssetImage('assets/default_profile.png')
                          as ImageProvider<Object>?,
                ),
              ),
              SizedBox(width: 10),
              Container(
                margin: EdgeInsets.only(top: 5),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${usernameController.text}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      maxLines: 2,
                    ),
                    Text(
                      '${emailController.text}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: onUpdateProfile,
                      child: Container(
                        margin: EdgeInsets.only(left: 0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: FillWhiteOnboarding,
                          border: Border.all(color: blueButton, width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.edit,
                            size: 20,
                            color: BlueButtonOnboarding,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Text('User not logged in');
  }
}

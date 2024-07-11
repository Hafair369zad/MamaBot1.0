import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trestapkmamabot/App/Auth/model/colors.dart';
import 'package:trestapkmamabot/App/Auth/model/space.dart';

class InfoBrain extends StatelessWidget {
  const InfoBrain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FillOnboarding,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '',
          style: TextStyle(
            color: white,
          ),
        ),
        backgroundColor: black,
      ),
      body: Stack(
        children: [
          Positioned(
            top: -90,
            left: -149,
            child: Container(
              width: 200,
              height: 200,
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
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 150, vertical: 20),
                    child: Image.asset(
                      'assets/images/logoBlue.png',
                      width: 150,
                      height: 150,
                    ),
                  ),
                  SpaceVH(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'Bantuan dan masukan dapat dikirim melalui:\n\n     Email            : hams.fairuz963@gmail.com\n     Instagram : @hams.96_\n\nTerima kasih atas partisipasi dan kontribusinya!',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SpaceVH(height: 400),
                  Center(
                    child: Text(
                      'Version: MamaBot.AI 1.0',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SpaceVH(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

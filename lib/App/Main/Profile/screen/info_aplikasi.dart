import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trestapkmamabot/App/Auth/model/colors.dart';
import 'package:trestapkmamabot/App/Auth/model/space.dart';

class InfoAplikasi extends StatelessWidget {
  const InfoAplikasi({super.key});

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
          'Info Aplikasi',
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
                            text: 'Mama',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          TextSpan(
                            text: 'Bot',
                            style: TextStyle(
                              color: Color(0xFF53B3E3),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          TextSpan(
                            text:
                                ' adalah aplikasi chatbot berbasis mobile yang dikembangkan oleh mahasiswa akhir Teknik Informatika Politeknik Elektronika Negeri Surabaya (PENS). Aplikasi ini dirancang untuk membantu orang tua memantau dan memahami tumbuh kembang anak mereka.\n\n',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          TextSpan(
                            text:
                                'Mengambil informasi dari buku Kesehatan Ibu dan Anak (KIA) serta buku Stimulasi, Deteksi, dan Intervensi Dini Tumbuh Kembang Anak (SDIDTK), MamaBot.AI memberikan panduan komprehensif mengenai kesehatan fisik, perkembangan kognitif, dan emosional anak. Dengan antarmuka yang user-friendly, orang tua dapat dengan mudah berinteraksi dengan chatbot untuk mendapatkan jawaban dan saran praktis.\n\n',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          TextSpan(
                            text:
                                'Tujuan utama MamaBot adalah mendukung orang tua dalam proses pengasuhan dan pendidikan anak, membantu mendeteksi dini masalah kesehatan atau perkembangan, serta memberikan rekomendasi yang tepat. Menggunakan teknologi canggih, MamaBot.AI siap menjadi asisten virtual andal dalam perjalanan tumbuh kembang anak Anda.',
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
                  SpaceVH(height: 70),
                  Center(
                    child: Text(
                      'Version: MamaBot 1.0',
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

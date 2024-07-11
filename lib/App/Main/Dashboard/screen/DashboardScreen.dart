library dashboard;

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trestapkmamabot/App/Main/Messages/screen/MessageScreen.dart';
import 'package:trestapkmamabot/App/Main/Messages/services/firestore_service.dart';
import 'package:trestapkmamabot/App/Auth/services/firebase_auth_services.dart';
import 'package:trestapkmamabot/App/Main/Dashboard/model/color.dart';
import 'package:trestapkmamabot/App/Main/Profile/screen/profile_screen.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import 'package:trestapkmamabot/App/Main/Messages/controller/chatbot_controller.dart';

// Widget/Component
part '../widget/background_image.dart';
part '../widget/header.dart';
part '../widget/background_content.dart';
part '../widget/Bottom_navbar.dart';
part '../widget/update_fiture.dart';
part '../widget/update_service.dart';
part '../widget/history_chat.dart';
part '../widget/Allhistory_chat.dart';
part '../widget/HistoryMessageScreen.dart';

class DashboardScreen extends StatelessWidget {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirestoreService _firestoreService = FirestoreService();
  DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = _authService.getCurrentUser();

    return StreamBuilder<DocumentSnapshot>(
      stream: _firestoreService.getUserDocumentStream(user?.uid ?? ''),
      builder: (context, snapshot) {
        bool isLoading = !snapshot.hasData || snapshot.data == null;
        String username = '';
        String profilePictureUrl =
            'path/to/default_profile.png';

        if (!isLoading) {
          var data = snapshot.data!.data() as Map<String, dynamic>?;
          if (data != null) {
            username = data['username'] ?? '';
            profilePictureUrl =
                data['photoURL'] ?? 'path/to/default_profile.png';
          }
        }

        return Scaffold(
          backgroundColor: FillOnboarding,
          body: Stack(
            children: [
              _BackgroundImage(),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    _Header(
                      authService: _authService,
                      firestoreService: _firestoreService,
                      isLoading: isLoading,
                      profilePictureUrl: profilePictureUrl,
                    ),
                    SizedBox(height: 15),
                    _BackgroundContent(
                      child: Column(
                        children: [
                          _updateFiture(
                              username: username, isLoading: isLoading),
                          _updateService(),
                          SizedBox(height: 15),
                          _historyChat(isLoading: isLoading),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: _BottomNavbar(),
        );
      },
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trestapkmamabot/App/Auth/pages/SplashloginSignup.dart';
import 'package:trestapkmamabot/App/Auth/pages/LoginPage.dart';
import 'package:trestapkmamabot/App/Auth/pages/SignupPage.dart';
import 'package:trestapkmamabot/App/Main/Dashboard/screen/DashboardScreen.dart';
import 'package:trestapkmamabot/App/Onboarding/pages/Onboarding.dart';
import 'package:trestapkmamabot/App/splash_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MamaBot',
      theme: ThemeData(brightness: Brightness.light),
      initialRoute: '/', // Set initial route to '/'
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => DashboardScreen(),
        '/onboarding': (context) => OnboardScreen(),
        '/splashLoginSignUp': (context) => SplashLoginSignup(),
      },
    );
  }
}
